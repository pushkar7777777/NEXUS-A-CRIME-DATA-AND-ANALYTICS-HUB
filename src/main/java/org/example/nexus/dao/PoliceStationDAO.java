package org.example.nexus.dao;

import org.example.nexus.model.PoliceStation;
import org.example.nexus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PoliceStationDAO extends DBConnection {

    /* ================== GET ALL STATIONS ================== */
    public List<PoliceStation> getAllStations() {

        List<PoliceStation> list = new ArrayList<>();
        String sql = "SELECT * FROM police_stations ORDER BY station_name ASC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                PoliceStation station = new PoliceStation(
                        rs.getInt("police_station_id"),
                        rs.getString("station_name"),
                        rs.getString("location"),
                        rs.getString("jurisdiction_area"),
                        rs.getString("contact_number"),
                        rs.getString("email"),
                        rs.getTimestamp("created_on")
                );

                list.add(station);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    /* ================== GET NEAREST STATION BY LOCATION ================== */
    public PoliceStation getNearestStation(String location) {

        if (location == null || location.trim().isEmpty())
            return null;

        String sql = "SELECT * FROM police_stations " +
                "WHERE LOWER(jurisdiction_area) LIKE LOWER(?) " +
                "   OR LOWER(location) LIKE LOWER(?) " +
                "   OR LOWER(station_name) LIKE LOWER(?) " +
                "ORDER BY police_station_id ASC LIMIT 1";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String like = "%" + location.trim() + "%";

            ps.setString(1, like);
            ps.setString(2, like);
            ps.setString(3, like);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new PoliceStation(
                        rs.getInt("police_station_id"),
                        rs.getString("station_name"),
                        rs.getString("location"),
                        rs.getString("jurisdiction_area"),
                        rs.getString("contact_number"),
                        rs.getString("email"),
                        rs.getTimestamp("created_on")
                );
            }

        } catch (Exception e) { e.printStackTrace(); }

        // Return default nearest station instead of null to avoid errors
        return getDefaultStation();
    }
    private PoliceStation getDefaultStation() {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT * FROM police_stations ORDER BY police_station_id ASC LIMIT 1")) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new PoliceStation(
                        rs.getInt("police_station_id"),
                        rs.getString("station_name"),
                        rs.getString("location"),
                        rs.getString("jurisdiction_area"),
                        rs.getString("contact_number"),
                        rs.getString("email"),
                        rs.getTimestamp("created_on")
                );
            }

        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM police_stations";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }



}
