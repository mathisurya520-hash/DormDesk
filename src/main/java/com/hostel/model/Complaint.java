package com.hostel.model;

import java.util.Date;

public class Complaint {
    private String id;
    private String userId;
    private String category;
    private String description;
    private String status; // Pending, In Progress, Resolved
    private String priority; // High, Medium, Low
    private String hostelType;
    private String blockName;
    private Date date;
    private String imageBase64;

    public Complaint(String id, String userId, String category, String description, String status, String priority, String hostelType, String blockName, Date date, String imageBase64) {
        this.id = id;
        this.userId = userId;
        this.category = category;
        this.description = description;
        this.status = status;
        this.priority = priority;
        this.hostelType = hostelType;
        this.blockName = blockName;
        this.date = date;
        this.imageBase64 = imageBase64;
    }

    public Complaint() {}

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public String getHostelType() { return hostelType; }
    public void setHostelType(String hostelType) { this.hostelType = hostelType; }

    public String getBlockName() { return blockName; }
    public void setBlockName(String blockName) { this.blockName = blockName; }

    public String getImageBase64() { return imageBase64; }
    public void setImageBase64(String imageBase64) { this.imageBase64 = imageBase64; }
}
