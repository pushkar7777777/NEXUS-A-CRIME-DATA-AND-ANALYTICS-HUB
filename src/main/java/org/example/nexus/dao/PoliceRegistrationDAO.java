package org.example.nexus.dao;


import org.example.nexus.model.PoliceRegistration;
import org.example.nexus.model.PoliceStation;
import org.example.nexus.util.DBConnection;
import org.example.nexus.util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PoliceRegistrationDAO {

    // INSERT
    public boolean insert(PoliceRegistration police) {

        String sql = "INSERT INTO Police_Registration(full_name, email, phone, password_hash, rank_details, police_station_id, joining_code) VALUES (?,?,?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, police.getFullName());
            ps.setString(2, police.getEmail());
            ps.setString(3, police.getPhone());
            ps.setString(4, police.getPasswordHash());
            ps.setString(5, police.getRankDetails());
            ps.setInt(6, police.getPoliceStationId());
            ps.setString(7, police.getJoiningCode());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }



    // UPDATE APPROVAL STATUS
    public boolean updateApproval(int regId, String status) {

        String sql = "UPDATE Police_Registration SET approval_status=? WHERE reg_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, regId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }



    // GET BY EMAIL
    public PoliceRegistration getByEmail(String email) {

        String sql = "SELECT * FROM Police_Registration WHERE email=?";
        PoliceRegistration p = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new PoliceRegistration(
                        rs.getInt("reg_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password_hash"),
                        rs.getString("rank_details"),
                        rs.getInt("police_station_id"),
                        rs.getString("joining_code"),
                        rs.getTimestamp("created_at"),
                        rs.getString("approval_status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }


    public List<PoliceStation> getAllStations() {
        List<PoliceStation> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT police_station_id, station_name FROM police_stations";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PoliceStation psObj = new PoliceStation();
                psObj.setPoliceStationId((rs.getInt("police_station_id")));
                psObj.setStationName(rs.getString("station_name"));
                list.add(psObj);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // LOGIN CHECK
    public PoliceRegistration checkLogin(String email, String plainPassword) {

        String sql = "SELECT * FROM Police_Registration WHERE email=?";
        PoliceRegistration p = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String storedHash = rs.getString("password_hash");
                String generatedHash = PasswordUtil.hashPassword(plainPassword);

                System.out.println("LOGIN HASH      = " + generatedHash);
                System.out.println("DATABASE HASH   = " + storedHash);

                if (storedHash.equalsIgnoreCase(generatedHash)) {
                    p = new PoliceRegistration(
                            rs.getInt("reg_id"),
                            rs.getString("full_name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            storedHash,
                            rs.getString("rank_details"),
                            rs.getInt("police_station_id"),
                            rs.getString("joining_code"),
                            rs.getTimestamp("created_at"),
                            rs.getString("approval_status")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }




    // GET ALL
    public List<PoliceRegistration> getAll() {

        List<PoliceRegistration> list = new ArrayList<>();
        String sql = "SELECT * FROM Police_Registration ORDER BY reg_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PoliceRegistration p = new PoliceRegistration(
                        rs.getInt("reg_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password_hash"),
                        rs.getString("rank_details"),
                        rs.getInt("police_station_id"),
                        rs.getString("joining_code"),
                        rs.getTimestamp("created_at"),
                        rs.getString("approval_status")
                );
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
