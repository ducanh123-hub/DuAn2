package com.hotel.model;

import java.sql.Time;
import java.sql.Timestamp;

/**
 * Model khớp với bảng System_Setting trong DB:
 * SettingID, HotelName, Address, Phone, Email,
 * CheckinTime, CheckoutTime, CancelPolicy, PaymentMethods,
 * OtherSetting, UpdatedAt
 */
public class SystemSetting {

    private int settingID;
    private String hotelName;
    private String address;
    private String phone;
    private String email;
    private Time checkinTime;
    private Time checkoutTime;
    private String cancelPolicy;
    private String paymentMethods;
    private String otherSetting;
    private Timestamp updatedAt;

    public SystemSetting() {
    }

    public SystemSetting(int settingID, String hotelName, String address,
                         String phone, String email,
                         Time checkinTime, Time checkoutTime,
                         String cancelPolicy, String paymentMethods,
                         String otherSetting, Timestamp updatedAt) {
        this.settingID = settingID;
        this.hotelName = hotelName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.checkinTime = checkinTime;
        this.checkoutTime = checkoutTime;
        this.cancelPolicy = cancelPolicy;
        this.paymentMethods = paymentMethods;
        this.otherSetting = otherSetting;
        this.updatedAt = updatedAt;
    }

    public int getSettingID() {
        return settingID;
    }

    public void setSettingID(int settingID) {
        this.settingID = settingID;
    }

    public String getHotelName() {
        return hotelName;
    }

    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Time getCheckinTime() {
        return checkinTime;
    }

    public void setCheckinTime(Time checkinTime) {
        this.checkinTime = checkinTime;
    }

    public Time getCheckoutTime() {
        return checkoutTime;
    }

    public void setCheckoutTime(Time checkoutTime) {
        this.checkoutTime = checkoutTime;
    }

    public String getCancelPolicy() {
        return cancelPolicy;
    }

    public void setCancelPolicy(String cancelPolicy) {
        this.cancelPolicy = cancelPolicy;
    }

    public String getPaymentMethods() {
        return paymentMethods;
    }

    public void setPaymentMethods(String paymentMethods) {
        this.paymentMethods = paymentMethods;
    }

    public String getOtherSetting() {
        return otherSetting;
    }

    public void setOtherSetting(String otherSetting) {
        this.otherSetting = otherSetting;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "SystemSetting{" +
                "settingID=" + settingID +
                ", hotelName='" + hotelName + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}