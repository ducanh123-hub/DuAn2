package com.hotel.service;

import com.hotel.config.DBConnect;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Service thống kê doanh thu và khách hàng.
 * Truy vấn trực tiếp database để tổng hợp số liệu.
 */
public class ReportService {

    // ================================================================
    // THỐNG KÊ DOANH THU
    // ================================================================

    /**
     * Doanh thu theo ngày trong tháng/năm chỉ định
     */
    public Map<String, BigDecimal> getRevenueByDay(int month, int year) {
        Map<String, BigDecimal> map = new LinkedHashMap<>();
        String sql = """
            SELECT CONVERT(VARCHAR(10), p.PaymentDate, 103) AS Day,
                   SUM(p.Amount) AS Revenue
            FROM Payment p
            WHERE p.Status = N'Đã thanh toán'
              AND MONTH(p.PaymentDate) = ?
              AND YEAR(p.PaymentDate)  = ?
            GROUP BY CONVERT(VARCHAR(10), p.PaymentDate, 103)
            ORDER BY MIN(p.PaymentDate)
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString("Day"), rs.getBigDecimal("Revenue"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * Doanh thu theo tháng trong năm chỉ định
     */
    public Map<String, BigDecimal> getRevenueByMonth(int year) {
        Map<String, BigDecimal> map = new LinkedHashMap<>();
        String sql = """
            SELECT CAST(MONTH(p.PaymentDate) AS VARCHAR) AS Month,
                   SUM(p.Amount) AS Revenue
            FROM Payment p
            WHERE p.Status = N'Đã thanh toán'
              AND YEAR(p.PaymentDate) = ?
            GROUP BY MONTH(p.PaymentDate)
            ORDER BY MONTH(p.PaymentDate)
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put("Tháng " + rs.getString("Month"),
                            rs.getBigDecimal("Revenue"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * Doanh thu theo năm (5 năm gần nhất)
     */
    public Map<String, BigDecimal> getRevenueByYear() {
        Map<String, BigDecimal> map = new LinkedHashMap<>();
        String sql = """
            SELECT CAST(YEAR(p.PaymentDate) AS VARCHAR) AS Year,
                   SUM(p.Amount) AS Revenue
            FROM Payment p
            WHERE p.Status = N'Đã thanh toán'
              AND YEAR(p.PaymentDate) >= YEAR(GETDATE()) - 4
            GROUP BY YEAR(p.PaymentDate)
            ORDER BY YEAR(p.PaymentDate)
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                map.put("Năm " + rs.getString("Year"),
                        rs.getBigDecimal("Revenue"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * Doanh thu theo loại phòng
     */
    public Map<String, BigDecimal> getRevenueByRoomCategory() {
        Map<String, BigDecimal> map = new LinkedHashMap<>();
        String sql = """
            SELECT rc.CategoryName,
                   SUM(p.Amount) AS Revenue
            FROM Payment p
            JOIN Booking b ON p.BookingID = b.BookingID
            JOIN Booking_Detail bd ON b.BookingID = bd.BookingID
            JOIN Room r ON bd.RoomID = r.RoomID
            JOIN Room_Category rc ON r.CategoryID = rc.CategoryID
            WHERE p.Status = N'Đã thanh toán'
            GROUP BY rc.CategoryName
            ORDER BY Revenue DESC
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                map.put(rs.getString("CategoryName"), rs.getBigDecimal("Revenue"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * Tỷ lệ lấp đầy phòng: số phòng đang sử dụng / tổng phòng
     */
    public Map<String, Integer> getRoomOccupancy() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = """
            SELECT Status, COUNT(*) AS Cnt
            FROM Room
            GROUP BY Status
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                map.put(rs.getString("Status"), rs.getInt("Cnt"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    // ================================================================
    // THỐNG KÊ KHÁCH HÀNG
    // ================================================================

    /**
     * Số khách hàng mới trong tháng hiện tại
     */
    public int getNewCustomersThisMonth() {
        String sql = """
            SELECT COUNT(*) FROM [User]
            WHERE RoleID = 3
              AND MONTH(CreatedAt) = MONTH(GETDATE())
              AND YEAR(CreatedAt)  = YEAR(GETDATE())
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Tổng số lượt lưu trú (booking đã hoàn thành)
     */
    public int getTotalCompletedBookings() {
        String sql = """
            SELECT COUNT(*) FROM Booking
            WHERE Status = N'Đã trả phòng'
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Top 10 khách hàng đặt phòng nhiều nhất
     * Trả về: [[FullName, Email, bookingCount]]
     */
    public List<Object[]> getTopCustomers(int limit) {
        List<Object[]> list = new ArrayList<>();
        String sql = """
            SELECT TOP (?) u.FullName, u.Email, u.Phone,
                   COUNT(b.BookingID) AS BookingCount
            FROM [User] u
            JOIN Booking b ON u.UserID = b.UserID
            WHERE u.RoleID = 3
            GROUP BY u.UserID, u.FullName, u.Email, u.Phone
            ORDER BY BookingCount DESC
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Object[]{
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getInt("BookingCount")
                    });
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Thống kê số lượng khách hàng theo tháng (12 tháng gần nhất)
     */
    public Map<String, Integer> getNewCustomersByMonth(int year) {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = """
            SELECT CAST(MONTH(CreatedAt) AS VARCHAR) AS Month,
                   COUNT(*) AS Cnt
            FROM [User]
            WHERE RoleID = 3 AND YEAR(CreatedAt) = ?
            GROUP BY MONTH(CreatedAt)
            ORDER BY MONTH(CreatedAt)
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put("Tháng " + rs.getString("Month"), rs.getInt("Cnt"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * Tổng doanh thu của hệ thống
     */
    public BigDecimal getTotalRevenue() {
        String sql = """
            SELECT COALESCE(SUM(Amount), 0) FROM Payment
            WHERE Status = N'Đã thanh toán'
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
}
