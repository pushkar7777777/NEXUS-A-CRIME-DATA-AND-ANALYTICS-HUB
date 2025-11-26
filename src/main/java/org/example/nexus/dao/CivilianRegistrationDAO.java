package org.example.nexus.dao;


import org.example.nexus.model.CivilianRegistration;
import org.example.nexus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CivilianRegistrationDAO {

    // INSERT
    public boolean insert(CivilianRegistration civilian) {
        String sql = "INSERT INTO Civilian_Registration(full_name, email, phone, password_hash, national_id, date_of_birth, gender) VALUES (?,?,?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, civilian.getFullName());
            ps.setString(2, civilian.getEmail());
            ps.setString(3, civilian.getPhone());
            ps.setString(4, civilian.getPasswordHash());
            ps.setString(5, civilian.getNationalId());
            ps.setDate(6, civilian.getDateOfBirth() != null ? Date.valueOf(civilian.getDateOfBirth()) : null);
            ps.setString(7, civilian.getGender());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }



    // UPDATE STATUS
    public boolean updateStatus(int regId, String newStatus) {
        String sql = "UPDATE Civilian_Registration SET status=? WHERE reg_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, regId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }



    // GET BY EMAIL
    public CivilianRegistration getByEmail(String email) {
        String sql = "SELECT * FROM Civilian_Registration WHERE email=?";
        CivilianRegistration civilian = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                civilian = new CivilianRegistration(
                        rs.getInt("reg_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password_hash"),
                        rs.getString("national_id"),
                        rs.getDate("date_of_birth") != null ? rs.getDate("date_of_birth").toLocalDate() : null,
                        rs.getString("gender"),
                        rs.getTimestamp("created_at"),
                        rs.getString("status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return civilian;
    }



    // LOGIN CHECK
    public CivilianRegistration checkLogin(String email, String passwordHash) {

        String sql = "SELECT * FROM Civilian_Registration WHERE email=? AND password_hash=?";
        CivilianRegistration civilian = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, passwordHash);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                civilian = getByEmail(email);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return civilian;
    }



    // GET ALL
    public List<CivilianRegistration> getAll() {

        List<CivilianRegistration> list = new ArrayList<>();
        String sql = "SELECT * FROM Civilian_Registration ORDER BY reg_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CivilianRegistration civilian = new CivilianRegistration(
                        rs.getInt("reg_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password_hash"),
                        rs.getString("national_id"),
                        rs.getDate("date_of_birth") != null ? rs.getDate("date_of_birth").toLocalDate() : null,
                        rs.getString("gender"),
                        rs.getTimestamp("created_at"),
                        rs.getString("status")
                );
                list.add(civilian);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
