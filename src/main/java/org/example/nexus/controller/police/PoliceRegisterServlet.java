package org.example.nexus.controller.police;

import org.example.nexus.dao.PoliceRegistrationDAO;
import org.example.nexus.model.PoliceRegistration;
import org.example.nexus.util.PasswordUtil;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/police_register")
public class PoliceRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String ctx = req.getContextPath(); // <%= request.getContextPath() %>

        try {
            // Read form fields
            String fullName = req.getParameter("full_name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            String rank = req.getParameter("rank");
            String stationId = req.getParameter("police_station_id");
            String joiningCode = req.getParameter("joining_code");

            // Hash password
            String hash = PasswordUtil.hashPassword(password);

            // Convert police station ID
            int station = 0;
            if (stationId != null && !stationId.isEmpty()) {
                try {
                    station = Integer.parseInt(stationId);
                } catch (NumberFormatException ex) {
                    // Invalid station ID — return with error
                    resp.sendRedirect(ctx + "/views/auth/register.jsp?error=Invalid+Police+Station+ID");
                    return;
                }
            }

            // Build model
            PoliceRegistration police = new PoliceRegistration();
            police.setFullName(fullName);
            police.setEmail(email);
            police.setPhone(phone);
            police.setPasswordHash(hash);
            police.setRankDetails(rank);
            police.setPoliceStationId(station);
            police.setJoiningCode(joiningCode);

            PoliceRegistrationDAO dao = new PoliceRegistrationDAO();
            boolean success = dao.insert(police);

            if (success) {
                resp.sendRedirect(ctx + "/views/auth/login.jsp?msg=Police+Registration+Submitted");
            } else {
                resp.sendRedirect(ctx + "/views/auth/register.jsp?error=Police+Registration+Failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/views/auth/register.jsp?error=Exception+Occurred");
        }
    }
}
