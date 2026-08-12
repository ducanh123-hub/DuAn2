package com.hotel.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Room {

    private int roomID;
    private int categoryID;
    private String roomNumber;
    private String roomName;
    private BigDecimal price;
    private BigDecimal acreage;
    private int bed;
    private String area;
    private String description;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Room() {
    }

    public Room(
            int roomID,
            int categoryID,
            String roomNumber,
            String roomName,
            BigDecimal price,
            BigDecimal acreage,
            int bed,
            String area,
            String description,
            String status,
            Timestamp createdAt,
            Timestamp updatedAt
    ) {
        this.roomID = roomID;
        this.categoryID = categoryID;
        this.roomNumber = roomNumber;
        this.roomName = roomName;
        this.price = price;
        this.acreage = acreage;
        this.bed = bed;
        this.area = area;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getAcreage() {
        return acreage;
    }

    public void setAcreage(BigDecimal acreage) {
        this.acreage = acreage;
    }

    public int getBed() {
        return bed;
    }

    public void setBed(int bed) {
        this.bed = bed;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomID=" + roomID +
                ", categoryID=" + categoryID +
                ", roomNumber='" + roomNumber + '\'' +
                ", roomName='" + roomName + '\'' +
                ", price=" + price +
                ", acreage=" + acreage +
                ", bed=" + bed +
                ", area='" + area + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}