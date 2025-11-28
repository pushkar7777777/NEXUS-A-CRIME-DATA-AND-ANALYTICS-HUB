package org.example.nexus.dao;

import org.example.nexus.model.Complaint;
import org.example.nexus.util.DBConnection; // Assuming this class exists

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComplaintRegistrationDAO extends DBConnection {

    /* ---------------- INSERT NEW COMPLAINT ---------------- */
    public boolean insert(Complaint c) {
        // NOTE: The database should handle setting 'date_filed' to NOW() and 'current_status' to 'FILED' or a default.
        // This SQL relies on the database defaulting the status.
        String sql = "INSERT INTO Complaints " +
                "(reg_id, complaint_type, date_of_incident, location_of_incident, latitude, longitude, " +
                "description, suspect_details, victim_details, urgency_level) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, c.getRegId());
            ps.setString(2, c.getComplaintType());
            ps.setDate(3, Date.valueOf(c.getDateOfIncident()));
            ps.setString(4, c.getLocationOfIncident());
            ps.setDouble(5, c.getLatitude());
            ps.setDouble(6, c.getLongitude());
            ps.setString(7, c.getDescription());
            ps.setString(8, c.getSuspectDetails());
            ps.setString(9, c.getVictimDetails());
            ps.setString(10, c.getUrgencyLevel());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    /* ---------------- GET ALL COMPLAINTS OF ONE CIVILIAN ---------------- */
    public List<Complaint> getByUserId(int regId) {
        List<Complaint> list = new ArrayList<>();

        String sql = "SELECT * FROM Complaints WHERE reg_id = ? ORDER BY date_filed DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, regId);

            ResultSet rs = ps.executeQuery();

            System.out.println("=== Complaint Records ===");

            while (rs.next()) {
                Complaint c = map(rs);
                list.add(c);

                // PRINT EACH FIELD HERE
                System.out.println(
                        "ID: " + c.getComplaintId() +
                                ", User: " + c.getRegId() +
                                ", ComplaintType: " + c.getComplaintType() +
                                ", Status: " + c.getCurrentStatus() +
                                ", Date: " + c.getDateFiled()
                );
            }

            System.out.println("Total Complaints Fetched = " + list.size());
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    /* ---------------- COUNT COMPLAINTS OF A USER BY SINGLE STATUS ---------------- */
    public int getCount(int regId, String status) {
        // Used for counting 'RESOLVED' complaints (a single, explicit status)
        String sql = "SELECT COUNT(*) FROM Complaints WHERE reg_id = ? AND current_status = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, regId);
            ps.setString(2, status);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }

        return 0;
    }

    /* ---------------- COUNT ALL COMPLAINTS OF A USER (Used for Total Filed) ---------------- */
    public int getCountAll(int regId) {
        // Used for counting the total number of complaints filed by the user, regardless of status.
        String sql = "SELECT COUNT(*) FROM Complaints WHERE reg_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, regId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }

        return 0;
    }

    /* ---------------- COUNT COMPLAINTS OF A USER BY MULTIPLE STATUSES (Used for In Progress) ---------------- */
    public int getCountMultiStatus(int regId, String status1, String status2) {
        // Used for counting 'In Progress' complaints (e.g., UNDER_INVESTIGATION OR UNDER_REVIEW)
        String sql = "SELECT COUNT(*) FROM Complaints WHERE reg_id = ? AND (current_status = ? OR current_status = ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, regId);
            ps.setString(2, status1);
            ps.setString(3, status2);


            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }

        return 0;
    }


    /* ---------------- UPDATE STATUS BY POLICE/ADMIN ---------------- */
    public boolean updateStatus(int complaintId, String status) {
        String sql = "UPDATE Complaints SET current_status = ? WHERE complaint_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, complaintId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /* ---------------- MAP RESULTSET → MODEL ---------------- */
    public Complaint map(ResultSet rs) throws Exception {
        Complaint c = new Complaint();

        c.setComplaintId(rs.getInt("complaint_id"));
        c.setRegId(rs.getInt("reg_id"));
        c.setComplaintType(rs.getString("complaint_type"));
        c.setDateOfIncident(rs.getDate("date_of_incident").toLocalDate());
        c.setLocationOfIncident(rs.getString("location_of_incident"));
        c.setLatitude(rs.getDouble("latitude"));
        c.setLongitude(rs.getDouble("longitude"));
        c.setDescription(rs.getString("description"));
        c.setSuspectDetails(rs.getString("suspect_details"));
        c.setVictimDetails(rs.getString("victim_details"));
        c.setUrgencyLevel(rs.getString("urgency_level"));

        // LocalDateTime mapping
        Timestamp ts = rs.getTimestamp("date_filed");
        if (ts != null) c.setDateFiled(ts.toLocalDateTime());

        c.setCurrentStatus(rs.getString("current_status"));

        return c;
    }
}