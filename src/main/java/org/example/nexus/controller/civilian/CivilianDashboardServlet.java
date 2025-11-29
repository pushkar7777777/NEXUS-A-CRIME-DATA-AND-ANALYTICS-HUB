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

        if (session == null || session.getAttribute("civilian_reg_id") == null)
        {
            resp.sendRedirect(req.getContextPath() + "/views/auth/login.jsp?error=Login+Required");
            return;
        }
        int reg_Id = (int) session.getAttribute("civilian_reg_id");
        System.out.println(reg_Id);
        // Fetch complaint details for logged-in civilian
        session.setAttribute("complaints", service.getComplaintsByUser(reg_Id));
        session.setAttribute("totalFiled", service.getTotalFiled(reg_Id));
        session.setAttribute("inProgress", service.getInProgress(reg_Id));
        session.setAttribute("resolved", service.getResolved(reg_Id));

        // Forward to JSP
        req.getRequestDispatcher("/views/civilian/dashboard.jsp").forward(req, resp);
    }
}
