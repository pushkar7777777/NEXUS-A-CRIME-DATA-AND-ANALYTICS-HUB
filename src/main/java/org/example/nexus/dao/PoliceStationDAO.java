package org.example.nexus.dao;


import org.example.nexus.model.PoliceStation;
import org.example.nexus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PoliceStationDAO {

    public List<PoliceStation> getAllStations() {

        List<PoliceStation> list = new ArrayList<>();
        String sql = "SELECT * FROM police_stations ORDER BY station_name ASC";

        try (Connection conn = DBConnection.getConnection();
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
}
