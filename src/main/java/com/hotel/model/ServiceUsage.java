package com.hotel.model;

import java.math.BigDecimal;

public class ServiceUsage {

    private int usageID;
    private int bookingID;
    private int serviceID;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal totalPrice;

    public ServiceUsage() {
    }

    public ServiceUsage(int usageID, int bookingID, int serviceID,
                        int quantity, BigDecimal unitPrice,
                        BigDecimal totalPrice) {
        this.usageID = usageID;
        this.bookingID = bookingID;
        this.serviceID = serviceID;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
    }

    public int getUsageID() {
        return usageID;
    }

    public void setUsageID(int usageID) {
        this.usageID = usageID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "ServiceUsage{" +
                "usageID=" + usageID +
                ", bookingID=" + bookingID +
                ", serviceID=" + serviceID +
                ", quantity=" + quantity +
                ", totalPrice=" + totalPrice +
                '}';
    }
}