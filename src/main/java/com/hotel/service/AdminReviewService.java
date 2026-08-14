package com.hotel.service;

import com.hotel.dao.ReviewDAO;
import com.hotel.model.Review;

import java.util.List;

/**
 * Service xử lý nghiệp vụ Quản lý bình luận (dành cho QUAN_LY).
 */
public class AdminReviewService {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    public List<Review> getAllWithDetails() {
        return reviewDAO.getAllWithDetails();
    }

    public Review getById(int id) {
        return reviewDAO.getById(id);
    }

    public List<Review> search(String keyword, String status) {
        return reviewDAO.search(keyword, status);
    }

    /**
     * Duyệt bình luận
     */
    public boolean approve(int reviewId) {
        return reviewDAO.updateStatus(reviewId, "Approved");
    }

    /**
     * Ẩn bình luận vi phạm (không xóa)
     */
    public boolean hide(int reviewId) {
        return reviewDAO.updateStatus(reviewId, "Hidden");
    }

    /**
     * Xóa bình luận vi phạm
     */
    public boolean delete(int reviewId) {
        return reviewDAO.delete(reviewId);
    }

    /**
     * Phản hồi bình luận — tự động chuyển trạng thái sang Approved
     */
    public String reply(int reviewId, String replyText) {
        if (replyText == null || replyText.trim().isEmpty()) {
            return "Nội dung phản hồi không được để trống!";
        }
        boolean ok = reviewDAO.updateReply(reviewId, replyText.trim());
        return ok ? null : "Phản hồi thất bại!";
    }
}
