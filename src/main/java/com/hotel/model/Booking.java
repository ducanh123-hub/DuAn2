package com.hotel.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Booking {

    // Khớp đúng DB
    private int bookingID;
    private int userID;
    private Integer voucherID;
    private String bookingCode;
    private Timestamp bookingDate;
    private Date checkInDate;
    private Date checkOutDate;
    private int guestCount;
    private BigDecimal totalAmount;
    private BigDecimal discountAmount;
    private BigDecimal finalAmount;
    private String cancelReason;
    private Timestamp cancelDate;
    private String status;
    private String note;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Field phụ — KHÔNG lưu DB, dùng để hiển thị JSP
    // Lấy từ JOIN với Booking_Detail và Room
    private int roomID;
    private String roomName;
    private String roomNumber;
    private BigDecimal roomPrice;

    // Field phụ — lấy từ JOIN với User
    private String customerName;
    private String customerPhone;
    private String customerEmail;

    public Booking() {}

    // Getters & Setters — DB fields

    public int getBookingID() { return bookingID; }
    public void setBookingID(int bookingID) { this.bookingID = bookingID; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public Integer getVoucherID() { return voucherID; }
    public void setVoucherID(Integer voucherID) { this.voucherID = voucherID; }

    public String getBookingCode() { return bookingCode; }
    public void setBookingCode(String bookingCode) { this.bookingCode = bookingCode; }

    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }

    public Date getCheckInDate() { return checkInDate; }
    public void setCheckInDate(Date checkInDate) { this.checkInDate = checkInDate; }

    public Date getCheckOutDate() { return checkOutDate; }
    public void setCheckOutDate(Date checkOutDate) { this.checkOutDate = checkOutDate; }

    public int getGuestCount() { return guestCount; }
    public void setGuestCount(int guestCount) { this.guestCount = guestCount; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }

    public BigDecimal getFinalAmount() { return finalAmount; }
    public void setFinalAmount(BigDecimal finalAmount) { this.finalAmount = finalAmount; }

    public String getCancelReason() { return cancelReason; }
    public void setCancelReason(String cancelReason) { this.cancelReason = cancelReason; }

    public Timestamp getCancelDate() { return cancelDate; }
    public void setCancelDate(Timestamp cancelDate) { this.cancelDate = cancelDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    // Getters & Setters — field phụ (JSP display)

    public int getRoomID() { return roomID; }
    public void setRoomID(int roomID) { this.roomID = roomID; }

    public String getRoomName() { return roomName; }
    public void setRoomName(String roomName) { this.roomName = roomName; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public BigDecimal getRoomPrice() { return roomPrice; }
    public void setRoomPrice(BigDecimal roomPrice) { this.roomPrice = roomPrice; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    @Override
    public String toString() {
        return "Booking{bookingID=" + bookingID
                + ", bookingCode='" + bookingCode + "'"
                + ", userID=" + userID
                + ", status='" + status + "'"
                + ", finalAmount=" + finalAmount + "}";
    }
}