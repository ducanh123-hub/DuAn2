package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Voucher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PromotionDAO implements BaseDAO<Voucher> {

    @Override
    public List<Voucher> getAll() {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM Voucher ORDER BY CreatedAt DESC";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Voucher voucher = new Voucher();
                voucher.setVoucherID(rs.getInt("PromotionID"));
                voucher.setVoucherCode(rs.getString("Code"));
                voucher.setVoucherName(rs.getString("Name"));
                voucher.setDiscountType(rs.getString("DiscountType"));
                voucher.setDiscountValue(rs.getBigDecimal("DiscountValue"));
                voucher.setMaxDiscount(rs.getBigDecimal("MaxDiscountAmount"));
                voucher.setMinOrderValue(rs.getBigDecimal("MinOrderAmount"));
                voucher.setStartDate(rs.getDate("StartDate"));
                voucher.setEndDate(rs.getDate("EndDate"));
                voucher.setQuantity(rs.getInt("UsageLimit"));
                voucher.setStatus(rs.getString("Status"));
                voucher.setCreatedAt(rs.getTimestamp("CreatedAt"));
                list.add(voucher);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Voucher getById(int id) {
        String sql = "SELECT * FROM Voucher WHERE PromotionID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Voucher voucher = new Voucher();
                    voucher.setVoucherID(rs.getInt("PromotionID"));
                    voucher.setVoucherCode(rs.getString("Code"));
                    voucher.setVoucherName(rs.getString("Name"));
                    voucher.setDiscountType(rs.getString("DiscountType"));
                    voucher.setDiscountValue(rs.getBigDecimal("DiscountValue"));
                    voucher.setMaxDiscount(rs.getBigDecimal("MaxDiscountAmount"));
                    voucher.setMinOrderValue(rs.getBigDecimal("MinOrderAmount"));
                    voucher.setStartDate(rs.getDate("StartDate"));
                    voucher.setEndDate(rs.getDate("EndDate"));
                    voucher.setQuantity(rs.getInt("UsageLimit"));
                    voucher.setStatus(rs.getString("Status"));
                    voucher.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    return voucher;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Voucher getByCode(String code) {
        String sql = "SELECT * FROM Voucher WHERE Code = ? AND Status = 'Active'";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Voucher voucher = new Voucher();
                    voucher.setVoucherID(rs.getInt("PromotionID"));
                    voucher.setVoucherCode(rs.getString("Code"));
                    voucher.setVoucherName(rs.getString("Name"));
                    voucher.setDiscountType(rs.getString("DiscountType"));
                    voucher.setDiscountValue(rs.getBigDecimal("DiscountValue"));
                    voucher.setMaxDiscount(rs.getBigDecimal("MaxDiscountAmount"));
                    voucher.setMinOrderValue(rs.getBigDecimal("MinOrderAmount"));
                    voucher.setStartDate(rs.getDate("StartDate"));
                    voucher.setEndDate(rs.getDate("EndDate"));
                    voucher.setQuantity(rs.getInt("UsageLimit"));
                    voucher.setStatus(rs.getString("Status"));
                    voucher.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    return voucher;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(Voucher voucher) {
        String sql = "INSERT INTO Voucher (Code, Name, DiscountType, DiscountValue, MaxDiscountAmount, MinOrderAmount, StartDate, EndDate, UsageLimit, Status, CreatedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, voucher.getVoucherCode());
            ps.setString(2, voucher.getVoucherName());
            ps.setString(3, voucher.getDiscountType());
            ps.setBigDecimal(4, voucher.getDiscountValue());
            ps.setBigDecimal(5, voucher.getMaxDiscount());
            ps.setBigDecimal(6, voucher.getMinOrderValue());
            ps.setDate(7, voucher.getStartDate());
            ps.setDate(8, voucher.getEndDate());
            ps.setInt(9, voucher.getQuantity());
            ps.setString(10, voucher.getStatus() != null ? voucher.getStatus() : "Active");
            ps.setTimestamp(11, voucher.getCreatedAt() != null ? voucher.getCreatedAt() : new Timestamp(System.currentTimeMillis()));
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Voucher voucher) {
        String sql = "UPDATE Voucher SET Code = ?, Name = ?, DiscountType = ?, DiscountValue = ?, MaxDiscountAmount = ?, MinOrderAmount = ?, StartDate = ?, EndDate = ?, UsageLimit = ?, Status = ? WHERE PromotionID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, voucher.getVoucherCode());
            ps.setString(2, voucher.getVoucherName());
            ps.setString(3, voucher.getDiscountType());
            ps.setBigDecimal(4, voucher.getDiscountValue());
            ps.setBigDecimal(5, voucher.getMaxDiscount());
            ps.setBigDecimal(6, voucher.getMinOrderValue());
            ps.setDate(7, voucher.getStartDate());
            ps.setDate(8, voucher.getEndDate());
            ps.setInt(9, voucher.getQuantity());
            ps.setString(10, voucher.getStatus());
            ps.setInt(11, voucher.getVoucherID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Voucher WHERE PromotionID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
