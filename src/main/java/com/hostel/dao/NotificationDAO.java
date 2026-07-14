package com.hostel.dao;

import com.hostel.model.Notification;
import com.hostel.util.MongoDBUtil;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import org.bson.Document;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class NotificationDAO {
    private MongoCollection<Document> notificationsCollection;

    public NotificationDAO() {
        notificationsCollection = MongoDBUtil.getInstance().getDatabase().getCollection("notifications");
    }

    public void addNotification(Notification notification) {
        Document doc = new Document("_id", notification.getId())
                .append("message", notification.getMessage())
                .append("senderName", notification.getSenderName())
                .append("date", notification.getDate());
        notificationsCollection.insertOne(doc);
    }

    public List<Notification> getAllNotifications() {
        List<Notification> notifications = new ArrayList<>();
        try (MongoCursor<Document> cursor = notificationsCollection.find().iterator()) {
            while (cursor.hasNext()) {
                Document doc = cursor.next();
                notifications.add(new Notification(
                        doc.getString("_id"),
                        doc.getString("message"),
                        doc.getString("senderName"),
                        doc.getDate("date")
                ));
            }
        }
        
        return notifications.stream()
                .sorted((n1, n2) -> n2.getDate().compareTo(n1.getDate()))
                .collect(Collectors.toList());
    }
}
