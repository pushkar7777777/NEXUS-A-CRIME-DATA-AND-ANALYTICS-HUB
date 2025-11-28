package org.example.nexus.model;


public class ComplaintSummary {
    private int filed;
    private int underReview;
    private int underInvestigation;
    private int resolved;
    private int closed;

    public int getFiled() { return filed; }
    public void setFiled(int filed) { this.filed = filed; }

    public int getUnderReview() { return underReview; }
    public void setUnderReview(int underReview) { this.underReview = underReview; }

    public int getUnderInvestigation() { return underInvestigation; }
    public void setUnderInvestigation(int underInvestigation) { this.underInvestigation = underInvestigation; }

    public int getResolved() { return resolved; }
    public void setResolved(int resolved) { this.resolved = resolved; }

    public int getClosed() { return closed; }
    public void setClosed(int closed) { this.closed = closed; }
}
