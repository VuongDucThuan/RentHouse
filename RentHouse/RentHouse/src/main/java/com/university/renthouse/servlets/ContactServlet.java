package com.university.renthouse.servlets;

import com.university.renthouse.model.ContactMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    private List<ContactMessage> messageDatabase;

    @Override
    public void init() throws ServletException {
        // Simulate a database with a list
        messageDatabase = new ArrayList<>();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String number = request.getParameter("number");
        String message = request.getParameter("message");

        // Basic validation
        if (name != null && !name.isEmpty() && email != null && !email.isEmpty() && 
            number != null && !number.isEmpty() && message != null && !message.isEmpty()) {
            // Store the message
            ContactMessage contactMessage = new ContactMessage(name, email, number, message);
            messageDatabase.add(contactMessage);

            // Set success message
            request.setAttribute("successMessage", "Message sent successfully!");
        } else {
            // Set error message
            request.setAttribute("errorMessage", "Please fill in all required fields.");
        }

        // Forward back to contact.jsp
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
}