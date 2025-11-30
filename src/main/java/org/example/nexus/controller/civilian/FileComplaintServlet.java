package org.example.nexus.controller.civilian;

import org.example.nexus.model.Complaint;
import org.example.nexus.service.ComplaintService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/file_complaint")
public class FileComplaintServlet extends HttpServlet {

    private ComplaintService service = new ComplaintService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Integer regId = (Integer) session.getAttribute("civilian_reg_id");

        if (regId == null) {
            resp.sendRedirect(req.getContextPath() + "/views/auth/login.jsp?error=Login+Required");
            return;
        }

        try {
            Complaint c = new Complaint();

            c.setRegId(regId);
            c.setComplaintType(req.getParameter("complaint_type"));
            c.setDateOfIncident(LocalDate.parse(req.getParameter("date_of_incident")));

            // FIX: Using "location" from the form input name
            c.setLocationOfIncident(req.getParameter("location"));

            String lat = req.getParameter("latitude");
            String lon = req.getParameter("longitude");

            c.setLatitude(lat == null || lat.isEmpty() ? 0.0 : Double.parseDouble(lat));
            c.setLongitude(lon == null || lon.isEmpty() ? 0.0 : Double.parseDouble(lon));

            c.setDescription(req.getParameter("description"));
            c.setSuspectDetails(req.getParameter("suspect_details"));
            c.setVictimDetails(req.getParameter("victim_details"));
            c.setUrgencyLevel(req.getParameter("urgency_level"));

            boolean success = service.fileComplaint(c);

            if (success) {
                // Redirect back to dashboard to display message and update stats
                resp.sendRedirect(req.getContextPath() + "/civilian/dashboard?msg=Complaint+Submitted");
            } else {
                resp.sendRedirect(req.getContextPath() + "/civilian/dashboard?error=Failed+to+Submit");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/civilian/dashboard?error=Unexpected+Error");
        }
    }
}