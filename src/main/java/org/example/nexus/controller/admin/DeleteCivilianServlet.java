package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.CivilianRegistrationDAO;

import java.io.IOException;

@WebServlet("/DeleteCivilianServlet")
public class DeleteCivilianServlet extends HttpServlet {

    private final CivilianRegistrationDAO civilianDAO = new CivilianRegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Get regId from request
            int regId = Integer.parseInt(request.getParameter("regId"));

            // 2. Delete civilian record
            boolean deleted = civilianDAO.delete(regId);

            // 3. Redirect with message
            if (deleted) {
                response.sendRedirect(request.getContextPath() +
                        "/admin/user-management?msg=Civilian+Deleted+Successfully");
            } else {
                response.sendRedirect(request.getContextPath() +
                        "/admin/user-management?error=Delete+Failed");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect(request.getContextPath() +
                    "/admin/user-management?error=Invalid+Civilian+ID");
        }
    }
}
