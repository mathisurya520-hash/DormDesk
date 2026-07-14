package com.hostel.controller;

import com.hostel.dao.ComplaintDAO;
import com.hostel.dao.UserDAO;
import com.hostel.dao.NotificationDAO;
import com.hostel.model.Complaint;
import com.hostel.model.Notification;
import com.hostel.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;
    private NotificationDAO notificationDAO;

    @Override
    public void init() {
        complaintDAO = new ComplaintDAO();
        notificationDAO = new NotificationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String role = user.getRole();

        if ("Student".equals(role)) {
            loadStudentDashboard(request, response, user);
        } else if ("Admin".equals(role)) {
            loadAdminDashboard(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private void loadStudentDashboard(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        List<Complaint> complaints = complaintDAO.getComplaintsByUserId(user.getId());
        
        long total = complaints.size();
        long pending = complaints.stream().filter(c -> "Pending".equals(c.getStatus())).count();
        long resolved = complaints.stream().filter(c -> "Resolved".equals(c.getStatus())).count();
        
        request.setAttribute("complaints", complaints);
        request.setAttribute("totalComplaints", total);
        request.setAttribute("pendingComplaints", pending);
        request.setAttribute("resolvedComplaints", resolved);
        
        List<Notification> notifications = notificationDAO.getAllNotifications();
        request.setAttribute("notifications", notifications);
        
        request.getRequestDispatcher("student-dashboard.jsp").forward(request, response);
    }

    private void loadAdminDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Complaint> complaints = complaintDAO.getAllComplaints();
        
        long total = complaints.size();
        long pending = complaints.stream().filter(c -> "Pending".equals(c.getStatus())).count();
        long inProgress = complaints.stream().filter(c -> "In Progress".equals(c.getStatus())).count();
        long resolved = complaints.stream().filter(c -> "Resolved".equals(c.getStatus())).count();
        
        request.setAttribute("complaints", complaints);
        request.setAttribute("totalComplaints", total);
        request.setAttribute("pendingComplaints", pending);
        request.setAttribute("inProgressComplaints", inProgress);
        request.setAttribute("resolvedComplaints", resolved);
        
        List<Notification> notifications = notificationDAO.getAllNotifications();
        request.setAttribute("notifications", notifications);
        
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }


}
