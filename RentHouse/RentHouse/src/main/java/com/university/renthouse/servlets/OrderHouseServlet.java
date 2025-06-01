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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet(name = "OrderHouseServlet", urlPatterns = {"/OrderHouseServlet", "/RentHouse/OrderHouseServlet"})
public class OrderHouseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Log thông tin ban đầu
        String propertyId = request.getParameter("property_id");
        String studentEmail = (String) request.getSession().getAttribute("username");
        String role = (String) request.getSession().getAttribute("role");

        System.out.println("DEBUG - [OrderHouseServlet] Received request - Property ID: " + propertyId);
        System.out.println("DEBUG - [OrderHouseServlet] Student Email: " + studentEmail + ", Role: " + role);

        // Kiểm tra role và session
        if (studentEmail == null || !"student".equals(role)) {
            System.out.println("DEBUG - [OrderHouseServlet] Invalid session or role, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Kiểm tra propertyId
        if (propertyId == null || propertyId.trim().isEmpty()) {
            System.out.println("DEBUG - [OrderHouseServlet] Property ID is null or empty");
            response.sendRedirect(request.getContextPath() + "/listings.jsp?error=Invalid property ID");
            return;
        }

        Connection conn = null;
        try {
            int propertyIdInt = Integer.parseInt(propertyId);
            conn = DatabaseUtil.getConnection();
            if (conn == null) {
                System.out.println("DEBUG - [OrderHouseServlet] Database connection failed");
                throw new SQLException("Failed to establish database connection.");
            }
            System.out.println("DEBUG - [OrderHouseServlet] Database connection established");

            // Truy vấn landlord_email từ bảng properties
            String query = "SELECT owner FROM properties WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, propertyIdInt);
                System.out.println("DEBUG - [OrderHouseServlet] Executing query: " + query + " with property_id: " + propertyIdInt);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String landlordEmail = rs.getString("owner");
                        System.out.println("DEBUG - [OrderHouseServlet] Landlord Email: " + landlordEmail);

                        // Chèn dữ liệu vào bảng orders
                        String insertQuery = "INSERT INTO orders (property_id, student_email, landlord_email, order_date, status) VALUES (?, ?, ?, ?, ?)";
                        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                            insertStmt.setInt(1, propertyIdInt);
                            insertStmt.setString(2, studentEmail);
                            insertStmt.setString(3, landlordEmail);
                            insertStmt.setObject(4, LocalDate.now());
                            insertStmt.setString(5, "pending");
                            System.out.println("DEBUG - [OrderHouseServlet] Executing insert query: " + insertQuery);

                            int rowsAffected = insertStmt.executeUpdate();
                            System.out.println("DEBUG - [OrderHouseServlet] Rows affected: " + rowsAffected);

                            response.sendRedirect(request.getContextPath() + "/listings.jsp?success=Order placed successfully");
                        }
                    } else {
                        System.out.println("DEBUG - [OrderHouseServlet] Property not found: " + propertyId);
                        response.sendRedirect(request.getContextPath() + "/listings.jsp?error=Property not found");
                    }
                }
            }
        } catch (NumberFormatException e) {
            System.out.println("DEBUG - [OrderHouseServlet] Invalid property ID format: " + propertyId + ", Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/listings.jsp?error=Invalid property ID format");
        } catch (SQLException e) {
            System.out.println("DEBUG - [OrderHouseServlet] SQLException: " + e.getMessage());
            request.setAttribute("errorMessage", "Error placing order: " + e.getMessage());
            request.getRequestDispatcher(request.getContextPath() + "/listings.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("DEBUG - [OrderHouseServlet] Unexpected error: " + e.getMessage());
            request.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher(request.getContextPath() + "/listings.jsp").forward(request, response);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    System.out.println("DEBUG - [OrderHouseServlet] Database connection closed");
                } catch (SQLException e) {
                    System.out.println("DEBUG - [OrderHouseServlet] Error closing connection: " + e.getMessage());
                }
            }
        }
    }
}