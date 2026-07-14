package com.hostel.model;

public class Assignment {
    private String complaintId;
    private String workerId;

    public Assignment(String complaintId, String workerId) {
        this.complaintId = complaintId;
        this.workerId = workerId;
    }

    public Assignment() {}

    public String getComplaintId() { return complaintId; }
    public void setComplaintId(String complaintId) { this.complaintId = complaintId; }

    public String getWorkerId() { return workerId; }
    public void setWorkerId(String workerId) { this.workerId = workerId; }
}
