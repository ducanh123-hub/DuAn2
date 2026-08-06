package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO implements BaseDAO<Booking> {

    @Override
    public List<Booking> getAll() {

        List<Booking> list = new ArrayList<>();

        String sql = "SELECT * FROM Booking";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Booking booking = new Booking();

                booking.setBookingID(rs.getInt("BookingID"));
                booking.setUserID(rs.getInt("UserID"));
                booking.setBookingCode(rs.getString("BookingCode"));
                booking.setCheckInDate(rs.getDate("CheckInDate"));
                booking.setCheckOutDate(rs.getDate("CheckOutDate"));
                booking.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                booking.setBookingStatus(rs.getString("BookingStatus"));
                booking.setPaymentStatus(rs.getString("PaymentStatus"));
                booking.setCreatedAt(rs.getTimestamp("CreatedAt"));

                list.add(booking);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public Booking getById(int id) {

        String sql = "SELECT * FROM Booking WHERE BookingID=?";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Booking booking = new Booking();

                booking.setBookingID(rs.getInt("BookingID"));
                booking.setUserID(rs.getInt("UserID"));
                booking.setBookingCode(rs.getString("BookingCode"));
                booking.setCheckInDate(rs.getDate("CheckInDate"));
                booking.setCheckOutDate(rs.getDate("CheckOutDate"));
                booking.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                booking.setBookingStatus(rs.getString("BookingStatus"));
                booking.setPaymentStatus(rs.getString("PaymentStatus"));
                booking.setCreatedAt(rs.getTimestamp("CreatedAt"));

                return booking;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean insert(Booking booking) {

        String sql = """
        INSERT INTO Booking(
            UserID,
            RoomID,
            VoucherID,
            BookingCode,
            CheckInDate,
            CheckOutDate,
            Adults,
            Children,
            RoomPrice,
            ServicePrice,
            DiscountAmount,
            TotalAmount,
            BookingStatus,
            PaymentStatus,
            Note
        )
        VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
        """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, booking.getUserID());
            ps.setInt(2, booking.getRoomID());

            if (booking.getVoucherID() == null) {
                ps.setNull(3, Types.INTEGER);
            } else {
                ps.setInt(3, booking.getVoucherID());
            }

            ps.setString(4, booking.getBookingCode());
            ps.setDate(5, booking.getCheckInDate());
            ps.setDate(6, booking.getCheckOutDate());

            ps.setInt(7, booking.getAdults());
            ps.setInt(8, booking.getChildren());

            ps.setBigDecimal(9, booking.getRoomPrice());
            ps.setBigDecimal(10, booking.getServicePrice());
            ps.setBigDecimal(11, booking.getDiscountAmount());
            ps.setBigDecimal(12, booking.getTotalAmount());

            ps.setString(13, booking.getBookingStatus());
            ps.setString(14, booking.getPaymentStatus());
            ps.setString(15, booking.getNote());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean update(Booking booking) {

        String sql = """
            UPDATE Booking
            SET
                CheckInDate=?,
                CheckOutDate=?,
                TotalAmount=?,
                Status=?
            WHERE BookingID=?
            """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setDate(1, booking.getCheckInDate());
            ps.setDate(2, booking.getCheckOutDate());
            ps.setBigDecimal(3, booking.getTotalAmount());
            ps.setString(13, booking.getBookingStatus());
            ps.setString(14, booking.getPaymentStatus());
            ps.setInt(5, booking.getBookingID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean delete(int id) {

        String sql = "DELETE FROM Booking WHERE BookingID=?";

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