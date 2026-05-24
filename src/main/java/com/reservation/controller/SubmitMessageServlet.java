package com.reservation.controller;

import com.reservation.service.MessageService;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SubmitMessageServlet")
public class SubmitMessageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        String fullMessage = "Subject: " + subject + " | Message: " + message;

        MessageService ms = new MessageService();
        boolean isSaved = ms.addMessage(name, email, fullMessage);

        if (isSaved) {
            response.sendRedirect("contact.jsp?success=true");
        } else {
            response.sendRedirect("contact.jsp?error=true");
        }
    }
}