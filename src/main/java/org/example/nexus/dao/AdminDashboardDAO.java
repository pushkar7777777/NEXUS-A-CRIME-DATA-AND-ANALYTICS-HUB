package org.example.nexus.dao;


import org.example.nexus.model.ComplaintSummary;
import org.example.nexus.model.Activity;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static org.example.nexus.util.DBConnection.getConnection;

public class AdminDashboardDAO  {

    public int getTotalCivilians() {
        String sql = "SELECT COUNT(*) FROM Civilian_Registration";
        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next())
                return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalPolice() {
        String sql = "SELECT COUNT(*) FROM Police_Registration WHERE approval_status='APPROVED'";
        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalStations() {
        String sql = "SELECT COUNT(*) FROM police_stations";
        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalComplaints() {
        String sql = "SELECT COUNT(*) FROM Complaints";
        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // For the Doughnut Chart
    public ComplaintSummary getComplaintSummary() {
        ComplaintSummary cs = new ComplaintSummary();

        String sql =
                "SELECT current_status, COUNT(*) AS cnt " +
                        "FROM Complaints GROUP BY current_status";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String status = rs.getString("current_status");
                int count = rs.getInt("cnt");

                switch (status) {
                    case "FILED": cs.setFiled(count); break;
                    case "UNDER_REVIEW": cs.setUnderReview(count); break;
                    case "UNDER_INVESTIGATION": cs.setUnderInvestigation(count); break;
                    case "RESOLVED": cs.setResolved(count); break;
                    case "CLOSED": cs.setClosed(count); break;
                }
            }

        } catch (Exception e) { e.printStackTrace(); }

        return cs;
    }

    // For the Recent Activity Table (using recent complaints)
    public List<Activity> getRecentActivity() {
        List<Activity> list = new ArrayList<>();

        String sql =
                "SELECT complaint_id, complaint_type, reg_id, current_status, date_filed " +
                        "FROM Complaints ORDER BY date_filed DESC LIMIT 10";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Activity a = new Activity();
                a.setUserId("CIV-" + rs.getInt("reg_id"));
                a.setName("User #" + rs.getInt("reg_id"));
                a.setEmail("N/A");
                a.setRole("Civilian");
                a.setAction(rs.getString("complaint_type"));
                a.setStatus(rs.getString("current_status"));
                a.setCreatedAt(rs.getTimestamp("date_filed"));
                list.add(a);
            }
        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }
}
