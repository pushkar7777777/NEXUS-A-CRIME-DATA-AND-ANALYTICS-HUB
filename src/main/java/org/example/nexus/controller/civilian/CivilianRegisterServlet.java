package org.example.nexus.controller.civilian;

import org.example.nexus.dao.CivilianRegistrationDAO;
import org.example.nexus.model.CivilianRegistration;
import org.example.nexus.util.PasswordUtil;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/civilian_register")
public class CivilianRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String ctx = req.getContextPath();   // <%= request.getContextPath() %>

        try {
            // Read parameters
            String fullName = req.getParameter("full_name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            String nationalId = req.getParameter("national_id");
            String dob = req.getParameter("dob");
            String gender = req.getParameter("gender");

            // Hash password
            String hash = PasswordUtil.hashPassword(password);

            // Build model object
            CivilianRegistration civilian = new CivilianRegistration();
            civilian.setFullName(fullName);
            civilian.setEmail(email);
            civilian.setPhone(phone);
            civilian.setPasswordHash(hash);
            civilian.setNationalId(nationalId);
            civilian.setGender(gender);
            civilian.setDateOfBirth(
                    (dob != null && !dob.isEmpty()) ? LocalDate.parse(dob) : null
            );

            CivilianRegistrationDAO dao = new CivilianRegistrationDAO();
            boolean success = dao.insert(civilian);

            if (success) {
                resp.sendRedirect(ctx + "/views/auth/login.jsp?msg=Civilian+Registered+Successfully");
            } else {
                resp.sendRedirect(ctx + "/views/auth/register.jsp?error=Failed+to+Register+Civilian");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(ctx + "/views/auth/register.jsp?error=Exception+Occurred");
        }
    }
}
