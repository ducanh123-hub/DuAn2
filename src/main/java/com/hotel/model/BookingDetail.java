package com.hotel.model;

import java.math.BigDecimal;

public class BookingDetail {

    private int bookingDetailID;
    private int bookingID;
    private int roomID;
    private BigDecimal roomPrice;
    private int numberOfNights;
    private BigDecimal subtotal;

    public BookingDetail() {
    }

    public BookingDetail(int bookingDetailID, int bookingID, int roomID,
                         BigDecimal roomPrice, int numberOfNights,
                         BigDecimal subtotal) {
        this.bookingDetailID = bookingDetailID;
        this.bookingID = bookingID;
        this.roomID = roomID;
        this.roomPrice = roomPrice;
        this.numberOfNights = numberOfNights;
        this.subtotal = subtotal;
    }

    public int getBookingDetailID() {
        return bookingDetailID;
    }

    public void setBookingDetailID(int bookingDetailID) {
        this.bookingDetailID = bookingDetailID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public BigDecimal getRoomPrice() {
        return roomPrice;
    }

    public void setRoomPrice(BigDecimal roomPrice) {
        this.roomPrice = roomPrice;
    }

    public int getNumberOfNights() {
        return numberOfNights;
    }

    public void setNumberOfNights(int numberOfNights) {
        this.numberOfNights = numberOfNights;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    @Override
    public String toString() {
        return "BookingDetail{" +
                "bookingDetailID=" + bookingDetailID +
                ", bookingID=" + bookingID +
                ", roomID=" + roomID +
                ", roomPrice=" + roomPrice +
                ", numberOfNights=" + numberOfNights +
                ", subtotal=" + subtotal +
                '}';
    }
}