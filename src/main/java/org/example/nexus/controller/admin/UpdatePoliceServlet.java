package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.PoliceRegistrationDAO;

import java.io.IOException;

@WebServlet("/UpdatePoliceServlet")
public class UpdatePoliceServlet extends HttpServlet {

    private final PoliceRegistrationDAO policeDAO = new PoliceRegistrationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Fetch data from request
            int regId = Integer.parseInt(request.getParameter("regId"));
            String status = request.getParameter("status");  // APPROVED, REJECTED, SUSPENDED etc.

            // 2. Update status in DAO
            boolean updated = policeDAO.updateStatus(regId, status);

            // 3. Redirect with message
            if (updated) {
                response.sendRedirect(request.getContextPath() +
                        "/admin/user-management?msg=Status+Updated+Successfully");
            } else {
                response.sendRedirect(request.getContextPath() +
                        "/admin/user-management?error=Update+Failed");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect(request.getContextPath() +
                    "/admin/user-management?error=Invalid+Request");
        }
    }
}
