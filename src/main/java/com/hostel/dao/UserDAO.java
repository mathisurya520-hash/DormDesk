package com.hostel.dao;

import com.hostel.model.User;
import com.hostel.util.MongoDBUtil;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import java.util.UUID;

public class UserDAO {
    private MongoCollection<Document> usersCollection;

    public UserDAO() {
        usersCollection = MongoDBUtil.getInstance().getDatabase().getCollection("users");
    }

    public boolean registerUser(User user) {
        Document existingUser = usersCollection.find(Filters.eq("email", user.getEmail())).first();
        if (existingUser != null) {
            return false; // User already exists
        }
        
        user.setId(UUID.randomUUID().toString());
        Document doc = new Document("_id", user.getId())
                .append("name", user.getName())
                .append("email", user.getEmail())
                .append("password", user.getPassword()) // In a real app, hash password
                .append("role", user.getRole())
                .append("hostelType", user.getHostelType())
                .append("blockName", user.getBlockName());
        
        usersCollection.insertOne(doc);
        return true;
    }

    public User loginUser(String email, String password) {
        Document doc = usersCollection.find(Filters.and(
                Filters.eq("email", email),
                Filters.eq("password", password)
        )).first();

        if (doc != null) {
            return new User(
                    doc.getString("_id"),
                    doc.getString("name"),
                    doc.getString("email"),
                    doc.getString("password"),
                    doc.getString("role"),
                    doc.getString("hostelType"),
                    doc.getString("blockName")
            );
        }
        return null;
    }

    public User getUserById(String id) {
        Document doc = usersCollection.find(Filters.eq("_id", id)).first();
        if (doc != null) {
            return new User(
                    doc.getString("_id"),
                    doc.getString("name"),
                    doc.getString("email"),
                    doc.getString("password"),
                    doc.getString("role"),
                    doc.getString("hostelType"),
                    doc.getString("blockName")
            );
        }
        return null;
    }
}
