package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO implements BaseDAO<Booking> {

    // Dùng chung cho getAll, getById, getByUserId
    private Booking mapRow(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingID(rs.getInt("BookingID"));
        b.setUserID(rs.getInt("UserID"));
        int vId = rs.getInt("VoucherID");
        b.setVoucherID(rs.wasNull() ? null : vId);
        b.setBookingCode(rs.getString("BookingCode"));
        b.setBookingDate(rs.getTimestamp("BookingDate"));
        b.setCheckInDate(rs.getDate("CheckinDate"));
        b.setCheckOutDate(rs.getDate("CheckoutDate"));
        b.setGuestCount(rs.getInt("GuestCount"));
        b.setTotalAmount(rs.getBigDecimal("TotalAmount"));
        b.setDiscountAmount(rs.getBigDecimal("DiscountAmount"));
        b.setFinalAmount(rs.getBigDecimal("FinalAmount"));
        b.setCancelReason(rs.getString("CancelReason"));
        b.setCancelDate(rs.getTimestamp("CancelDate"));
        b.setStatus(rs.getString("Status"));
        b.setNote(rs.getString("Note"));
        b.setCreatedAt(rs.getTimestamp("CreatedAt"));
        b.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

        // Field phụ từ JOIN
        try { b.setRoomID(rs.getInt("RoomID")); } catch (SQLException ignored) {}
        try { b.setRoomName(rs.getString("RoomName")); } catch (SQLException ignored) {}
        try { b.setRoomNumber(rs.getString("RoomNumber")); } catch (SQLException ignored) {}
        try { b.setRoomPrice(rs.getBigDecimal("RoomPrice")); } catch (SQLException ignored) {}
        try { b.setCustomerName(rs.getString("CustomerName")); } catch (SQLException ignored) {}
        try { b.setCustomerPhone(rs.getString("CustomerPhone")); } catch (SQLException ignored) {}
        try { b.setCustomerEmail(rs.getString("CustomerEmail")); } catch (SQLException ignored) {}

        return b;
    }

    @Override
    public List<Booking> getAll() {
        List<Booking> list = new ArrayList<>();
        String sql = """
            SELECT 
                b.*,
                bd.RoomID,
                bd.Price        AS RoomPrice,
                r.RoomName,
                r.RoomNumber,
                u.FullName      AS CustomerName,
                u.Phone         AS CustomerPhone,
                u.Email         AS CustomerEmail
            FROM Booking b
            LEFT JOIN Booking_Detail bd ON b.BookingID = bd.BookingID
            LEFT JOIN Room r            ON bd.RoomID   = r.RoomID
            LEFT JOIN [User] u          ON b.UserID    = u.UserID
            ORDER BY b.CreatedAt DESC
            """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Booking getById(int id) {
        String sql = """
            SELECT 
                b.*,
                bd.RoomID,
                bd.Price        AS RoomPrice,
                r.RoomName,
                r.RoomNumber,
                u.FullName      AS CustomerName,
                u.Phone         AS CustomerPhone,
                u.Email         AS CustomerEmail
            FROM Booking b
            LEFT JOIN Booking_Detail bd ON b.BookingID = bd.BookingID
            LEFT JOIN Room r            ON bd.RoomID   = r.RoomID
            LEFT JOIN [User] u          ON b.UserID    = u.UserID
            WHERE b.BookingID = ?
            """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(Booking booking) {
        // Bước 1: INSERT Booking, lấy BookingID sinh ra
        String sqlBooking = """
            INSERT INTO Booking (
                UserID, VoucherID, BookingCode,
                CheckinDate, CheckoutDate, GuestCount,
                TotalAmount, DiscountAmount, FinalAmount,
                Status, Note
            ) VALUES (?,?,?,?,?,?,?,?,?,?,?)
            """;

        // Bước 2: INSERT Booking_Detail
        String sqlDetail = """
            INSERT INTO Booking_Detail (
                BookingID, RoomID, Price, Quantity, Discount, TotalPrice
            ) VALUES (?,?,?,1,0,?)
            """;

        try (Connection con = DBConnect.getConnection()) {
            con.setAutoCommit(false);

            try (PreparedStatement ps = con.prepareStatement(
                    sqlBooking, Statement.RETURN_GENERATED_KEYS)) {

                ps.setInt(1, booking.getUserID());
                if (booking.getVoucherID() == null)
                    ps.setNull(2, Types.INTEGER);
                else
                    ps.setInt(2, booking.getVoucherID());
                ps.setString(3, booking.getBookingCode());
                ps.setDate(4, booking.getCheckInDate());
                ps.setDate(5, booking.getCheckOutDate());
                ps.setInt(6, booking.getGuestCount());
                ps.setBigDecimal(7, booking.getTotalAmount());
                ps.setBigDecimal(8, booking.getDiscountAmount());
                ps.setBigDecimal(9, booking.getFinalAmount());
                ps.setString(10, booking.getStatus());
                ps.setString(11, booking.getNote());

                if (ps.executeUpdate() == 0) {
                    con.rollback();
                    return false;
                }

                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        int newBookingId = keys.getInt(1);

                        try (PreparedStatement ps2 =
                                     con.prepareStatement(sqlDetail)) {
                            ps2.setInt(1, newBookingId);
                            ps2.setInt(2, booking.getRoomID());
                            ps2.setBigDecimal(3, booking.getRoomPrice());
                            ps2.setBigDecimal(4, booking.getTotalAmount());
                            ps2.executeUpdate();
                        }
                    }
                }

                con.commit();
                return true;

            } catch (Exception e) {
                con.rollback();
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Booking booking) {
        String sql = """
            UPDATE Booking SET
                CheckinDate     = ?,
                CheckoutDate    = ?,
                GuestCount      = ?,
                TotalAmount     = ?,
                DiscountAmount  = ?,
                FinalAmount     = ?,
                Status          = ?,
                Note            = ?,
                CancelReason    = ?,
                CancelDate      = ?,
                UpdatedAt       = GETDATE()
            WHERE BookingID = ?
            """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, booking.getCheckInDate());
            ps.setDate(2, booking.getCheckOutDate());
            ps.setInt(3, booking.getGuestCount());
            ps.setBigDecimal(4, booking.getTotalAmount());
            ps.setBigDecimal(5, booking.getDiscountAmount());
            ps.setBigDecimal(6, booking.getFinalAmount());
            ps.setString(7, booking.getStatus());
            ps.setString(8, booking.getNote());
            ps.setString(9, booking.getCancelReason());
            ps.setTimestamp(10, booking.getCancelDate());
            ps.setInt(11, booking.getBookingID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        // Xóa Booking_Detail trước (FK constraint)
        String sqlDetail  = "DELETE FROM Booking_Detail WHERE BookingID = ?";
        String sqlBooking = "DELETE FROM Booking WHERE BookingID = ?";
        try (Connection con = DBConnect.getConnection()) {
            con.setAutoCommit(false);
            try (PreparedStatement ps1 = con.prepareStatement(sqlDetail);
                 PreparedStatement ps2 = con.prepareStatement(sqlBooking)) {
                ps1.setInt(1, id);
                ps1.executeUpdate();
                ps2.setInt(1, id);
                ps2.executeUpdate();
                con.commit();
                return true;
            } catch (Exception e) {
                con.rollback();
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Booking> getByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = """
            SELECT 
                b.*,
                bd.RoomID,
                bd.Price        AS RoomPrice,
                r.RoomName,
                r.RoomNumber,
                u.FullName      AS CustomerName,
                u.Phone         AS CustomerPhone,
                u.Email         AS CustomerEmail
            FROM Booking b
            LEFT JOIN Booking_Detail bd ON b.BookingID = bd.BookingID
            LEFT JOIN Room r            ON bd.RoomID   = r.RoomID
            LEFT JOIN [User] u          ON b.UserID    = u.UserID
            WHERE b.UserID = ?
            ORDER BY b.CreatedAt DESC
            """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean isRoomAvailable(int roomId, Date checkIn, Date checkOut) {
        // Kiểm tra qua Booking_Detail vì RoomID không còn trong Booking
        String sql = """
            SELECT COUNT(*)
            FROM Booking b
            JOIN Booking_Detail bd ON b.BookingID = bd.BookingID
            WHERE bd.RoomID    = ?
              AND b.Status    != N'Đã hủy'
              AND b.CheckinDate  < ?
              AND b.CheckoutDate > ?
            """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setDate(2, checkOut);
            ps.setDate(3, checkIn);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) == 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}