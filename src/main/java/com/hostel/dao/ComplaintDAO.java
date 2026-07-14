package com.hostel.dao;

import com.hostel.model.Complaint;
import com.hostel.util.MongoDBUtil;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import org.bson.Document;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class ComplaintDAO {
    private MongoCollection<Document> complaintsCollection;

    public ComplaintDAO() {
        complaintsCollection = MongoDBUtil.getInstance().getDatabase().getCollection("complaints");
    }

    public void addComplaint(Complaint complaint) {
        Document doc = new Document("_id", complaint.getId())
                .append("userId", complaint.getUserId())
                .append("category", complaint.getCategory())
                .append("description", complaint.getDescription())
                .append("status", complaint.getStatus())
                .append("priority", complaint.getPriority())
                .append("hostelType", complaint.getHostelType())
                .append("blockName", complaint.getBlockName())
                .append("date", complaint.getDate())
                .append("imageBase64", complaint.getImageBase64());

        complaintsCollection.insertOne(doc);
    }

    public List<Complaint> getAllComplaints() {
        List<Complaint> complaints = new ArrayList<>();
        try (MongoCursor<Document> cursor = complaintsCollection.find().iterator()) {
            while (cursor.hasNext()) {
                Document doc = cursor.next();
                complaints.add(mapDocumentToComplaint(doc));
            }
        }
        
        // Using Streams API and Lambda Expressions for sorting by date (descending)
        return complaints.stream()
                .sorted((c1, c2) -> c2.getDate().compareTo(c1.getDate()))
                .collect(Collectors.toList());
    }

    public List<Complaint> getComplaintsByUserId(String userId) {
        List<Complaint> allComplaints = getAllComplaints();
        
        // Using Streams API
        return allComplaints.stream()
                .filter(c -> c.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    public void updateComplaintStatus(String complaintId, String newStatus) {
        complaintsCollection.updateOne(
                Filters.eq("_id", complaintId),
                Updates.set("status", newStatus)
        );
    }
    
    // Additional feature requested by user to showcase Iterator Pattern / Streams
    public List<Complaint> getPendingComplaints() {
        return getAllComplaints().stream()
                .filter(c -> c.getStatus().equals("Pending"))
                .collect(Collectors.toList());
    }

    private Complaint mapDocumentToComplaint(Document doc) {
        return new Complaint(
                doc.getString("_id"),
                doc.getString("userId"),
                doc.getString("category"),
                doc.getString("description"),
                doc.getString("status"),
                doc.getString("priority"),
                doc.getString("hostelType"),
                doc.getString("blockName"),
                doc.getDate("date"),
                doc.getString("imageBase64")
        );
    }
}
