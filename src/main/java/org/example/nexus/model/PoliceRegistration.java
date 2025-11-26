package org.example.nexus.model;


import java.sql.Timestamp;

public class PoliceRegistration {

    private int regId;
    private String fullName;
    private String email;
    private String phone;
    private String passwordHash;
    private String rankDetails;
    private int policeStationId;
    private String joiningCode;
    private Timestamp createdAt;
    private String approvalStatus;

    public PoliceRegistration() {}

    public PoliceRegistration(int regId, String fullName, String email, String phone, String passwordHash,
                              String rankDetails, int policeStationId, String joiningCode,
                              Timestamp createdAt, String approvalStatus) {
        this.regId = regId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.passwordHash = passwordHash;
        this.rankDetails = rankDetails;
        this.policeStationId = policeStationId;
        this.joiningCode = joiningCode;
        this.createdAt = createdAt;
        this.approvalStatus = approvalStatus;
    }

    // Getters & Setters

    public int getRegId() { return regId; }
    public void setRegId(int regId) { this.regId = regId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getRankDetails() { return rankDetails; }
    public void setRankDetails(String rankDetails) { this.rankDetails = rankDetails; }

    public int getPoliceStationId() { return policeStationId; }
    public void setPoliceStationId(int policeStationId) { this.policeStationId = policeStationId; }

    public String getJoiningCode() { return joiningCode; }
    public void setJoiningCode(String joiningCode) { this.joiningCode = joiningCode; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(String approvalStatus) { this.approvalStatus = approvalStatus; }

    @Override
    public String toString() {
        return "PoliceRegistration{" +
                "regId=" + regId +
                ", fullName='" + fullName + '\'' +
                ", stationId=" + policeStationId +
                '}';
    }
}
