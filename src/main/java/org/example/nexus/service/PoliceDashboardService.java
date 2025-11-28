package org.example.nexus.service;


import org.example.nexus.dao.PoliceDashboardDAO;
import org.example.nexus.model.Complaint;
import org.example.nexus.model.PoliceDashboardStats;

import java.util.List;

public class PoliceDashboardService {

    private PoliceDashboardDAO dao = new PoliceDashboardDAO();

    public PoliceDashboardStats getStats(int policeRegId) {
        return dao.getDashboardStats(policeRegId);
    }

    public List<Complaint> getAssignedComplaints(int policeRegId) {
        return dao.getAssignedComplaints(policeRegId);
    }
}
