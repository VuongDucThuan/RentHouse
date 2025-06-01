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
import java.util.logging.Logger;

@WebServlet("/ViewPropertyServlet")
public class ViewPropertyServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ViewPropertyServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String propertyIdStr = request.getParameter("id");
        Property property = null;

        if (propertyIdStr != null) {
            try {
                int propertyId = Integer.parseInt(propertyIdStr);
                property = fetchProperty(propertyId);
            } catch (NumberFormatException e) {
                LOGGER.warning("Invalid property ID format: " + e.getMessage());
                property = null;
            }
        }

        if (property == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Property not found");
            return;
        }

        request.setAttribute("property", property);
        request.getRequestDispatcher("/viewproperty.jsp").forward(request, response);
    }

    private Property fetchProperty(int propertyId) {
        Property property = null;
        
        String sql = "SELECT p.*, u.phone FROM properties p LEFT JOIN users u ON p.owner = u.email WHERE p.id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, propertyId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    property = new Property();
                    property.setId(rs.getInt("id"));
                    property.setName(rs.getString("name"));
                    property.setLocation(rs.getString("location"));
                    property.setPrice(rs.getString("price"));
                    property.setImage(rs.getString("image"));
                    property.setImages(rs.getString("images"));
                    property.setOwner(rs.getString("owner"));
                    String phone = rs.getString("phone");
                    property.setPhone(phone != null ? phone.trim() : null);
                    LOGGER.info("Property ID: " + propertyId + ", Owner: " + rs.getString("owner") + ", Phone from DB: " + (phone != null ? phone : "null"));
                    property.setType(rs.getString("type"));
                    property.setStatus(rs.getString("status"));
                    property.setPostedDate(rs.getDate("posted_date"));
                    property.setTotalImages(rs.getInt("total_images"));
                    property.setRooms(rs.getString("rooms"));
                    property.setDeposit(rs.getString("deposit"));
                    property.setPropertyStatus(rs.getString("property_status"));
                    property.setBedrooms(rs.getInt("bedrooms"));
                    property.setBathrooms(rs.getInt("bathrooms"));
                    property.setBalcony(rs.getInt("balcony"));
                    property.setArea(rs.getString("area"));
                    property.setAge(rs.getString("age"));
                    property.setRoomFloor(rs.getString("room_floor"));
                    property.setTotalFloors(rs.getString("total_floors"));
                    property.setFurnished(rs.getString("furnished"));
                    property.setLoan(rs.getString("loan"));
                    property.setAmenities(rs.getString("amenities"));
                    property.setDescription(rs.getString("description"));
                } else {
                    LOGGER.warning("No property found for ID: " + propertyId);
                }
            }
        } catch (SQLException e) {
            LOGGER.severe("Error fetching property: " + e.getMessage());
        }
        return property;
    }
}