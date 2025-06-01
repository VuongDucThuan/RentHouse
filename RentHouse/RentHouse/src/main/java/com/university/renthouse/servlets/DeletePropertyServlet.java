package com.university.renthouse.servlets;

import com.university.renthouse.util.DatabaseUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/DeletePropertyServlet")
public class DeletePropertyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        String role = (String) request.getSession().getAttribute("role");

        if (!"landlord".equals(role)) {
            response.sendRedirect("dashboard.jsp?error=Unauthorized access");
            return;
        }

        String propertyId = request.getParameter("property_id");

        Connection conn = null;
        try {
            int propertyIdInt = Integer.parseInt(propertyId);
            conn = DatabaseUtil.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection.");
            }

            // Xóa các đơn đặt liên quan trước (nếu có)
            String deleteOrdersQuery = "DELETE FROM orders WHERE property_id = ? AND landlord_email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteOrdersQuery)) {
                stmt.setInt(1, propertyIdInt);
                stmt.setString(2, username);
                stmt.executeUpdate();
            }

            // Xóa property
            String query = "DELETE FROM properties WHERE id = ? AND owner = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, propertyIdInt);
                stmt.setString(2, username);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected == 0) {
                    response.sendRedirect("dashboard.jsp?error=Property not found or unauthorized");
                    return;
                }
            }

            response.sendRedirect("dashboard.jsp?success=Property deleted successfully");
        } catch (NumberFormatException e) {
            response.sendRedirect("dashboard.jsp?error=Invalid property ID");
        } catch (SQLException e) {
            response.sendRedirect("dashboard.jsp?error=Error deleting property: " + e.getMessage());
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}