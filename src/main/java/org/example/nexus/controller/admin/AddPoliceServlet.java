package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.PoliceRegistrationDAO;
import org.example.nexus.model.PoliceRegistration;
import org.example.nexus.util.PasswordUtil;

import java.io.IOException;

@WebServlet("/admin/add-police")
public class AddPoliceServlet extends HttpServlet {

    private final PoliceRegistrationDAO policeDAO = new PoliceRegistrationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String rank = req.getParameter("rankDetails");
        int stationId = Integer.parseInt(req.getParameter("policeStationId"));
        String password = req.getParameter("password");

        PoliceRegistration officer = new PoliceRegistration();
        officer.setFullName(fullName);
        officer.setEmail(email);
        officer.setPhone(phone);
        officer.setRankDetails(rank);
        officer.setPoliceStationId(stationId);
        officer.setPasswordHash(PasswordUtil.hashPassword(password));
        officer.setApprovalStatus("PENDING");

        boolean saved = policeDAO.insert(officer);

        if (saved) {
            resp.sendRedirect(req.getContextPath() + "/admin/user-management?msg=Officer+Added");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/user-management?error=Insert+Failed");
        }
    }
}
