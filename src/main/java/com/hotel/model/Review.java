package com.hotel.model;

import java.sql.Timestamp;

public class Review {

    private int reviewID;
    private int bookingID;
    private int userID;
    private int roomID;
    private int rating;
    private String comment;
    private String reply;       // Phản hồi của quản lý (cột Reply trong DB)
    private Timestamp replyAt;  // Thời điểm phản hồi (cột ReplyAt trong DB)
    private Timestamp createdAt;
    private String status;

    // Field phụ - dùng để hiển thị JSP (JOIN với User, Room)
    private String customerName;
    private String roomName;
    private String roomNumber;

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


    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public Timestamp getReplyAt() {
        return replyAt;
    }

    public void setReplyAt(Timestamp replyAt) {
        this.replyAt = replyAt;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
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