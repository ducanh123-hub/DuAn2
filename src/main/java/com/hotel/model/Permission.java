package com.hotel.model;

public class Permission {

    private int permissionID;
    private String permissionName;
    private String permissionCode;
    private String description;
    private String status;

    public Permission() {
    }

    public Permission(int permissionID, String permissionName,
                      String permissionCode,
                      String description,
                      String status) {
        this.permissionID = permissionID;
        this.permissionName = permissionName;
        this.permissionCode = permissionCode;
        this.description = description;
        this.status = status;
    }

    public int getPermissionID() {
        return permissionID;
    }

    public void setPermissionID(int permissionID) {
        this.permissionID = permissionID;
    }

    public String getPermissionName() {
        return permissionName;
    }

    public void setPermissionName(String permissionName) {
        this.permissionName = permissionName;
    }

    public String getPermissionCode() {
        return permissionCode;
    }

    public void setPermissionCode(String permissionCode) {
        this.permissionCode = permissionCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}