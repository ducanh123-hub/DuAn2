package com.hotel.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Payment {

    private int paymentID;
    private int bookingID;
    private String paymentMethod;
    private BigDecimal amount;
    private BigDecimal paidAmount;       // PaidAmount trong DB
    private String transactionCode;
    private String paymentStatus;
    private Timestamp paymentDate;
    private BigDecimal refundAmount;     // RefundAmount trong DB
    private boolean refunda;             // Refunda trong DB (BIT)
    private boolean approved;            // Approved trong DB (BIT)
    private String refundReason;         // RefundReason trong DB
    private String note;

    public Payment() {
    }

    public Payment(int paymentID, int bookingID, String paymentMethod,
                   BigDecimal amount, String transactionCode,
                   String paymentStatus, Timestamp paymentDate,
                   String note) {
        this.paymentID = paymentID;
        this.bookingID = bookingID;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
        this.transactionCode = transactionCode;
        this.paymentStatus = paymentStatus;
        this.paymentDate = paymentDate;
        this.note = note;
    }

    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Timestamp getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public BigDecimal getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    public BigDecimal getRefundAmount() {
        return refundAmount;
    }

    public void setRefundAmount(BigDecimal refundAmount) {
        this.refundAmount = refundAmount;
    }

    public boolean isRefunda() {
        return refunda;
    }

    public void setRefunda(boolean refunda) {
        this.refunda = refunda;
    }

    public boolean isApproved() {
        return approved;
    }

    public void setApproved(boolean approved) {
        this.approved = approved;
    }

    public String getRefundReason() {
        return refundReason;
    }

    public void setRefundReason(String refundReason) {
        this.refundReason = refundReason;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "paymentID=" + paymentID +
                ", bookingID=" + bookingID +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", amount=" + amount +
                ", paymentStatus='" + paymentStatus + '\'' +
                '}';
    }
}