package com.hotel.model;

import java.sql.Timestamp;

public class Review {

    private int reviewID;
    private int bookingID;
    private int userID;
    private int roomID;
    private int rating;
    private String comment;
    private Timestamp createdAt;
    private String status;

    public Review() {
    }

    public Review(int reviewID, int bookingID, int userID, int roomID,
                  int rating, String comment,
                  Timestamp createdAt, String status) {
        this.reviewID = reviewID;
        this.bookingID = bookingID;
        this.userID = userID;
        this.roomID = roomID;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.status = status;
    }

    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Review{" +
                "reviewID=" + reviewID +
                ", bookingID=" + bookingID +
                ", userID=" + userID +
                ", roomID=" + roomID +
                ", rating=" + rating +
                ", status='" + status + '\'' +
                '}';
    }
}