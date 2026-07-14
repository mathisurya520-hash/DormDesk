package com.hostel.controller;

import com.hostel.dao.ComplaintDAO;
import com.hostel.dao.NotificationDAO;
import com.hostel.model.Complaint;
import com.hostel.model.Notification;
import com.hostel.model.User;
import com.hostel.util.ComplaintFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.Date;
import java.util.UUID;

@WebServlet("/complaint")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class ComplaintServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;
    private NotificationDAO notificationDAO;

    @Override
    public void init() {
        complaintDAO = new ComplaintDAO();
        notificationDAO = new NotificationDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            handleAddComplaint(request, response, user);
        } else if ("updateStatus".equals(action)) {
            handleUpdateStatus(request, response, user);
        }
    }

    private void handleAddComplaint(HttpServletRequest request, HttpServletResponse response, User user) throws IOException, ServletException {
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        
        String imageBase64 = null;
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String contentType = filePart.getContentType();
            try (InputStream inputStream = filePart.getInputStream()) {
                byte[] bytes = inputStream.readAllBytes();
                imageBase64 = "data:" + contentType + ";base64," + Base64.getEncoder().encodeToString(bytes);
            }
        }
        
        // Factory Pattern Usage
        Complaint complaint = ComplaintFactory.createComplaint(user.getId(), category, description, user.getHostelType(), user.getBlockName(), imageBase64);
        
        complaintDAO.addComplaint(complaint);
        
        // Notify Warden/Admin about the new complaint
        Notification notif = new Notification(
                UUID.randomUUID().toString(),
                "New " + category + " complaint logged: " + description,
                user.getName() + " (" + user.getBlockName() + ")",
                new Date()
        );
        notificationDAO.addNotification(notif);
        
        response.sendRedirect("dashboard?success=Complaint added successfully");
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        if ("Student".equals(user.getRole())) {
            response.sendRedirect("dashboard?error=Unauthorized action");
            return;
        }

        String complaintId = request.getParameter("complaintId");
        String newStatus = request.getParameter("status"); // Pending, In Progress, Resolved
        
        complaintDAO.updateComplaintStatus(complaintId, newStatus);
        
        response.sendRedirect("dashboard?success=Status updated");
    }
}
