package org.example.nexus.controller.civilian;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.example.nexus.model.CivilianRegistration;
import org.example.nexus.service.CivilianRegistrationService;

import java.io.IOException;

@WebServlet("/civilian/profile")
public class CivilianProfileServlet extends HttpServlet {

    private CivilianRegistrationService service = new CivilianRegistrationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("civilian_reg_id") == null) {
            resp.sendRedirect(req.getContextPath() + "/views/auth/login.jsp?error=Login+Required");
            return;
        }

        int regId = (int) session.getAttribute("civilian_reg_id");

        // get profile
        CivilianRegistration civilian = service.getById(regId);

        // store
        session.setAttribute("userProfile", civilian);

        // show JSP
        req.getRequestDispatcher("/views/civilian/profile.jsp").forward(req, resp);
    }
}
