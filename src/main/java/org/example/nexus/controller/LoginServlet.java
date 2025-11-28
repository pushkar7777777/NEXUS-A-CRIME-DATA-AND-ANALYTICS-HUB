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

        // Basic validation
        if (role == null || role.isBlank()) {
            resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Please+select+a+role");
            return;
        }

        if (email == null || password == null || email.isBlank() || password.isBlank()) {
            resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Email+and+Password+Required");
            return;
        }

        String hashed = PasswordUtil.hashPassword(password);
        HttpSession session = req.getSession();

        try {
            switch (role.toUpperCase()) {

                /* -------------------- CIVILIAN LOGIN -------------------- */
                case "CIVILIAN": {
                    CivilianRegistrationDAO cdao = new CivilianRegistrationDAO();
                    CivilianRegistration civilian = cdao.checkLogin(email, hashed);

                    if (civilian != null) {

                        session.setAttribute("civilian_reg_id", civilian.getRegId());
                        session.setAttribute("user_name", civilian.getFullName());
                        session.setAttribute("role", "CIVILIAN");
                        session.setAttribute("user", civilian); // whole object

                        resp.sendRedirect(ctx + "/civilian/dashboard");
                    } else {
                        resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Invalid+Civilian+Credentials");
                    }
                    break;
                }

                /* -------------------- POLICE LOGIN -------------------- */
                case "POLICE": {
                    PoliceRegistrationDAO pdao = new PoliceRegistrationDAO();
                    PoliceRegistration police = pdao.checkLogin(email, hashed);

                    if (police != null) {

                        if (!"APPROVED".equalsIgnoreCase(police.getApprovalStatus())) {
                            resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Police+Not+Approved+Yet");
                            return;
                        }

                        session.setAttribute("police_reg_id", police.getRegId());
                        session.setAttribute("user_name", police.getFullName());
                        session.setAttribute("role", "POLICE");
                        session.setAttribute("user", police);

                        resp.sendRedirect(ctx + "/police/dashboard");
                    } else {
                        resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Invalid+Police+Credentials");
                    }
                    break;
                }

                /* -------------------- ADMIN LOGIN -------------------- */
                case "ADMIN": {
                    AdminRegistrationDAO adao = new AdminRegistrationDAO();
                    AdminRegistration admin = adao.checkLogin(email, hashed);

                    if (admin != null) {

                        if (!"APPROVED".equalsIgnoreCase(admin.getApprovalStatus())) {
                            resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Admin+Not+Approved+Yet");
                            return;
                        }

                        session.setAttribute("admin_reg_id", admin.getRegId());
                        session.setAttribute("user_name", admin.getFullName());
                        session.setAttribute("role", "ADMIN");
                        session.setAttribute("user", admin);

                        /** IMPORTANT FIX:
                         * Redirect to servlet → not direct JSP
                         */
                        resp.sendRedirect(ctx + "/admin/dashboard");
                    } else {
                        resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Invalid+Admin+Credentials");
                    }
                    break;
                }

                /* -------------------- INVALID ROLE -------------------- */
                default:
                    resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Invalid+Role+Selected");
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(ctx + "/views/auth/login.jsp?error=Unexpected+Error+Occurred");
        }
    }
}
