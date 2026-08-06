package com.hotel.model;

public class SystemSetting {

    private int settingID;
    private String settingKey;
    private String settingValue;
    private String description;

    public SystemSetting() {
    }

    public SystemSetting(int settingID, String settingKey,
                         String settingValue, String description) {
        this.settingID = settingID;
        this.settingKey = settingKey;
        this.settingValue = settingValue;
        this.description = description;
    }

    public int getSettingID() {
        return settingID;
    }

    public void setSettingID(int settingID) {
        this.settingID = settingID;
    }

    public String getSettingKey() {
        return settingKey;
    }

    public void setSettingKey(String settingKey) {
        this.settingKey = settingKey;
    }

    public String getSettingValue() {
        return settingValue;
    }

    public void setSettingValue(String settingValue) {
        this.settingValue = settingValue;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "SystemSetting{" +
                "settingID=" + settingID +
                ", settingKey='" + settingKey + '\'' +
                '}';
    }
}