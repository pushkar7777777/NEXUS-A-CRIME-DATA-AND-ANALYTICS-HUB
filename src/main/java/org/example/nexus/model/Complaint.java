package org.example.nexus.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Complaint {

    private int complaintId;
    private int regId;
    private String complaintType;
    private LocalDate dateOfIncident;
    private String locationOfIncident;
    private double latitude;
    private double longitude;
    private String description;
    private String suspectDetails;
    private String victimDetails;
    private String urgencyLevel;
    private LocalDateTime dateFiled;
    private String currentStatus;

    // NEW: Civilian name who filed the complaint
    private String filedBy;

    public int getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(int complaintId) {
        this.complaintId = complaintId;
    }

    public int getRegId() {
        return regId;
    }

    public void setRegId(int regId) {
        this.regId = regId;
    }

    public String getComplaintType() {
        return complaintType;
    }

    public void setComplaintType(String complaintType) {
        this.complaintType = complaintType;
    }

    public LocalDate getDateOfIncident() {
        return dateOfIncident;
    }

    public void setDateOfIncident(LocalDate dateOfIncident) {
        this.dateOfIncident = dateOfIncident;
    }

    public String getLocationOfIncident() {
        return locationOfIncident;
    }

    public void setLocationOfIncident(String locationOfIncident) {
        this.locationOfIncident = locationOfIncident;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSuspectDetails() {
        return suspectDetails;
    }

    public void setSuspectDetails(String suspectDetails) {
        this.suspectDetails = suspectDetails;
    }

    public String getVictimDetails() {
        return victimDetails;
    }

    public void setVictimDetails(String victimDetails) {
        this.victimDetails = victimDetails;
    }

    public String getUrgencyLevel() {
        return urgencyLevel;
    }

    public void setUrgencyLevel(String urgencyLevel) {
        this.urgencyLevel = urgencyLevel;
    }

    public LocalDateTime getDateFiled() {
        return dateFiled;
    }

    public void setDateFiled(LocalDateTime dateFiled) {
        this.dateFiled = dateFiled;
    }

    public String getCurrentStatus() {
        return currentStatus;
    }

    public void setCurrentStatus(String currentStatus) {
        this.currentStatus = currentStatus;
    }

    // 🆕 NEW Getter/Setter
    public String getFiledBy() {
        return filedBy;
    }

    public void setFiledBy(String filedBy) {
        this.filedBy = filedBy;
    }
}
