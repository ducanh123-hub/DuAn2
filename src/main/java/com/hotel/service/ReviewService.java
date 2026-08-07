package com.hotel.service;

import com.hotel.dao.ReviewDAO;
import com.hotel.model.Review;

import java.util.List;

public class ReviewService {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    public List<Review> getAllReviews() {
        return reviewDAO.getAll();
    }

    public Review getReviewById(int id) {
        return reviewDAO.getById(id);
    }

    public boolean addReview(Review review) {
        return reviewDAO.insert(review);
    }

    public boolean updateReview(Review review) {
        return reviewDAO.update(review);
    }

    public boolean deleteReview(int id) {
        return reviewDAO.delete(id);
    }

    public List<Review> getReviewsByRoomId(int roomId) {
        return reviewDAO.getByRoomId(roomId);
    }
}
