package org.example.nexus.controller.police;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.nexus.dao.ComplaintRegistrationDAO;

import java.io.IOException;

@WebServlet("/police/updateStatus")
public class UpdateCaseStatusServlet extends HttpServlet {

    private ComplaintRegistrationDAO complaintDAO = new ComplaintRegistrationDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int complaintId = Integer.parseInt(req.getParameter("complaintId"));
        String newStatus = req.getParameter("status");

        complaintDAO.updateStatus(complaintId, newStatus);

        resp.sendRedirect(req.getContextPath() + "/police/dashboard");
    }
}
