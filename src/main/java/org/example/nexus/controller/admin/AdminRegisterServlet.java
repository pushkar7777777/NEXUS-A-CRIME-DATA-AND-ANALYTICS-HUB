package org.example.nexus.controller.admin;

import org.example.nexus.dao.AdminRegistrationDAO;
import org.example.nexus.model.AdminRegistration;
import org.example.nexus.util.PasswordUtil;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/admin_register")
public class AdminRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String ctx = req.getContextPath();  // <%= request.getContextPath() %>

        try {
            // Read form fields
            String fullName = req.getParameter("full_name");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String role = req.getParameter("role");
            String secretCode = req.getParameter("secret_admin_code");

            // Hash password
            String hash = PasswordUtil.hashPassword(password);

            // Create model
            AdminRegistration admin = new AdminRegistration();
            admin.setFullName(fullName);
            admin.setEmail(email);
            admin.setPasswordHash(hash);
            admin.setRoleRequested(role);
            admin.setSecretAdminCode(secretCode);

            AdminRegistrationDAO dao = new AdminRegistrationDAO();
            boolean success = dao.insert(admin);

            if (success) {
                resp.sendRedirect(ctx + "/views/auth/login.jsp?msg=Admin+Registration+Submitted");
            } else {
                resp.sendRedirect(ctx + "/views/auth/register.jsp?error=Failed+to+Register+Admin");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(ctx + "/views/auth/register.jsp?error=Exception+Occurred");
        }
    }
}
