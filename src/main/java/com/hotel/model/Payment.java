package com.hotel.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Payment {

    private int paymentID;
    private int bookingID;
    private String paymentMethod;
    private BigDecimal amount;
    private String transactionCode;
    private String paymentStatus;
    private Timestamp paymentDate;
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