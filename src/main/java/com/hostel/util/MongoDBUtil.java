package com.hostel.util;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

/**
 * Singleton Pattern for MongoDB Connection
 */
public class MongoDBUtil {
    private static MongoDBUtil instance;
    private MongoClient mongoClient;
    private MongoDatabase database;

    private MongoDBUtil() {
        // Connect to MongoDB
        String uri = "mongodb://localhost:27017";
        this.mongoClient = MongoClients.create(uri);
        this.database = mongoClient.getDatabase("smart_hostel_db");
    }

    public static synchronized MongoDBUtil getInstance() {
        if (instance == null) {
            instance = new MongoDBUtil();
        }
        return instance;
    }

    public MongoDatabase getDatabase() {
        return database;
    }

    public void closeConnection() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
}
