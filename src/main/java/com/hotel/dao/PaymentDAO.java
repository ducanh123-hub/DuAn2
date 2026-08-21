package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO implements BaseDAO<Payment> {

    @Override
    public List<Payment> getAll() {
        List<Payment> list = new ArrayList<>();
        String sql = """
                SELECT p.*, b.BookingCode
                FROM Payment p
                LEFT JOIN Booking b ON p.BookingID = b.BookingID
                ORDER BY p.PaymentDate DESC
    """;
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentID(rs.getInt("PaymentID"));
                payment.setBookingID(rs.getInt("BookingID"));
                payment.setPaymentMethod(rs.getString("Method"));
                payment.setAmount(rs.getBigDecimal("Amount"));
                payment.setTransactionCode(rs.getString("TransactionCode"));
                payment.setPaymentStatus(rs.getString("Status"));
                payment.setPaymentDate(rs.getTimestamp("PaymentDate"));
                payment.setNote(rs.getString("Note"));
                payment.setBookingCode(rs.getString("BookingCode"));
                list.add(payment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Payment getById(int id) {
        String sql = "SELECT * FROM Payment WHERE PaymentID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentID(rs.getInt("PaymentID"));
                    payment.setBookingID(rs.getInt("BookingID"));
                    payment.setPaymentMethod(rs.getString("Method"));
                    payment.setAmount(rs.getBigDecimal("Amount"));
                    payment.setTransactionCode(rs.getString("TransactionCode"));
                    payment.setPaymentStatus(rs.getString("Status"));
                    payment.setPaymentDate(rs.getTimestamp("PaymentDate"));
                    payment.setNote(rs.getString("Note"));
                    return payment;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Payment> getByBookingId(int bookingId) {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM Payment WHERE BookingID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentID(rs.getInt("PaymentID"));
                    payment.setBookingID(rs.getInt("BookingID"));
                    payment.setPaymentMethod(rs.getString("Method"));
                    payment.setAmount(rs.getBigDecimal("Amount"));
                    payment.setTransactionCode(rs.getString("TransactionCode"));
                    payment.setPaymentStatus(rs.getString("Status"));
                    payment.setPaymentDate(rs.getTimestamp("PaymentDate"));
                    payment.setNote(rs.getString("Note"));
                    list.add(payment);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean insert(Payment payment) {
        String sql = "INSERT INTO Payment (BookingID, Method, Amount, TransactionCode, Status, PaymentDate, Note) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, payment.getBookingID());
            ps.setString(2, payment.getPaymentMethod());
            ps.setBigDecimal(3, payment.getAmount());
            ps.setString(4, payment.getTransactionCode());
            ps.setString(5, payment.getPaymentStatus() != null ? payment.getPaymentStatus() : "Chờ thanh toán");
            ps.setTimestamp(6, payment.getPaymentDate() != null ? payment.getPaymentDate() : new Timestamp(System.currentTimeMillis()));
            ps.setString(7, payment.getNote());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Payment payment) {
        String sql = "UPDATE Payment SET BookingID = ?, Method = ?, Amount = ?, TransactionCode = ?, Status = ?, PaymentDate = ?, Note = ? WHERE PaymentID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, payment.getBookingID());
            ps.setString(2, payment.getPaymentMethod());
            ps.setBigDecimal(3, payment.getAmount());
            ps.setString(4, payment.getTransactionCode());
            ps.setString(5, payment.getPaymentStatus());
            ps.setTimestamp(6, payment.getPaymentDate());
            ps.setString(7, payment.getNote());
            ps.setInt(8, payment.getPaymentID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Payment WHERE PaymentID = ?";
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
