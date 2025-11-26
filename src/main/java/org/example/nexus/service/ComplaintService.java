package org.example.nexus.service;

import org.example.nexus.dao.ComplaintRegistrationDAO;
import org.example.nexus.model.Complaint;

import java.util.List;

public class ComplaintService {

    private ComplaintRegistrationDAO dao = new ComplaintRegistrationDAO();

    public boolean fileComplaint(Complaint c) {
        return dao.insert(c);
    }

    public List<Complaint> getComplaintsByUser(int userId) {
        return dao.getByUserId(userId);
    }

    // 1. Total Filed (Now counts ALL complaints for the user)
    public int getTotalFiled(int userId) {
        return dao.getCountAll(userId);
    }

    // 2. In Progress (Counts UNDER_INVESTIGATION + UNDER_REVIEW)
    public int getInProgress(int userId) {
        // Assuming DAO has a method to count multiple statuses
        return dao.getCountMultiStatus(userId, "UNDER_INVESTIGATION", "UNDER_REVIEW");
    }

    // 3. Resolved
    public int getResolved(int userId) {
        return dao.getCount(userId, "RESOLVED");
    }

    public boolean updateStatus(int complaintId, String status) {
        return dao.updateStatus(complaintId, status);
    }
}