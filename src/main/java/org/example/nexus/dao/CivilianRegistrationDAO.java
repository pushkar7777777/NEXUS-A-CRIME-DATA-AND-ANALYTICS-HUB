package org.example.nexus.dao;


import org.example.nexus.model.CivilianRegistration;
import org.example.nexus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static org.example.nexus.util.DBConnection.getConnection;

public class CivilianRegistrationDAO {

    // INSERT
    public boolean insert(CivilianRegistration civilian) {
        String sql = "INSERT INTO Civilian_Registration(full_name, email, phone, password_hash, national_id, date_of_birth, gender) VALUES (?,?,?,?,?,?,?)";

        try (Connection conn = getConnection();
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

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, regId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    public int countAll() {
        String sql = "SELECT COUNT(*) FROM civilian_registration";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // GET BY EMAIL
    public CivilianRegistration getByEmail(String email) {
        String sql = "SELECT * FROM Civilian_Registration WHERE email=?";
        CivilianRegistration civilian = null;

        try (Connection conn = getConnection();
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
    public boolean updateProfile(CivilianRegistration c) {

        String sql = "UPDATE Civilian_Registration SET full_name=?, phone=?, national_id=?, " +
                "date_of_birth=?, gender=?, profile_photo=? WHERE reg_id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getFullName());
            ps.setString(2, c.getPhone());
            ps.setString(3, c.getNationalId());

            if (c.getDateOfBirth() != null)
                ps.setDate(4, Date.valueOf(c.getDateOfBirth()));
            else
                ps.setNull(4, Types.DATE);

            ps.setString(5, c.getGender());
            ps.setString(6, c.getProfilePhoto());
            ps.setInt(7, c.getRegId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }





    // LOGIN CHECK
    public CivilianRegistration checkLogin(String email, String passwordHash) {

        String sql = "SELECT * FROM Civilian_Registration WHERE email=? AND password_hash=?";
        CivilianRegistration civilian = null;

        try (Connection conn = getConnection();
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

        try (Connection conn = getConnection();
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

    public CivilianRegistration getById(int regId) {
        CivilianRegistration c = null;

        String sql = "SELECT reg_id, full_name, email, phone, password_hash, national_id, " +
                "date_of_birth, gender, created_at, status " +
                "FROM Civilian_Registration WHERE reg_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, regId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                c = new CivilianRegistration();

                c.setRegId(rs.getInt("reg_id"));
                c.setFullName(rs.getString("full_name"));
                c.setEmail(rs.getString("email"));
                c.setPhone(rs.getString("phone"));
                c.setPasswordHash(rs.getString("password_hash"));
                c.setNationalId(rs.getString("national_id"));

                Date dob = rs.getDate("date_of_birth");
                c.setDateOfBirth(dob != null ? dob.toLocalDate() : null);

                c.setGender(rs.getString("gender"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setStatus(rs.getString("status"));

                // 🔵 DEBUG PRINT — SEE DATA IN CONSOLE
                System.out.println("==== Civilian Data Loaded ====");
                System.out.println("ID: " + c.getRegId());
                System.out.println("Name: " + c.getFullName());
                System.out.println("Email: " + c.getEmail());
                System.out.println("Phone: " + c.getPhone());
                System.out.println("National ID: " + c.getNationalId());
                System.out.println("DOB: " + c.getDateOfBirth());
                System.out.println("Gender: " + c.getGender());
                System.out.println("Status: " + c.getStatus());
                System.out.println("Created At: " + c.getCreatedAt());
                System.out.println("==============================");
            } else {
                System.out.println("❗ No civilian found for reg_id = " + regId);
            }

        } catch (Exception e) {
            System.out.println("❌ Error in getById(): " + e.getMessage());
            e.printStackTrace();
        }

        return c;
    }
    public boolean update(CivilianRegistration civ) {
        String sql = "UPDATE Civilian_Registration SET full_name=?, email=?, phone=?, national_id=?, date_of_birth=?, gender=?, status=? WHERE reg_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, civ.getFullName());
            ps.setString(2, civ.getEmail());
            ps.setString(3, civ.getPhone());
            ps.setString(4, civ.getNationalId());
            ps.setObject(5, civ.getDateOfBirth()); // works for LocalDate
            ps.setString(6, civ.getGender());
            ps.setString(7, civ.getStatus());
            ps.setInt(8, civ.getRegId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public CivilianRegistration findById(int regId) {
        String sql = "SELECT reg_id, full_name, email, phone, status FROM Civilian_Registration WHERE reg_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, regId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CivilianRegistration civ = new CivilianRegistration();
                    civ.setRegId(rs.getInt("reg_id"));
                    civ.setFullName(rs.getString("full_name"));
                    civ.setEmail(rs.getString("email"));
                    civ.setPhone(rs.getString("phone"));
                    civ.setStatus(rs.getString("status"));
                    return civ;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean delete(int regId) {
        String sql = "DELETE FROM Civilian_Registration WHERE reg_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, regId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
