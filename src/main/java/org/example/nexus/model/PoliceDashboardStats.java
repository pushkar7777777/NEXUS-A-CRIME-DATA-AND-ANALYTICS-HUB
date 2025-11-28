package org.example.nexus.model;

public class PoliceDashboardStats {

    private int totalAssigned;
    private int inProgress;
    private int resolved;

    public int getTotalAssigned() { return totalAssigned; }
    public void setTotalAssigned(int totalAssigned) { this.totalAssigned = totalAssigned; }

    public int getInProgress() { return inProgress; }
    public void setInProgress(int inProgress) { this.inProgress = inProgress; }

    public int getResolved() { return resolved; }
    public void setResolved(int resolved) { this.resolved = resolved; }
}
