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

@WebServlet("/DeleteLandlordServlet")
public class DeleteLandlordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        if (!"staff".equals(role)) {
            response.sendRedirect("dashboard.jsp?error=Unauthorized access");
            return;
        }

        String email = request.getParameter("email");

        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection.");
            }

            // Bắt đầu transaction
            conn.setAutoCommit(false);

            // Xóa orders liên quan
            String deleteOrdersQuery = "DELETE FROM orders WHERE landlord_email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteOrdersQuery)) {
                stmt.setString(1, email);
                stmt.executeUpdate();
            }

            // Xóa properties liên quan
            String deletePropertiesQuery = "DELETE FROM properties WHERE owner = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deletePropertiesQuery)) {
                stmt.setString(1, email);
                stmt.executeUpdate();
            }

            // Xóa landlord
            String deleteQuery = "DELETE FROM users WHERE email = ? AND role = 'landlord'";
            try (PreparedStatement stmt = conn.prepareStatement(deleteQuery)) {
                stmt.setString(1, email);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected == 0) {
                    conn.rollback();
                    response.sendRedirect("managelandlords.jsp?error=Landlord not found or already deleted");
                    return;
                }
            }

            // Commit transaction
            conn.commit();
            response.sendRedirect("managelandlords.jsp?success=Landlord deleted successfully");

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            response.sendRedirect("managelandlords.jsp?error=Error deleting landlord: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}