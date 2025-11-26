package org.example.nexus.controller.police;

import org.example.nexus.service.ComplaintService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/update_complaint_status")
public class UpdateComplaintStatusServlet extends HttpServlet {

    private ComplaintService service = new ComplaintService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int complaintId = Integer.parseInt(req.getParameter("complaint_id"));
        String status = req.getParameter("status");

        boolean updated = service.updateStatus(complaintId, status);

        if (updated) {
            resp.sendRedirect(req.getContextPath() + "/views/police/complaints.jsp?msg=Status+Updated");
        } else {
            resp.sendRedirect(req.getContextPath() + "/views/police/complaints.jsp?error=Update+Failed");
        }
    }
}
