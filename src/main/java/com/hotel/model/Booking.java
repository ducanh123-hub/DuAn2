package com.hotel.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Booking {

    private int bookingID;
    private int userID;
    private int roomID;
    private Integer voucherID; // Có thể null
    private String bookingCode;
    private Date checkInDate;
    private Date checkOutDate;
    private int adults;
    private int children;
    private BigDecimal roomPrice;
    private BigDecimal servicePrice;
    private BigDecimal discountAmount;
    private BigDecimal totalAmount;
    private String bookingStatus;
    private String paymentStatus;
    private String note;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Booking() {
    }

    public Booking(int bookingID, int userID, int roomID, Integer voucherID,
                   String bookingCode, Date checkInDate, Date checkOutDate,
                   int adults, int children, BigDecimal roomPrice,
                   BigDecimal servicePrice, BigDecimal discountAmount,
                   BigDecimal totalAmount, String bookingStatus,
                   String paymentStatus, String note,
                   Timestamp createdAt, Timestamp updatedAt) {
        this.bookingID = bookingID;
        this.userID = userID;
        this.roomID = roomID;
        this.voucherID = voucherID;
        this.bookingCode = bookingCode;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.adults = adults;
        this.children = children;
        this.roomPrice = roomPrice;
        this.servicePrice = servicePrice;
        this.discountAmount = discountAmount;
        this.totalAmount = totalAmount;
        this.bookingStatus = bookingStatus;
        this.paymentStatus = paymentStatus;
        this.note = note;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
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

    public Integer getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(Integer voucherID) {
        this.voucherID = voucherID;
    }

    public String getBookingCode() {
        return bookingCode;
    }

    public void setBookingCode(String bookingCode) {
        this.bookingCode = bookingCode;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public int getAdults() {
        return adults;
    }

    public void setAdults(int adults) {
        this.adults = adults;
    }

    public int getChildren() {
        return children;
    }

    public void setChildren(int children) {
        this.children = children;
    }

    public BigDecimal getRoomPrice() {
        return roomPrice;
    }

    public void setRoomPrice(BigDecimal roomPrice) {
        this.roomPrice = roomPrice;
    }

    public BigDecimal getServicePrice() {
        return servicePrice;
    }

    public void setServicePrice(BigDecimal servicePrice) {
        this.servicePrice = servicePrice;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Booking{" +
                "bookingID=" + bookingID +
                ", bookingCode='" + bookingCode + '\'' +
                ", userID=" + userID +
                ", roomID=" + roomID +
                ", totalAmount=" + totalAmount +
                ", bookingStatus='" + bookingStatus + '\'' +
                '}';
    }
}