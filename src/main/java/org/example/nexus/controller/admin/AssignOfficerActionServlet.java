package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.PoliceAssignedDAO;
import org.example.nexus.dao.ComplaintRegistrationDAO;

import java.io.IOException;

@WebServlet("/admin/assign-officer-action")
public class AssignOfficerActionServlet extends HttpServlet {

    private final PoliceAssignedDAO assignedDAO = new PoliceAssignedDAO();
    private final ComplaintRegistrationDAO complaintDAO = new ComplaintRegistrationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int complaintId = Integer.parseInt(req.getParameter("complaintId"));
        int officerId = Integer.parseInt(req.getParameter("officerId"));

        boolean ok = assignedDAO.assignOfficer(complaintId, officerId);

        if (ok) {
            complaintDAO.updateStatus(complaintId, "UNDER_INVESTIGATION");
            resp.sendRedirect(req.getContextPath() + "/admin/complaint-monitor?msg=Officer+Assigned");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/complaint-monitor?error=Assignment+Failed");
        }
    }
}
