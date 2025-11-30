package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.model.ComplaintSummary;
import org.example.nexus.service.AdminService;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ---------------------------------------------------------
        // 1️⃣ SESSION SECURITY — Ensure Admin is Authenticated
        // ---------------------------------------------------------
        if (session == null ||
                session.getAttribute("role") == null ||
                !"ADMIN".equals(session.getAttribute("role")) ||
                session.getAttribute("admin_id") == null) {

            // kill invalid session
            if (session != null) session.invalidate();

            response.sendRedirect(
                    request.getContextPath() +
                            "/views/auth/login.jsp?error=Please+login+as+Admin"
            );
            return;
        }

        // ---------------------------------------------------------
        // 2️⃣ LOAD ADMIN DASHBOARD DATA FROM DATABASE
        // ---------------------------------------------------------
        request.setAttribute("totalCivilians", adminService.getTotalCivilians());
        request.setAttribute("totalPolice", adminService.getTotalPolice());
        request.setAttribute("totalStations", adminService.getTotalStations());
        request.setAttribute("totalComplaints", adminService.getTotalComplaints());

        ComplaintSummary summary = adminService.getComplaintSummary();
        request.setAttribute("summary", summary);

        request.setAttribute("recentActivity", adminService.getRecentActivity());

        // ---------------------------------------------------------
        // 3️⃣ FORWARD TO JSP (MVC Pattern)
        // ---------------------------------------------------------
        request.getRequestDispatcher("/views/admin/dashboard.jsp")
                .forward(request, response);
    }
}
