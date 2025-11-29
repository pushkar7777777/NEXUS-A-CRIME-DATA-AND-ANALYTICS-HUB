package org.example.nexus.controller.police;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.nexus.model.Complaint;
import org.example.nexus.model.PoliceDashboardStats;
import org.example.nexus.service.PoliceDashboardService;

import java.io.IOException;
import java.util.List;

@WebServlet("/police/dashboard")
public class PoliceDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final PoliceDashboardService service = new PoliceDashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // -------- Session Validation --------
        if (session == null || session.getAttribute("police_reg_id") == null) {
            resp.sendRedirect(req.getContextPath() + "/views/auth/login.jsp?error=Login+Required");
            return;
        }

        // Get police ID
        Integer policeId = (Integer) session.getAttribute("police_reg_id");

        if (policeId == null || policeId <= 0) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/views/auth/login.jsp?error=Invalid+Session");
            return;
        }

        try {
            // -------- Dashboard Data Fetch --------
            PoliceDashboardStats stats = service.getStats(policeId);
            List<Complaint> assignedCases = service.getAssignedComplaints(policeId);

            req.setAttribute("stats", stats);
            req.setAttribute("assignedCases", assignedCases);

            // Forward to JSP
            req.getRequestDispatcher("/views/police/dashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/views/auth/login.jsp?error=Dashboard+Load+Failed");
        }
    }
}
