package org.example.nexus.dao;

import org.example.nexus.model.AdminRegistration;
import org.example.nexus.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminRegistrationDAO {

    // INSERT
    public boolean insert(AdminRegistration admin) {

        String sql = "INSERT INTO Admin_Registration(full_name, email, password_hash, role_requested, secret_admin_code) VALUES (?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, admin.getFullName());
            ps.setString(2, admin.getEmail());
            ps.setString(3, admin.getPasswordHash());
            ps.setString(4, admin.getRoleRequested());
            ps.setString(5, admin.getSecretAdminCode());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }



    // UPDATE APPROVAL
    public boolean updateApproval(int regId, String status) {

        String sql = "UPDATE Admin_Registration SET approval_status=? WHERE reg_id=?";

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
    public AdminRegistration getByEmail(String email) {

        String sql = "SELECT * FROM Admin_Registration WHERE email=?";
        AdminRegistration a = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                a = new AdminRegistration(
                        rs.getInt("reg_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password_hash"),
                        rs.getString("role_requested"),
                        rs.getString("secret_admin_code"),
                        rs.getTimestamp("created_at"),
                        rs.getString("approval_status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }



    // LOGIN CHECK
    public AdminRegistration checkLogin(String email, String passwordHash) {

        String sql = "SELECT * FROM Admin_Registration WHERE email=? AND password_hash=?";
        AdminRegistration a = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, passwordHash);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) a = getByEmail(email);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }



    // GET ALL
    public List<AdminRegistration> getAll() {

        List<AdminRegistration> list = new ArrayList<>();
        String sql = "SELECT * FROM Admin_Registration ORDER BY reg_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AdminRegistration a = new AdminRegistration(
                        rs.getInt("reg_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password_hash"),
                        rs.getString("role_requested"),
                        rs.getString("secret_admin_code"),
                        rs.getTimestamp("created_at"),
                        rs.getString("approval_status")
                );
                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
