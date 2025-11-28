package org.example.nexus.dao;


import org.example.nexus.model.Complaint;
import org.example.nexus.model.PoliceDashboardStats;
import org.example.nexus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PoliceDashboardDAO extends DBConnection {

    public PoliceDashboardStats getDashboardStats(int policeRegId) {
        PoliceDashboardStats stats = new PoliceDashboardStats();

        try (Connection conn = getConnection()) {

            // TOTAL ASSIGNED CASES
            String sql1 = "SELECT COUNT(*) FROM Police_Assigned_Cases WHERE police_reg_id = ?";
            PreparedStatement ps1 = conn.prepareStatement(sql1);
            ps1.setInt(1, policeRegId);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) stats.setTotalAssigned(rs1.getInt(1));

            // IN PROGRESS
            String sql2 = "SELECT COUNT(*) FROM Complaints c " +
                    "JOIN Police_Assigned_Cases p ON c.complaint_id = p.complaint_id " +
                    "WHERE p.police_reg_id = ? AND c.current_status IN ('UNDER_REVIEW','UNDER_INVESTIGATION')";
            PreparedStatement ps2 = conn.prepareStatement(sql2);
            ps2.setInt(1, policeRegId);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) stats.setInProgress(rs2.getInt(1));

            // RESOLVED
            String sql3 = "SELECT COUNT(*) FROM Complaints c " +
                    "JOIN Police_Assigned_Cases p ON c.complaint_id = p.complaint_id " +
                    "WHERE p.police_reg_id = ? AND c.current_status = 'RESOLVED'";
            PreparedStatement ps3 = conn.prepareStatement(sql3);
            ps3.setInt(1, policeRegId);
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) stats.setResolved(rs3.getInt(1));

        } catch (Exception ex) { ex.printStackTrace(); }

        return stats;
    }

    public List<Complaint> getAssignedComplaints(int policeRegId) {
        List<Complaint> list = new ArrayList<>();

        String sql = "SELECT c.* FROM Complaints c " +
                "JOIN Police_Assigned_Cases p ON c.complaint_id = p.complaint_id " +
                "WHERE p.police_reg_id = ? ORDER BY c.date_filed DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, policeRegId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Complaint cm = new Complaint();
                cm.setComplaintId(rs.getInt("complaint_id"));
                cm.setRegId(rs.getInt("reg_id"));
                cm.setComplaintType(rs.getString("complaint_type"));
                cm.setDateOfIncident(rs.getDate("date_of_incident").toLocalDate());
                cm.setLocationOfIncident(rs.getString("location_of_incident"));
                cm.setDescription(rs.getString("description"));
                cm.setCurrentStatus(rs.getString("current_status"));
                cm.setDateFiled(rs.getTimestamp("date_filed").toLocalDateTime());

                list.add(cm);
            }

        } catch (Exception ex) { ex.printStackTrace(); }

        return list;
    }
}
