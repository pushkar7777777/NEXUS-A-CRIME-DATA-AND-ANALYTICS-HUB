package org.example.nexus.model;

import java.sql.Timestamp;

public class Activity {

    private String userId;       // CIV-101 / POL-055 etc.
    private String name;         // User name / Civilian name
    private String email;        // Email (if available)
    private String role;         // Civilian / Police / Admin
    private String status;       // Active / Suspended / Approved / Complaint Status
    private String action;       // Example: "Filed Theft Complaint"
    private Timestamp createdAt; // Date/Time of event

    // ------------ GETTERS & SETTERS ------------

    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }


    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }


    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }


    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }


    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }


    public String getAction() {
        return action;
    }
    public void setAction(String action) {
        this.action = action;
    }


    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
