package com.university.renthouse.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/SavePropertyServlet")
public class SavePropertyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String propertyId = request.getParameter("propertyId");
        String action = request.getParameter("action");

        // Get or initialize the saved properties list in the session
        List<String> savedProperties = (List<String>) session.getAttribute("savedProperties");
        if (savedProperties == null) {
            savedProperties = new ArrayList<>();
        }

        // Handle save or remove action
        if (propertyId != null && !propertyId.trim().isEmpty()) {
            if ("remove".equals(action)) {
                // Remove propertyId from the list
                savedProperties.remove(propertyId);
            } else if (!savedProperties.contains(propertyId)) {
                // Add propertyId to the list if not already present
                savedProperties.add(propertyId);
            }
            session.setAttribute("savedProperties", savedProperties);
        }

        // Redirect to saveproperties.jsp to view the updated list
        response.sendRedirect("saveproperties.jsp");
    }
}