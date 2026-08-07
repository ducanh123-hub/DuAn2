package com.hotel.model;

public class Amenity {

    private int amenityID;
    private String amenityName;
    private String description;
    private String icon;

    public Amenity() {
    }

    public Amenity(int amenityID, String amenityName, String description, String icon) {
        this.amenityID = amenityID;
        this.amenityName = amenityName;
        this.description = description;
        this.icon = icon;
    }

    public int getAmenityID() {
        return amenityID;
    }

    public void setAmenityID(int amenityID) {
        this.amenityID = amenityID;
    }

    public String getAmenityName() {
        return amenityName;
    }

    public void setAmenityName(String amenityName) {
        this.amenityName = amenityName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    @Override
    public String toString() {
        return "Amenity{" +
                "amenityID=" + amenityID +
                ", amenityName='" + amenityName + '\'' +
                ", description='" + description + '\'' +
                ", icon='" + icon + '\'' +
                '}';
    }
}
