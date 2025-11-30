package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.CivilianRegistrationDAO;
import org.example.nexus.model.CivilianRegistration;
import org.example.nexus.util.PasswordUtil;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/admin/add-civilian")
public class AddCivilianServlet extends HttpServlet {

    private final CivilianRegistrationDAO civilianDAO = new CivilianRegistrationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String nationalId = req.getParameter("nationalId");
        LocalDate dob = LocalDate.parse(req.getParameter("dob"));
        String password = req.getParameter("password");

        CivilianRegistration civ = new CivilianRegistration();
        civ.setFullName(fullName);
        civ.setEmail(email);
        civ.setPhone(phone);
        civ.setNationalId(nationalId);
        civ.setDateOfBirth(dob);
        civ.setPasswordHash(PasswordUtil.hashPassword(password));
        civ.setStatus("PENDING");

        boolean saved = civilianDAO.insert(civ);

        if (saved) {
            resp.sendRedirect(req.getContextPath() + "/admin/user-management?msg=Civilian+Added");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/user-management?error=Insert+Failed");
        }
    }
}
