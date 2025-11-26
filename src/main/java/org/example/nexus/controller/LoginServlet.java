package org.example.nexus.controller;

import org.example.nexus.dao.*;
import org.example.nexus.model.*;
import org.example.nexus.util.PasswordUtil;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String role = req.getParameter("role");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        String ctx = req.getContextPath();

        if (role == null || role.isBlank()) {
            resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Please+select+role");
            return;
        }

        // Hash password
        String hashed = PasswordUtil.hashPassword(password);

        HttpSession session = req.getSession();

        try {
            switch (role.toUpperCase()) {

                /* ================= CIVILIAN LOGIN ================= */
                case "CIVILIAN": {
                    CivilianRegistrationDAO cdao = new CivilianRegistrationDAO();
                    CivilianRegistration civilian = cdao.checkLogin(email, hashed);

                    if (civilian != null) {

                        // store minimal session data
                        session.setAttribute("user", civilian); // full object
                        session.setAttribute("user_id", civilian.getRegId());
                        session.setAttribute("user_name", civilian.getFullName());
                        session.setAttribute("role", "CIVILIAN");

                        resp.sendRedirect(ctx + "/civilian/dashboard");

                    } else {
                        resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Invalid+Civilian+Credentials");
                    }
                    break;
                }

                /* ================= POLICE LOGIN ================= */
                case "POLICE": {
                    PoliceRegistrationDAO pdao = new PoliceRegistrationDAO();
                    PoliceRegistration police = pdao.checkLogin(email, hashed);

                    if (police != null) {

                        if (!"APPROVED".equalsIgnoreCase(police.getApprovalStatus())) {
                            resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Police+Not+Approved+Yet");
                            return;
                        }

                        // store minimal session data
                        session.setAttribute("user", police);
                        session.setAttribute("user_id", police.getRegId());
                        session.setAttribute("user_name", police.getFullName());
                        session.setAttribute("role", "POLICE");

                        resp.sendRedirect(ctx + "/views/police/dashboard.jsp");
                    } else {
                        resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Invalid+Police+Credentials");
                    }
                    break;
                }

                /* ================= ADMIN LOGIN ================= */
                case "ADMIN": {
                    AdminRegistrationDAO adao = new AdminRegistrationDAO();
                    AdminRegistration admin = adao.checkLogin(email, hashed);

                    if (admin != null) {

                        if (!"APPROVED".equalsIgnoreCase(admin.getApprovalStatus())) {
                            resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Admin+Not+Approved+Yet");
                            return;
                        }

                        // store minimal session data
                        session.setAttribute("user", admin);
                        session.setAttribute("user_id", admin.getRegId());
                        session.setAttribute("user_name", admin.getFullName());
                        session.setAttribute("role", "ADMIN");

                        resp.sendRedirect(ctx + "/views/admin/dashboard.jsp");
                    } else {
                        resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Invalid+Admin+Credentials");
                    }
                    break;
                }

                default:
                    resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Invalid+Role");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Exception+Occurred");
        }
    }
}
