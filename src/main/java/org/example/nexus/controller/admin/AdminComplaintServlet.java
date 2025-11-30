package org.example.nexus.controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.ComplaintRegistrationDAO;
import org.example.nexus.model.Complaint;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/complaints")
public class AdminComplaintServlet extends HttpServlet {

    private final ComplaintRegistrationDAO complaintDAO = new ComplaintRegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Admin authentication
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/views/auth/login.jsp?error=Unauthorized");
            return;
        }

        // Load all complaints
        List<Complaint> allComplaints = complaintDAO.getAllComplaints();

        // Pass to JSP (request scope)
        req.setAttribute("complaints", allComplaints);

        req.getRequestDispatcher("/views/admin/complaintMonitor.jsp")
                .forward(req, resp);
    }
}
