package org.example.nexus.dao;

import org.example.nexus.model.Complaint;
import org.example.nexus.util.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ComplaintRegistrationDAO extends DBConnection {

    /* ---------------- INSERT NEW COMPLAINT ---------------- */
    public boolean insert(Complaint c) {

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


    /* ---------------- GET ALL COMPLAINTS FOR ADMIN ---------------- */
    public List<Complaint> getAllComplaints() {

        String sql =
                "SELECT c.*, civ.full_name AS filedBy " +
                        "FROM Complaints c " +
                        "JOIN Civilian_Registration civ ON c.reg_id = civ.reg_id " +
                        "ORDER BY c.date_filed DESC";

        List<Complaint> list = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Complaint c = map(rs);
                c.setFiledBy(rs.getString("filedBy"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    /* ---------------- GET ALL COMPLAINTS OF ONE CIVILIAN ---------------- */
    public List<Complaint> getByUserId(int regId) {

        String sql =
                "SELECT c.*, civ.full_name AS filedBy " +
                        "FROM Complaints c " +
                        "JOIN Civilian_Registration civ ON c.reg_id = civ.reg_id " +
                        "WHERE c.reg_id = ? ORDER BY date_filed DESC";

        List<Complaint> list = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, regId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Complaint c = map(rs);
                c.setFiledBy(rs.getString("filedBy"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    /* ---------------- COUNT COMPLAINTS (SINGLE STATUS) ---------------- */
    public int getCount(int regId, String status) {

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


    /* ---------------- COUNT ALL COMPLAINTS OF A USER ---------------- */
    public int getCountAll(int regId) {

        String sql = "SELECT COUNT(*) FROM Complaints WHERE reg_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, regId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }

        return 0;
    }


    /* ---------------- COUNT BY MULTIPLE STATUSES ---------------- */
    public int getCountMultiStatus(int regId, String status1, String status2) {

        String sql =
                "SELECT COUNT(*) FROM Complaints WHERE reg_id = ? AND " +
                        "(current_status = ? OR current_status = ?)";

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


    /* ---------------- UPDATE STATUS BY ADMIN/POLICE ---------------- */
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

        Timestamp ts = rs.getTimestamp("date_filed");
        if (ts != null) c.setDateFiled(ts.toLocalDateTime());

        c.setCurrentStatus(rs.getString("current_status"));

        return c;
    }
    public Complaint getById(int complaintId) {
        String sql = "SELECT c.*, civ.full_name AS filed_by " +
                "FROM Complaints c " +
                "JOIN Civilian_Registration civ ON c.reg_id = civ.reg_id " +
                "WHERE complaint_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, complaintId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Complaint c = map(rs);
                c.setFiledBy(rs.getString("filed_by"));
                return c;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    public int countAll() {
        return countByQuery("SELECT COUNT(*) FROM complaints");
    }

    public int countByStatus(String status) {
        return countByQuery("SELECT COUNT(*) FROM complaints WHERE status='" + status + "'");
    }

    public int countAssigned() {
        return countByQuery("SELECT COUNT(*) FROM complaints WHERE assigned_officer IS NOT NULL");
    }

    public int countUnassigned() {
        return countByQuery("SELECT COUNT(*) FROM complaints WHERE assigned_officer IS NULL");
    }

    private int countByQuery(String sql) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

}
