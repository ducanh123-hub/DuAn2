package com.hotel.model;

import java.math.BigDecimal;

public class Service {

    private int serviceID;
    private int serviceCategoryID;
    private String serviceName;
    private String description;
    private BigDecimal price;
    private String status;

    public Service() {
    }

    public Service(int serviceID, int serviceCategoryID, String serviceName,
                   String description, BigDecimal price, String status) {
        this.serviceID = serviceID;
        this.serviceCategoryID = serviceCategoryID;
        this.serviceName = serviceName;
        this.description = description;
        this.price = price;
        this.status = status;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public int getServiceCategoryID() {
        return serviceCategoryID;
    }

    public void setServiceCategoryID(int serviceCategoryID) {
        this.serviceCategoryID = serviceCategoryID;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Service{" +
                "serviceID=" + serviceID +
                ", serviceCategoryID=" + serviceCategoryID +
                ", serviceName='" + serviceName + '\'' +
                ", price=" + price +
                ", status='" + status + '\'' +
                '}';
    }
}