package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.BookingDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDetailDAO implements BaseDAO<BookingDetail> {

    private BookingDetail mapRow(ResultSet rs) throws SQLException {
        BookingDetail d = new BookingDetail();
        d.setDetailID(rs.getInt("DetailID"));
        d.setBookingID(rs.getInt("BookingID"));
        d.setRoomID(rs.getInt("RoomID"));
        d.setPrice(rs.getBigDecimal("Price"));
        d.setQuantity(rs.getInt("Quantity"));
        d.setDiscount(rs.getBigDecimal("Discount"));
        d.setTotalPrice(rs.getBigDecimal("TotalPrice"));

        // Field phụ từ JOIN với Room
        try { d.setRoomName(rs.getString("RoomName")); } catch (SQLException ignored) {}
        try { d.setRoomNumber(rs.getString("RoomNumber")); } catch (SQLException ignored) {}

        return d;
    }

    @Override
    public List<BookingDetail> getAll() {
        List<BookingDetail> list = new ArrayList<>();
        String sql = """
            SELECT bd.*, r.RoomName, r.RoomNumber
            FROM Booking_Detail bd
            LEFT JOIN Room r ON bd.RoomID = r.RoomID
            """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public BookingDetail getById(int id) {
        String sql = """
            SELECT bd.*, r.RoomName, r.RoomNumber
            FROM Booking_Detail bd
            LEFT JOIN Room r ON bd.RoomID = r.RoomID
            WHERE bd.DetailID = ?
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

    public List<BookingDetail> getByBookingId(int bookingId) {
        List<BookingDetail> list = new ArrayList<>();
        String sql = """
            SELECT bd.*, r.RoomName, r.RoomNumber
            FROM Booking_Detail bd
            LEFT JOIN Room r ON bd.RoomID = r.RoomID
            WHERE bd.BookingID = ?
            """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean insert(BookingDetail detail) {
        String sql = """
            INSERT INTO Booking_Detail (BookingID, RoomID, Price, Quantity, Discount, TotalPrice)
            VALUES (?, ?, ?, ?, ?, ?)
            """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, detail.getBookingID());
            ps.setInt(2, detail.getRoomID());
            ps.setBigDecimal(3, detail.getPrice());
            ps.setInt(4, detail.getQuantity());
            ps.setBigDecimal(5, detail.getDiscount());
            ps.setBigDecimal(6, detail.getTotalPrice());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(BookingDetail detail) {
        String sql = """
            UPDATE Booking_Detail SET
                RoomID     = ?,
                Price      = ?,
                Quantity   = ?,
                Discount   = ?,
                TotalPrice = ?
            WHERE DetailID = ?
            """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, detail.getRoomID());
            ps.setBigDecimal(2, detail.getPrice());
            ps.setInt(3, detail.getQuantity());
            ps.setBigDecimal(4, detail.getDiscount());
            ps.setBigDecimal(5, detail.getTotalPrice());
            ps.setInt(6, detail.getDetailID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Booking_Detail WHERE DetailID = ?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}