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
    private int favoriteCount;

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
        if (description == null || description.trim().isEmpty()
                || "Phòng gia đình dành cho nhóm đông người".equals(description.trim())
                || "Phòng Deluxe rộng rãi, tiện nghi đầy đủ".equals(description.trim())
                || "Phòng Suite cao cấp".equals(description.trim())
                || "Phòng tiêu chuẩn, đầy đủ tiện nghi cơ bản".equals(description.trim())
                || "Phòng tiêu chuẩn".equals(description.trim())) {
            if (roomName != null) {
                if (roomName.contains("Family")) {
                    return "Phòng Family rộng rãi, thiết kế hiện đại, phù hợp cho gia đình hoặc nhóm bạn. Không gian thoáng mát, đầy đủ tiện nghi, mang đến trải nghiệm nghỉ dưỡng thoải mái.";
                } else if (roomName.contains("Deluxe")) {
                    return "Phòng Deluxe được thiết kế sang trọng và tinh tế, mang đến không gian nghỉ ngơi thoải mái cho các cặp đôi hoặc khách công tác.";
                } else if (roomName.contains("Standard")) {
                    return "Phòng Standard có thiết kế đơn giản, tiện nghi và ấm cúng, phù hợp cho khách hàng tìm kiếm không gian nghỉ ngơi thoải mái với mức giá hợp lý.";
                } else if (roomName.contains("Suite")) {
                    return "Phòng Suite sở hữu không gian rộng rãi và sang trọng, được trang bị đầy đủ tiện nghi, phù hợp cho những kỳ nghỉ cao cấp và thư giãn.";
                }
            }
        }
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

    public int getFavoriteCount() {
        return favoriteCount;
    }

    public void setFavoriteCount(int favoriteCount) {
        this.favoriteCount = favoriteCount;
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