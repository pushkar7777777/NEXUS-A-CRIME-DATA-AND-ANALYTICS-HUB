package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.ComplaintRegistrationDAO;
import org.example.nexus.model.Complaint;

import java.io.IOException;

@WebServlet("/admin/complaint-details")
public class ComplaintDetailsServlet extends HttpServlet {

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

        String cid = req.getParameter("cid");

        if (cid == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/complaint-monitor?error=Missing+Complaint+ID");
            return;
        }

        try {
            int complaintId = Integer.parseInt(cid);

            Complaint c = complaintDAO.getById(complaintId);

            if (c == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/complaint-monitor?error=Complaint+Not+Found");
                return;
            }

            req.setAttribute("complaint", c);
            req.getRequestDispatcher("/views/admin/complaintDetails.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/complaint-monitor?error=Server+Error");
        }
    }
}
