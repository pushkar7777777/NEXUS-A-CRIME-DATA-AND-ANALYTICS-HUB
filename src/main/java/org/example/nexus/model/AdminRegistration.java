package org.example.nexus.model;

import java.sql.Timestamp;

public class AdminRegistration {

    private int regId;
    private String fullName;
    private String email;
    private String passwordHash;
    private String roleRequested;
    private String secretAdminCode;
    private Timestamp createdAt;
    private String approvalStatus;

    public AdminRegistration() {}

    public AdminRegistration(int regId, String fullName, String email, String passwordHash,
                             String roleRequested, String secretAdminCode,
                             Timestamp createdAt, String approvalStatus) {
        this.regId = regId;
        this.fullName = fullName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.roleRequested = roleRequested;
        this.secretAdminCode = secretAdminCode;
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

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getRoleRequested() { return roleRequested; }
    public void setRoleRequested(String roleRequested) { this.roleRequested = roleRequested; }

    public String getSecretAdminCode() { return secretAdminCode; }
    public void setSecretAdminCode(String secretAdminCode) { this.secretAdminCode = secretAdminCode; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(String approvalStatus) { this.approvalStatus = approvalStatus; }

    @Override
    public String toString() {
        return "AdminRegistration{" +
                "regId=" + regId +
                ", fullName='" + fullName + '\'' +
                ", roleRequested='" + roleRequested + '\'' +
                '}';
    }
}
