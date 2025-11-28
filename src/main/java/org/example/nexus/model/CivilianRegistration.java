package org.example.nexus.model;

import java.sql.Timestamp;
import java.time.LocalDate;

public class CivilianRegistration {

    private int regId;
    private String fullName;
    private String email;
    private String phone;
    private String passwordHash;
    private String nationalId;
    private LocalDate dateOfBirth;
    private String gender;
    private Timestamp createdAt;
    private String status;

    // Profile photo (optional column in DB)
    private String profilePhoto;

    public CivilianRegistration() {
        // default empty constructor
    }

    public CivilianRegistration(int regId, String fullName, String email, String phone, String passwordHash, String nationalId, LocalDate localDate, String gender, Timestamp createdAt, String status) {
        this.regId = regId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.passwordHash = passwordHash;
        this.nationalId = nationalId;
        this.dateOfBirth = localDate;
        this.gender = gender;
        this.createdAt = createdAt;
        this.status = status;
    }

    // ============ GETTERS & SETTERS ============ //

    public int getRegId() {
        return regId;
    }

    public void setRegId(int regId) {
        this.regId = regId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getNationalId() {
        return nationalId;
    }

    public void setNationalId(String nationalId) {
        this.nationalId = nationalId;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getProfilePhoto() {
        return profilePhoto;
    }

    public void setProfilePhoto(String profilePhoto) {
        this.profilePhoto = profilePhoto;
    }
}
