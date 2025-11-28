package org.example.nexus.controller.civilian;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.example.nexus.model.CivilianRegistration;
import org.example.nexus.service.CivilianRegistrationService;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/civilian/updateProfile")
@MultipartConfig
public class UpdateCivilianProfileServlet extends HttpServlet {

    private CivilianRegistrationService service = new CivilianRegistrationService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int regId = Integer.parseInt(req.getParameter("reg_id"));

        // Load existing
        CivilianRegistration civilian = service.getById(regId);

        // Update fields
        civilian.setFullName(req.getParameter("fullName"));
        civilian.setPhone(req.getParameter("phone"));
        civilian.setGender(req.getParameter("gender"));
        civilian.setNationalId(civilian.getNationalId());  // keep old unless changed

        String dob = req.getParameter("dateOfBirth");
        if (dob != null && !dob.isEmpty()) {
            civilian.setDateOfBirth(LocalDate.parse(dob));
        }

        // Photo upload
        Part photoPart = req.getPart("photo");

        if (photoPart != null && photoPart.getSize() > 0) {
            String fileName = "profile_" + regId + ".jpg";

            String uploadPath = req.getServletContext()
                    .getRealPath("/uploads/profile/");
            File folder = new File(uploadPath);
            if (!folder.exists()) folder.mkdirs();

            photoPart.write(uploadPath + File.separator + fileName);
            civilian.setProfilePhoto(fileName);
        }

        // Save to DB
        boolean ok = service.updateProfile(civilian);

        if (ok) {
            req.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            req.setAttribute("errorMessage", "Failed to update profile!");
        }

        // Refresh updated object in session
        CivilianRegistration refreshed = service.getById(regId);
        req.getSession().setAttribute("userProfile", refreshed);

        // Go back to profile page
        req.getRequestDispatcher("/civilian/profile").forward(req, resp);
    }
}
