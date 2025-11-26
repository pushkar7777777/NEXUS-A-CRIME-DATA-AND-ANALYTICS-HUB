package org.example.nexus.controller.civilian;

import org.example.nexus.service.ComplaintService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/civilian/dashboard")
public class CivilianDashboardServlet extends HttpServlet {

    private ComplaintService service = new ComplaintService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user_id") == null) {
            resp.sendRedirect(req.getContextPath() + "/views/auth/login.jsp?error=Login+Required");
            return;
        }

        int regId = (int) session.getAttribute("user_id");

        // Fetch complaint details for logged-in civilian
        session.setAttribute("complaints", service.getComplaintsByUser(regId));
        session.setAttribute("totalFiled", service.getTotalFiled(regId));
        session.setAttribute("inProgress", service.getInProgress(regId));
        session.setAttribute("resolved", service.getResolved(regId));

        // Forward to JSP
        req.getRequestDispatcher("/views/civilian/dashboard.jsp").forward(req, resp);
    }
}
