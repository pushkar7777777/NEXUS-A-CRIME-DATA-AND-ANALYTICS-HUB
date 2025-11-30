package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.*;
import java.io.IOException;

@WebServlet("/admin/analytics")
public class AnalyticsServlet extends HttpServlet {

    private final PoliceRegistrationDAO policeDAO = new PoliceRegistrationDAO();
    private final CivilianRegistrationDAO civilianDAO = new CivilianRegistrationDAO();
    private final PoliceStationDAO stationDAO = new PoliceStationDAO();
    private final ComplaintRegistrationDAO complaintDAO = new ComplaintRegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // AUTH CHECK
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/views/auth/login.jsp?error=Unauthorized");
            return;
        }

        try {
            // --- Fetch All Counters ---
            int totalPolice           = policeDAO.countAll();
            int totalCivilians        = civilianDAO.countAll();
            int totalStations         = stationDAO.countAll();
            int totalComplaints       = complaintDAO.countAll();

            int resolvedComplaints    = complaintDAO.countByStatus("RESOLVED");
            int investigationComplaints = complaintDAO.countByStatus("UNDER_INVESTIGATION");
            int filedComplaints       = complaintDAO.countByStatus("FILED");
            int underReviewComplaints = complaintDAO.countByStatus("UNDER_REVIEW");

            int assignedComplaints    = complaintDAO.countAssigned();
            int unassignedComplaints  = complaintDAO.countUnassigned();

            // --- Set Attributes For JSP ---
            req.setAttribute("totalPolice", totalPolice);
            req.setAttribute("totalCivilians", totalCivilians);
            req.setAttribute("totalStations", totalStations);
            req.setAttribute("totalComplaints", totalComplaints);

            req.setAttribute("resolvedComplaints", resolvedComplaints);
            req.setAttribute("investigationComplaints", investigationComplaints);
            req.setAttribute("filedComplaints", filedComplaints);
            req.setAttribute("underReviewComplaints", underReviewComplaints);

            req.setAttribute("assignedComplaints", assignedComplaints);
            req.setAttribute("unassignedComplaints", unassignedComplaints);

            // --- Forward To JSP ---
            req.getRequestDispatcher("/views/admin/advanceAnalytics.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/views/admin/advanceAnalytics.jsp?error=Server+Error");
        }
    }
}
