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

    // ===============================================================
    // CÁC PHƯƠNG THỨC BỔ SUNG CHO QUẢN LÝ BÌNH LUẬN
    // ===============================================================

    /**
     * Lấy toàn bộ bình luận kèm thông tin khách hàng và tên phòng
     */
    public List<Review> getAllWithDetails() {
        List<Review> list = new ArrayList<>();
        String sql = """
            SELECT r.*, u.FullName AS CustomerName,
                   rm.RoomName, rm.RoomNumber
            FROM Review r
            JOIN [User] u ON r.UserID = u.UserID
            JOIN Room rm ON r.RoomID = rm.RoomID
            ORDER BY r.CreatedAt DESC
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Review review = mapDetail(rs);
                list.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Tìm kiếm bình luận theo tên khách, phòng hoặc nội dung
     */
    public List<Review> search(String keyword, String status) {
        List<Review> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
            SELECT r.*, u.FullName AS CustomerName,
                   rm.RoomName, rm.RoomNumber
            FROM Review r
            JOIN [User] u ON r.UserID = u.UserID
            JOIN Room rm ON r.RoomID = rm.RoomID
            WHERE 1=1
            """);
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.FullName LIKE ? OR rm.RoomName LIKE ? OR r.Comment LIKE ?) ");
            String kw = "%" + keyword.trim() + "%";
            params.add(kw);
            params.add(kw);
            params.add(kw);
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND r.Status = ? ");
            params.add(status.trim());
        }
        sql.append("ORDER BY r.CreatedAt DESC");
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql.toString())
        ) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapDetail(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Cập nhật trạng thái bình luận (Chờ duyệt / Đã duyệt / Ẩn)
     */
    public boolean updateStatus(int reviewId, String status) {
        String sql = "UPDATE Review SET Status = ? WHERE ReviewID = ?";
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, status);
            ps.setInt(2, reviewId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lưu phản hồi của quản lý cho bình luận
     */
    public boolean updateReply(int reviewId, String reply) {
        String sql = "UPDATE Review SET Reply = ?, ReplyAt = GETDATE(), Status = N'Approved' WHERE ReviewID = ?";
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, reply);
            ps.setInt(2, reviewId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Map ResultSet kèm JOIN (có CustomerName, RoomName, RoomNumber)
     */
    private Review mapDetail(ResultSet rs) throws Exception {
        Review review = new Review();
        review.setReviewID(rs.getInt("ReviewID"));
        review.setBookingID(rs.getInt("BookingID"));
        review.setUserID(rs.getInt("UserID"));
        review.setRoomID(rs.getInt("RoomID"));
        review.setRating(rs.getInt("Rating"));
        review.setComment(rs.getString("Comment"));
        review.setReply(rs.getString("Reply"));
        review.setReplyAt(rs.getTimestamp("ReplyAt"));
        review.setCreatedAt(rs.getTimestamp("CreatedAt"));
        review.setStatus(rs.getString("Status"));
        review.setCustomerName(rs.getString("CustomerName"));
        review.setRoomName(rs.getString("RoomName"));
        review.setRoomNumber(rs.getString("RoomNumber"));
        return review;
    }
}
