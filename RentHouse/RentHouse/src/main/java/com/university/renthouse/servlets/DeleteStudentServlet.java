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

@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
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

            // Xóa các orders liên quan trước
            String deleteOrdersQuery = "DELETE FROM orders WHERE student_email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteOrdersQuery)) {
                stmt.setString(1, email);
                stmt.executeUpdate();
            }

            // Xóa student
            String deleteQuery = "DELETE FROM users WHERE email = ? AND role = 'student'";
            try (PreparedStatement stmt = conn.prepareStatement(deleteQuery)) {
                stmt.setString(1, email);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected == 0) {
                    response.sendRedirect("managestudents.jsp?error=Student not found");
                    return;
                }
            }

            response.sendRedirect("managestudents.jsp?success=Student deleted successfully");
        } catch (SQLException e) {
            response.sendRedirect("managestudents.jsp?error=Error deleting student: " + e.getMessage());
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}