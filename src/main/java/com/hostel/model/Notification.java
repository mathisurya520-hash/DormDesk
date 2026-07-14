package com.hostel.model;

import java.util.Date;

public class Notification {
    private String id;
    private String message;
    private String senderName;
    private Date date;

    public Notification() {}

    public Notification(String id, String message, String senderName, Date date) {
        this.id = id;
        this.message = message;
        this.senderName = senderName;
        this.date = date;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getSenderName() { return senderName; }
    public void setSenderName(String senderName) { this.senderName = senderName; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
}
