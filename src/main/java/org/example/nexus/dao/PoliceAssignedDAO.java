package org.example.nexus.dao;

import org.example.nexus.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class PoliceAssignedDAO extends DBConnection {

    public boolean assignOfficer(int complaintId, int officerId) {

        String sql = "INSERT INTO police_assigned_cases (complaint_id, police_reg_id) VALUES (?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, complaintId);
            ps.setInt(2, officerId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
