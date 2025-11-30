package org.example.nexus.controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.example.nexus.dao.ComplaintRegistrationDAO;
import org.example.nexus.model.Complaint;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/complaint-monitor")
public class ComplaintMonitorServlet extends HttpServlet {

    private final ComplaintRegistrationDAO complaintDAO = new ComplaintRegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /* ---------------- AUTH GUARD ---------------- */
        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("role") == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp?error=Unauthorized+Access");
            return;
        }

        /* ---------------- FETCH COMPLAINTS ---------------- */
        List<Complaint> complaints = complaintDAO.getAllComplaints();

        request.setAttribute("complaints", complaints);

        /* ---------------- FORWARD TO JSP ---------------- */
        request.getRequestDispatcher("/views/admin/complaintMonitor.jsp")
                .forward(request, response);
    }
}
