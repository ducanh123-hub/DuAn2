package com.hotel.model;

import java.math.BigDecimal;

public class BookingDetail {

    // Khớp đúng DB: Booking_Detail
    private int detailID;        // DB: DetailID
    private int bookingID;
    private int roomID;
    private BigDecimal price;    // DB: Price (giá/đêm)
    private int quantity;        // DB: Quantity (số đêm)
    private BigDecimal discount; // DB: Discount
    private BigDecimal totalPrice; // DB: TotalPrice

    // Field phụ — JOIN với Room để hiển thị
    private String roomName;
    private String roomNumber;

    public BookingDetail() {}

    // Getters & Setters — DB fields

    public int getDetailID() { return detailID; }
    public void setDetailID(int detailID) { this.detailID = detailID; }

    public int getBookingID() { return bookingID; }
    public void setBookingID(int bookingID) { this.bookingID = bookingID; }

    public int getRoomID() { return roomID; }
    public void setRoomID(int roomID) { this.roomID = roomID; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getDiscount() { return discount; }
    public void setDiscount(BigDecimal discount) { this.discount = discount; }

    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }

    // Getters & Setters — field phụ

    public String getRoomName() { return roomName; }
    public void setRoomName(String roomName) { this.roomName = roomName; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    @Override
    public String toString() {
        return "BookingDetail{detailID=" + detailID
                + ", bookingID=" + bookingID
                + ", roomID=" + roomID
                + ", price=" + price
                + ", quantity=" + quantity
                + ", totalPrice=" + totalPrice + "}";
    }
}