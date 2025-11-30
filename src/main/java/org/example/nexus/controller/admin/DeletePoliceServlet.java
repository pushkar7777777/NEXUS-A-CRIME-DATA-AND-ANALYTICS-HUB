package org.example.nexus.controller.admin;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.PoliceRegistrationDAO;

import java.io.IOException;

@WebServlet("/DeletePoliceServlet")
public class DeletePoliceServlet extends HttpServlet {

    private final PoliceRegistrationDAO policeDAO = new PoliceRegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Get regId from request
            int regId = Integer.parseInt(request.getParameter("regId"));

            // 2. Delete police record
            boolean deleted = policeDAO.delete(regId);

            // 3. Redirect back with message (optional)
            if (deleted) {
                response.sendRedirect(request.getContextPath() +
                        "/admin/user-management?msg=Police+Deleted+Successfully");
            } else {
                response.sendRedirect(request.getContextPath() +
                        "/admin/user-management?error=Delete+Failed");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect(request.getContextPath() +
                    "/admin/user-management?error=Invalid+Police+ID");
        }
    }
}
