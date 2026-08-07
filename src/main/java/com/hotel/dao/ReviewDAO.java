package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO implements BaseDAO<Review> {

    @Override
    public List<Review> getAll() {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT * FROM Review ORDER BY CreatedAt DESC";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Review review = new Review();
                review.setReviewID(rs.getInt("ReviewID"));
                review.setBookingID(rs.getInt("BookingID"));
                review.setUserID(rs.getInt("UserID"));
                review.setRoomID(rs.getInt("RoomID"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getTimestamp("CreatedAt"));
                review.setStatus(rs.getString("Status"));
                list.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Review getById(int id) {
        String sql = "SELECT * FROM Review WHERE ReviewID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Review review = new Review();
                    review.setReviewID(rs.getInt("ReviewID"));
                    review.setBookingID(rs.getInt("BookingID"));
                    review.setUserID(rs.getInt("UserID"));
                    review.setRoomID(rs.getInt("RoomID"));
                    review.setRating(rs.getInt("Rating"));
                    review.setComment(rs.getString("Comment"));
                    review.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    review.setStatus(rs.getString("Status"));
                    return review;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Review> getByRoomId(int roomId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT * FROM Review WHERE RoomID = ? AND Status = 'Approved' ORDER BY CreatedAt DESC";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReviewID(rs.getInt("ReviewID"));
                    review.setBookingID(rs.getInt("BookingID"));
                    review.setUserID(rs.getInt("UserID"));
                    review.setRoomID(rs.getInt("RoomID"));
                    review.setRating(rs.getInt("Rating"));
                    review.setComment(rs.getString("Comment"));
                    review.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    review.setStatus(rs.getString("Status"));
                    list.add(review);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean insert(Review review) {
        String sql = "INSERT INTO Review (BookingID, UserID, RoomID, Rating, Comment, CreatedAt, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, review.getBookingID());
            ps.setInt(2, review.getUserID());
            ps.setInt(3, review.getRoomID());
            ps.setInt(4, review.getRating());
            ps.setString(5, review.getComment());
            ps.setTimestamp(6, review.getCreatedAt() != null ? review.getCreatedAt() : new Timestamp(System.currentTimeMillis()));
            ps.setString(7, review.getStatus() != null ? review.getStatus() : "Pending");
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Review review) {
        String sql = "UPDATE Review SET BookingID = ?, UserID = ?, RoomID = ?, Rating = ?, Comment = ?, Status = ? WHERE ReviewID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, review.getBookingID());
            ps.setInt(2, review.getUserID());
            ps.setInt(3, review.getRoomID());
            ps.setInt(4, review.getRating());
            ps.setString(5, review.getComment());
            ps.setString(6, review.getStatus());
            ps.setInt(7, review.getReviewID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Review WHERE ReviewID = ?";
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
