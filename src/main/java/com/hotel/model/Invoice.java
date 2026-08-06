package com.hotel.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Invoice {

    private int invoiceID;
    private int bookingID;
    private String invoiceCode;
    private BigDecimal totalAmount;
    private Timestamp createdAt;
    private String status;

    public Invoice() {
    }

    public Invoice(int invoiceID, int bookingID, String invoiceCode,
                   BigDecimal totalAmount, Timestamp createdAt,
                   String status) {
        this.invoiceID = invoiceID;
        this.bookingID = bookingID;
        this.invoiceCode = invoiceCode;
        this.totalAmount = totalAmount;
        this.createdAt = createdAt;
        this.status = status;
    }

    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public String getInvoiceCode() {
        return invoiceCode;
    }

    public void setInvoiceCode(String invoiceCode) {
        this.invoiceCode = invoiceCode;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
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
        return "Invoice{" +
                "invoiceID=" + invoiceID +
                ", invoiceCode='" + invoiceCode + '\'' +
                ", totalAmount=" + totalAmount +
                '}';
    }
}