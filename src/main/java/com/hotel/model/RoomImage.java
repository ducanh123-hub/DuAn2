package com.hotel.model;

public class RoomImage {

    private int imageID;
    private int roomID;
    private String imageURL;
    private boolean isMain;
    private int sortOrder;

    public RoomImage() {
    }

    public RoomImage(int imageID, int roomID, String imageURL, boolean isMain, int sortOrder) {
        this.imageID = imageID;
        this.roomID = roomID;
        this.imageURL = imageURL;
        this.isMain = isMain;
        this.sortOrder = sortOrder;
    }

    public int getImageID() {
        return imageID;
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public boolean isMain() {
        return isMain;
    }

    public void setMain(boolean main) {
        isMain = main;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    @Override
    public String toString() {
        return "RoomImage{" +
                "imageID=" + imageID +
                ", roomID=" + roomID +
                ", imageURL='" + imageURL + '\'' +
                ", isMain=" + isMain +
                ", sortOrder=" + sortOrder +
                '}';
    }
}