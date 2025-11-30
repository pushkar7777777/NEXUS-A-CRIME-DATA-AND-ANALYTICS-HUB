package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.CivilianRegistrationDAO;
import org.example.nexus.model.CivilianRegistration;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/UpdateCivilianServlet")
public class UpdateCivilianServlet extends HttpServlet {

    private final CivilianRegistrationDAO civilianDAO = new CivilianRegistrationDAO();

    /**
     * GET → Load civilian details for edit page
     * URL → /UpdateCivilianServlet?regId=10
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String regIdParam = request.getParameter("regId");

        if (regIdParam == null) {
            response.sendRedirect(request.getContextPath() +
                    "/admin/user-management?error=Missing+Civilian+ID");
            return;
        }

        try {
            int regId = Integer.parseInt(regIdParam);

            CivilianRegistration civilian = civilianDAO.findById(regId);

            if (civilian == null) {
                response.sendRedirect(request.getContextPath() +
                        "/admin/user-management?error=Civilian+Not+Found");
                return;
            }

            // Put civilian in request scope and forward to edit JSP
            request.setAttribute("civilian", civilian);
            request.getRequestDispatcher("/views/admin/editCivilian.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() +
                    "/admin/user-management?error=Invalid+ID");
        }
    }

    /**
     * POST → Save updated civilian details
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");  // Support Unicode input

        try {
            int regId = Integer.parseInt(request.getParameter("regId"));

            // ------------ Read and sanitize fields --------------- //
            String fullName = trim(request.getParameter("fullName"));
            String email = trim(request.getParameter("email"));
            String phone = trim(request.getParameter("phone"));
            String nationalId = trim(request.getParameter("nationalId"));
            String gender = trim(request.getParameter("gender"));
            String status = trim(request.getParameter("status"));

            // DOB conversion
            String dobParam = trim(request.getParameter("dateOfBirth"));
            LocalDate dateOfBirth = null;

            if (dobParam != null && !dobParam.isEmpty()) {
                dateOfBirth = LocalDate.parse(dobParam); // yyyy-MM-dd → LocalDate
            }
            // ----------------------------------------------------- //

            // Basic validation
            if (fullName == null || fullName.isEmpty() ||
                    email == null || email.isEmpty()) {

                response.sendRedirect(request.getContextPath() +
                        "/admin/user-management?error=Name+and+Email+required");
                return;
            }

            // Build Civilian object
            CivilianRegistration civ = new CivilianRegistration();
            civ.setRegId(regId);
            civ.setFullName(fullName);
            civ.setEmail(email);
            civ.setPhone(phone);
            civ.setNationalId(nationalId);
            civ.setGender(gender);
            civ.setStatus(status);
            civ.setDateOfBirth(dateOfBirth);

            // Update in DB
            boolean success = civilianDAO.update(civ);

            if (success) {
                response.sendRedirect(request.getContextPath() +
                        "/admin/user-management?msg=Civilian+Updated+Successfully");
            } else {
                response.sendRedirect(request.getContextPath() +
                        "/admin/user-management?error=Update+Failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() +
                    "/admin/user-management?error=Server+Error");
        }
    }

    // Helper to trim and prevent null
    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}
