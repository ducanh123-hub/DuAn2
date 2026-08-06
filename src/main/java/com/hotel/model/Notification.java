package com.hotel.model;

import java.sql.Timestamp;

public class Notification {

    private int notificationID;
    private int userID;
    private String title;
    private String content;
    private boolean isRead;
    private Timestamp createdAt;

    public Notification() {
    }

    public Notification(int notificationID, int userID, String title,
                        String content, boolean isRead,
                        Timestamp createdAt) {
        this.notificationID = notificationID;
        this.userID = userID;
        this.title = title;
        this.content = content;
        this.isRead = isRead;
        this.createdAt = createdAt;
    }

    public int getNotificationID() {
        return notificationID;
    }

    public void setNotificationID(int notificationID) {
        this.notificationID = notificationID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean read) {
        isRead = read;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Notification{" +
                "notificationID=" + notificationID +
                ", userID=" + userID +
                ", title='" + title + '\'' +
                ", isRead=" + isRead +
                '}';
    }
}