package com.hotel.model;

import java.sql.Timestamp;

public class RoomFavorite {

    private int favoriteID;
    private int userID;
    private int roomID;
    private Timestamp createdAt;

    public RoomFavorite() {
    }

    public RoomFavorite(int favoriteID, int userID, int roomID, Timestamp createdAt) {
        this.favoriteID = favoriteID;
        this.userID = userID;
        this.roomID = roomID;
        this.createdAt = createdAt;
    }

    public int getFavoriteID() {
        return favoriteID;
    }

    public void setFavoriteID(int favoriteID) {
        this.favoriteID = favoriteID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "RoomFavorite{" +
                "favoriteID=" + favoriteID +
                ", userID=" + userID +
                ", roomID=" + roomID +
                '}';
    }
}