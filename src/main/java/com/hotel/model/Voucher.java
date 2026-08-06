package com.hotel.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Voucher {

    private int voucherID;
    private String voucherCode;
    private String voucherName;
    private String discountType;
    private BigDecimal discountValue;
    private BigDecimal maxDiscount;
    private BigDecimal minOrderValue;
    private Date startDate;
    private Date endDate;
    private int quantity;
    private String status;
    private Timestamp createdAt;

    public Voucher() {
    }

    public Voucher(int voucherID, String voucherCode, String voucherName,
                   String discountType, BigDecimal discountValue,
                   BigDecimal maxDiscount, BigDecimal minOrderValue,
                   Date startDate, Date endDate,
                   int quantity, String status,
                   Timestamp createdAt) {
        this.voucherID = voucherID;
        this.voucherCode = voucherCode;
        this.voucherName = voucherName;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.maxDiscount = maxDiscount;
        this.minOrderValue = minOrderValue;
        this.startDate = startDate;
        this.endDate = endDate;
        this.quantity = quantity;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getVoucherName() {
        return voucherName;
    }

    public void setVoucherName(String voucherName) {
        this.voucherName = voucherName;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public BigDecimal getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(BigDecimal discountValue) {
        this.discountValue = discountValue;
    }

    public BigDecimal getMaxDiscount() {
        return maxDiscount;
    }

    public void setMaxDiscount(BigDecimal maxDiscount) {
        this.maxDiscount = maxDiscount;
    }

    public BigDecimal getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(BigDecimal minOrderValue) {
        this.minOrderValue = minOrderValue;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "voucherID=" + voucherID +
                ", voucherCode='" + voucherCode + '\'' +
                ", voucherName='" + voucherName + '\'' +
                ", discountValue=" + discountValue +
                ", quantity=" + quantity +
                ", status='" + status + '\'' +
                '}';
    }
}