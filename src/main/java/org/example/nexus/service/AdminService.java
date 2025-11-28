package org.example.nexus.service;

import org.example.nexus.dao.AdminDashboardDAO;
import org.example.nexus.model.Activity;
import org.example.nexus.model.ComplaintSummary;

import java.util.List;

public class AdminService {

    private AdminDashboardDAO dao = new AdminDashboardDAO();

    public int getTotalCivilians()

    { return dao.getTotalCivilians();
    }
    public int getTotalPolice()      { return dao.getTotalPolice(); }
    public int getTotalStations()    { return dao.getTotalStations(); }
    public int getTotalComplaints()  { return dao.getTotalComplaints(); }

    public ComplaintSummary getComplaintSummary() {
        return dao.getComplaintSummary();
    }

    public List<Activity> getRecentActivity() {
        return dao.getRecentActivity();
    }
}

