package org.example.nexus.controller.civilian;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.example.nexus.service.ComplaintService;

import java.io.IOException;

@WebServlet("/civilian/complaints")
public class ViewAllComplaintsServlet extends HttpServlet {

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

        req.setAttribute("complaints", service.getComplaintsByUser(regId));

        req.getRequestDispatcher("/views/civilian/viewComplaints.jsp")
                .forward(req, resp);
    }
}
