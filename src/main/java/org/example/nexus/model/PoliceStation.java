package org.example.nexus.model;


import java.sql.Timestamp;

public class PoliceStation {

    private int policeStationId;
    private String stationName;
    private String location;
    private String jurisdictionArea;
    private String contactNumber;
    private String email;
    private Timestamp createdOn;

    public PoliceStation() {}

    public PoliceStation(int policeStationId, String stationName, String location, String jurisdictionArea,
                         String contactNumber, String email, Timestamp createdOn) {
        this.policeStationId = policeStationId;
        this.stationName = stationName;
        this.location = location;
        this.jurisdictionArea = jurisdictionArea;
        this.contactNumber = contactNumber;
        this.email = email;
        this.createdOn = createdOn;
    }

    // Getters & Setters

    public int getPoliceStationId() { return policeStationId; }
    public void setPoliceStationId(int policeStationId) { this.policeStationId = policeStationId; }

    public String getStationName() { return stationName; }
    public void setStationName(String stationName) { this.stationName = stationName; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getJurisdictionArea() { return jurisdictionArea; }
    public void setJurisdictionArea(String jurisdictionArea) { this.jurisdictionArea = jurisdictionArea; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Timestamp getCreatedOn() { return createdOn; }
    public void setCreatedOn(Timestamp createdOn) { this.createdOn = createdOn; }

    @Override
    public String toString() {
        return stationName + " (" + policeStationId + ")";
    }


}
