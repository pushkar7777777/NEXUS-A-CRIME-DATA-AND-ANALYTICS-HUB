package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.ComplaintRegistrationDAO;
import org.example.nexus.dao.PoliceStationDAO;
import org.example.nexus.dao.PoliceRegistrationDAO;
import org.example.nexus.model.Complaint;
import org.example.nexus.model.PoliceStation;
import org.example.nexus.model.PoliceRegistration;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/assign-officer")
public class AssignOfficerServlet extends HttpServlet {

    private final ComplaintRegistrationDAO complaintDAO = new ComplaintRegistrationDAO();
    private final PoliceStationDAO stationDAO = new PoliceStationDAO();
    private final PoliceRegistrationDAO policeDAO = new PoliceRegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔥 Step 1: Safely read "cid"
        String cidParam = req.getParameter("cid");

        if (cidParam == null || cidParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/complaint-monitor?error=Missing+Complaint+ID");
            return;
        }

        int complaintId;
        try {
            complaintId = Integer.parseInt(cidParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/complaint-monitor?error=Invalid+Complaint+ID");
            return;
        }

        // 🔥 Step 2: Fetch Complaint
        Complaint complaint = complaintDAO.getById(complaintId);
        if (complaint == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/complaint-monitor?error=Complaint+Not+Found");
            return;
        }

        // 🔥 Step 3: Find nearest station
        PoliceStation nearestStation = stationDAO.getNearestStation(complaint.getLocationOfIncident());

        List<PoliceRegistration> officers = new ArrayList<>();

        if (nearestStation != null) {
            officers = policeDAO.getOfficersByStation(nearestStation.getPoliceStationId());
        }

        // 🔥 Step 4: Set attributes and forward
        req.setAttribute("complaint", complaint);
        req.setAttribute("nearestStation", nearestStation);
        req.setAttribute("officers", officers);

        req.getRequestDispatcher("/views/admin/assignOfficer.jsp").forward(req, resp);
    }
}
