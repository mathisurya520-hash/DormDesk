package com.hostel.util;

import com.hostel.model.Complaint;
import java.util.Date;
import java.util.UUID;

/**
 * Factory Pattern for generating Complaints
 * Uses a basic keywords-based logic to auto-determine Priority
 */
public class ComplaintFactory {

    public static Complaint createComplaint(String userId, String category, String description, String hostelType, String blockName, String imageBase64) {
        Complaint complaint = new Complaint();
        complaint.setId(UUID.randomUUID().toString());
        complaint.setUserId(userId);
        complaint.setCategory(category);
        complaint.setDescription(description);
        complaint.setHostelType(hostelType);
        complaint.setBlockName(blockName);
        complaint.setStatus("Pending");
        complaint.setDate(new Date());
        complaint.setImageBase64(imageBase64);

        // Auto-assign priority based on keywords
        complaint.setPriority(determinePriority(description.toLowerCase() + " " + category.toLowerCase()));
        
        return complaint;
    }

    private static String determinePriority(String text) {
        if (text.contains("water") || text.contains("electricity") || text.contains("electrical") || text.contains("power") || text.contains("leak") || text.contains("fire") || text.contains("immediate") || text.contains("urgent") || text.contains("fan") || text.contains("ac") || text.contains("light")) {
            return "High";
        } else if (text.contains("wifi") || text.contains("internet") || text.contains("cleaning") || text.contains("plumbing") || text.contains("carpentry") || text.contains("furniture")) {
            return "Medium";
        } else {
            return "Low";
        }
    }
}
