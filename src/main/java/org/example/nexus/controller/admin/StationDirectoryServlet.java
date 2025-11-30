package org.example.nexus.controller.admin;

import org.example.nexus.dao.PoliceStationDAO;
import org.example.nexus.dao.PoliceRegistrationDAO;
import org.example.nexus.model.PoliceStation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/station-directory")
public class StationDirectoryServlet extends HttpServlet {

    private PoliceStationDAO stationDAO = new PoliceStationDAO();
    private PoliceRegistrationDAO policeDAO = new PoliceRegistrationDAO();  // ★ NEW DAO

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // --- AUTH GUARD ---
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/views/auth/login.jsp?error=Unauthorized");
            return;
        }

        try {
            // 1. Load All Stations
            List<PoliceStation> stationList = stationDAO.getAllStations();

            // 2. Add officer count for each station
            for (PoliceStation st : stationList) {
                int count = policeDAO.countOfficersByStation(st.getPoliceStationId());
                st.setOfficerCount(count); // <-- MAKE SURE MODEL HAS THIS FIELD
            }

            // 3. Send updated data to JSP
            req.setAttribute("stationList", stationList);

            req.getRequestDispatcher("/views/admin/station_dept.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load station directory");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }
}
