package com.hostel.controller;

import com.hostel.dao.NotificationDAO;
import com.hostel.model.Notification;
import com.hostel.model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

@WebServlet("/notification")
public class NotificationServlet extends HttpServlet {
    private NotificationDAO notificationDAO;

    @Override
    public void init() {
        notificationDAO = new NotificationDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getRole())) {
            response.sendRedirect("dashboard?error=Unauthorized");
            return;
        }

        String message = request.getParameter("message");
        if (message != null && !message.trim().isEmpty()) {
            Notification notif = new Notification(
                    UUID.randomUUID().toString(),
                    message.trim(),
                    user.getName(),
                    new Date()
            );
            notificationDAO.addNotification(notif);
        }

        response.sendRedirect("dashboard?success=Notification broadcasted");
    }
}
