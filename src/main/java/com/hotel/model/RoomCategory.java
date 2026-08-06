package com.hotel.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class RoomCategory {

    private int categoryID;
    private String categoryName;
    private String description;
    private BigDecimal basePrice;
    private int maxPeople;
    private String status;
    private Timestamp createdAt;

    public RoomCategory() {
    }

    public RoomCategory(int categoryID, String categoryName, String description,
                        BigDecimal basePrice, int maxPeople,
                        String status, Timestamp createdAt) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.description = description;
        this.basePrice = basePrice;
        this.maxPeople = maxPeople;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(BigDecimal basePrice) {
        this.basePrice = basePrice;
    }

    public int getMaxPeople() {
        return maxPeople;
    }

    public void setMaxPeople(int maxPeople) {
        this.maxPeople = maxPeople;
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
        return "RoomCategory{" +
                "categoryID=" + categoryID +
                ", categoryName='" + categoryName + '\'' +
                ", basePrice=" + basePrice +
                ", maxPeople=" + maxPeople +
                ", status='" + status + '\'' +
                '}';
    }
}