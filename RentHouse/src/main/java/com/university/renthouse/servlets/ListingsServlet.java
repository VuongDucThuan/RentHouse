package com.university.renthouse.servlets;

import com.university.renthouse.model.Property;
import com.university.renthouse.util.DatabaseUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/ListingsServlet")
public class ListingsServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ListingsServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        String category = request.getParameter("category");
        String propertyStatus = request.getParameter("property_status");
        String furnished = request.getParameter("furnished");

        List<Property> properties = fetchProperties(request, type, category, propertyStatus, furnished);

        request.setAttribute("properties", properties);
        if (properties.isEmpty()) {
            String message = "No properties found";
            if (type != null || category != null || propertyStatus != null || furnished != null) {
                message += " matching your criteria.";
            } else {
                message += " at the moment.";
            }
            request.setAttribute("errorMessage", message);
        } else {
            request.setAttribute("errorMessage", "Found " + properties.size() + " properties.");
        }
        request.getRequestDispatcher("/listings.jsp").forward(request, response);
    }

    private List<Property> fetchProperties(HttpServletRequest request, String type, String category, String propertyStatus, String furnished) {
        List<Property> properties = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM properties WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (type != null && !type.trim().isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type.trim());
        }
        if (category != null && !category.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(category.trim());
        }
        if (propertyStatus != null && !propertyStatus.trim().isEmpty()) {
            sql.append(" AND property_status = ?");
            params.add(propertyStatus.trim());
        }
        if (furnished != null && !furnished.trim().isEmpty()) {
            sql.append(" AND furnished = ?");
            params.add(furnished.trim());
        }
        sql.append(" ORDER BY posted_date DESC");

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString());
             ResultSet rs = stmt.executeQuery()) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            while (rs.next()) {
                Property property = new Property(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("location"),
                    rs.getString("price"),
                    rs.getString("image"),
                    rs.getString("images"),
                    rs.getString("owner"),
                    rs.getString("phone"),
                    rs.getString("type"),
                    rs.getString("status"),
                    rs.getDate("posted_date"),
                    rs.getInt("total_images"),
                    rs.getString("rooms"),
                    rs.getString("deposit"),
                    rs.getString("property_status"),
                    rs.getInt("bedrooms"),
                    rs.getInt("bathrooms"),
                    rs.getInt("balcony"),
                    rs.getString("area"),
                    rs.getString("age"),
                    rs.getString("room_floor"),
                    rs.getString("total_floors"),
                    rs.getString("furnished"),
                    rs.getString("loan"),
                    rs.getString("amenities"),
                    rs.getString("description")
                );
                properties.add(property);
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error retrieving properties: " + e.getMessage());
        }
        return properties;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}