package com.hotel.model;

import java.sql.Timestamp;

public class SystemLog {

    private int logID;
    private Integer userID;
    private String action;
    private String ipAddress;
    private String description;
    private Timestamp createdAt;

    public SystemLog() {
    }

    public SystemLog(int logID, Integer userID, String action,
                     String ipAddress, String description,
                     Timestamp createdAt) {
        this.logID = logID;
        this.userID = userID;
        this.action = action;
        this.ipAddress = ipAddress;
        this.description = description;
        this.createdAt = createdAt;
    }

    public int getLogID() {
        return logID;
    }

    public void setLogID(int logID) {
        this.logID = logID;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "SystemLog{" +
                "logID=" + logID +
                ", userID=" + userID +
                ", action='" + action + '\'' +
                '}';
    }
}