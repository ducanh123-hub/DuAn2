package com.hotel.model;

import java.sql.Date;
import java.sql.Timestamp;

public class User {

    private int userID;
    private int roleID;
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private String gender;
    private Date date;
    private String cccd;
    private String address;
    private String nationality;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public User() {
    }

    public User(int userID, int roleID, String fullName, String email, String phone,
                String password, String gender, Date date, String cccd,
                String address, String nationality, String status,
                Timestamp createdAt, Timestamp updatedAt) {
        this.userID = userID;
        this.roleID = roleID;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.gender = gender;
        this.date = date;
        this.cccd = cccd;
        this.address = address;
        this.nationality = nationality;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
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
        return "User{" +
                "userID=" + userID +
                ", roleID=" + roleID +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", gender='" + gender + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}