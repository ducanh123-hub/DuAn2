package com.hotel.model;

public class RoomAmenity {

    private int roomID;
    private int amenityID;

    public RoomAmenity() {
    }

    public RoomAmenity(int roomID, int amenityID) {
        this.roomID = roomID;
        this.amenityID = amenityID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getAmenityID() {
        return amenityID;
    }

    public void setAmenityID(int amenityID) {
        this.amenityID = amenityID;
    }

    @Override
    public String toString() {
        return "RoomAmenity{" +
                "roomID=" + roomID +
                ", amenityID=" + amenityID +
                '}';
    }
}
