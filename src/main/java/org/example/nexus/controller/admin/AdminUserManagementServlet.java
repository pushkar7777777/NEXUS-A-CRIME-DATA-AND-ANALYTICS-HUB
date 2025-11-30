package org.example.nexus.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.nexus.dao.CivilianRegistrationDAO;
import org.example.nexus.dao.PoliceRegistrationDAO;
import org.example.nexus.model.CivilianRegistration;
import org.example.nexus.model.PoliceRegistration;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/user-management")
public class AdminUserManagementServlet extends HttpServlet {

    private final PoliceRegistrationDAO policeDAO = new PoliceRegistrationDAO();
    private final CivilianRegistrationDAO civilianDAO = new CivilianRegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // --------------------------------------------
        // 1️⃣ ADMIN AUTHENTICATION CHECK
        // --------------------------------------------
        if (session == null ||
                session.getAttribute("role") == null ||
                !"ADMIN".equals(session.getAttribute("role")) ||
                session.getAttribute("admin_id") == null) {

            response.sendRedirect(
                    request.getContextPath() +
                            "/views/auth/login.jsp?error=Unauthorized+Access"
            );
            return;
        }

        // --------------------------------------------
        // 2️⃣ FETCH DATA FROM DATABASE
        // --------------------------------------------
        List<PoliceRegistration> policeUsers = policeDAO.getAll();
        List<CivilianRegistration> civilianUsers = civilianDAO.getAll();

        // --------------------------------------------
        // 3️⃣ SET DATA INTO REQUEST SCOPE (IMPORTANT!)
        // --------------------------------------------
        request.setAttribute("policeUsers", policeUsers);
        request.setAttribute("civilianUsers", civilianUsers);

        // --------------------------------------------
        // 4️⃣ FORWARD TO JSP
        // --------------------------------------------
        request.getRequestDispatcher("/views/admin/userManagement.jsp")
                .forward(request, response);
    }
}
