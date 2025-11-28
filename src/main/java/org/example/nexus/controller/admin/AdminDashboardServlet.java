package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.nexus.model.ComplaintSummary;
import org.example.nexus.service.AdminService;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. | KPI numbers
        request.setAttribute("totalCivilians", adminService.getTotalCivilians());
        System.out.println(adminService.getTotalCivilians());
        request.setAttribute("totalPolice", adminService.getTotalPolice());
        request.setAttribute("totalStations", adminService.getTotalStations());
        request.setAttribute("totalComplaints", adminService.getTotalComplaints());

        // 2. | Complaint Status Summary for doughnut chart
        ComplaintSummary summary = adminService.getComplaintSummary();
        request.setAttribute("summary", summary);

        // 3. | Recent Activity
        request.setAttribute("recentActivity", adminService.getRecentActivity());

        // 4. | Forward to JSP
        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }
}
