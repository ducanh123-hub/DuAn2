package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.BookingDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDetailDAO implements BaseDAO<BookingDetail> {

    @Override
    public List<BookingDetail> getAll() {
        List<BookingDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM BookingDetail";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                BookingDetail detail = new BookingDetail();
                detail.setBookingDetailID(rs.getInt("BookingDetailID"));
                detail.setBookingID(rs.getInt("BookingID"));
                detail.setRoomID(rs.getInt("RoomID"));
                detail.setRoomPrice(rs.getBigDecimal("RoomPrice"));
                detail.setNumberOfNights(rs.getInt("NumberOfNights"));
                detail.setSubtotal(rs.getBigDecimal("Subtotal"));
                list.add(detail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public BookingDetail getById(int id) {
        String sql = "SELECT * FROM BookingDetail WHERE BookingDetailID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BookingDetail detail = new BookingDetail();
                    detail.setBookingDetailID(rs.getInt("BookingDetailID"));
                    detail.setBookingID(rs.getInt("BookingID"));
                    detail.setRoomID(rs.getInt("RoomID"));
                    detail.setRoomPrice(rs.getBigDecimal("RoomPrice"));
                    detail.setNumberOfNights(rs.getInt("NumberOfNights"));
                    detail.setSubtotal(rs.getBigDecimal("Subtotal"));
                    return detail;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<BookingDetail> getByBookingId(int bookingId) {
        List<BookingDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM BookingDetail WHERE BookingID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingDetail detail = new BookingDetail();
                    detail.setBookingDetailID(rs.getInt("BookingDetailID"));
                    detail.setBookingID(rs.getInt("BookingID"));
                    detail.setRoomID(rs.getInt("RoomID"));
                    detail.setRoomPrice(rs.getBigDecimal("RoomPrice"));
                    detail.setNumberOfNights(rs.getInt("NumberOfNights"));
                    detail.setSubtotal(rs.getBigDecimal("Subtotal"));
                    list.add(detail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean insert(BookingDetail detail) {
        String sql = "INSERT INTO BookingDetail (BookingID, RoomID, RoomPrice, NumberOfNights, Subtotal) VALUES (?, ?, ?, ?, ?)";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, detail.getBookingID());
            ps.setInt(2, detail.getRoomID());
            ps.setBigDecimal(3, detail.getRoomPrice());
            ps.setInt(4, detail.getNumberOfNights());
            ps.setBigDecimal(5, detail.getSubtotal());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(BookingDetail detail) {
        String sql = "UPDATE BookingDetail SET BookingID = ?, RoomID = ?, RoomPrice = ?, NumberOfNights = ?, Subtotal = ? WHERE BookingDetailID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, detail.getBookingID());
            ps.setInt(2, detail.getRoomID());
            ps.setBigDecimal(3, detail.getRoomPrice());
            ps.setInt(4, detail.getNumberOfNights());
            ps.setBigDecimal(5, detail.getSubtotal());
            ps.setInt(6, detail.getBookingDetailID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM BookingDetail WHERE BookingDetailID = ?";
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
