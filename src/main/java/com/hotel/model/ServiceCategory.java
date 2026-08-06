package com.hotel.model;

public class ServiceCategory {

    private int serviceCategoryID;
    private String categoryName;
    private String description;
    private String status;

    public ServiceCategory() {
    }

    public ServiceCategory(int serviceCategoryID, String categoryName, String description, String status) {
        this.serviceCategoryID = serviceCategoryID;
        this.categoryName = categoryName;
        this.description = description;
        this.status = status;
    }

    public int getServiceCategoryID() {
        return serviceCategoryID;
    }

    public void setServiceCategoryID(int serviceCategoryID) {
        this.serviceCategoryID = serviceCategoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
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

    @Override
    public String toString() {
        return "ServiceCategory{" +
                "serviceCategoryID=" + serviceCategoryID +
                ", categoryName='" + categoryName + '\'' +
                ", description='" + description + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}