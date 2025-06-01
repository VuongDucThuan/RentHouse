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

@WebServlet("/ManageOrderServlet")
public class ManageOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        String username = (String) request.getSession().getAttribute("username");

        // Kiểm tra vai trò hợp lệ (staff hoặc landlord)
        if (!("staff".equals(role) || "landlord".equals(role))) {
            response.sendRedirect("dashboard.jsp?error=Unauthorized access");
            return;
        }

        String orderId = request.getParameter("order_id");
        String action = request.getParameter("action");

        Connection conn = null;
        try {
            int orderIdInt = Integer.parseInt(orderId);
            conn = DatabaseUtil.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection.");
            }

            String query;
            if ("landlord".equals(role)) {
                query = "UPDATE orders SET status = ? WHERE id = ? AND landlord_email = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, "confirm".equals(action) ? "confirmed" : "canceled");
                    stmt.setInt(2, orderIdInt);
                    stmt.setString(3, username);
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected == 0) {
                        response.sendRedirect("dashboard.jsp?error=You are not authorized to manage this order");
                        return;
                    }
                }
            } else { // staff
                query = "UPDATE orders SET status = ? WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, "confirm".equals(action) ? "confirmed" : "canceled");
                    stmt.setInt(2, orderIdInt);
                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected == 0) {
                        response.sendRedirect("manageorders.jsp?error=Order not found");
                        return;
                    }
                }
            }

            String redirectUrl = "landlord".equals(role) ? "dashboard.jsp" : "manageorders.jsp";
            response.sendRedirect(request.getContextPath() + "/" + redirectUrl + "?success=Order " + ("confirm".equals(action) ? "confirmed" : "canceled") + " successfully");
        } catch (NumberFormatException e) {
            response.sendRedirect("dashboard.jsp?error=Invalid order ID");
        } catch (SQLException e) {
            String redirectUrl = "landlord".equals(role) ? "dashboard.jsp" : "manageorders.jsp";
            request.setAttribute("errorMessage", "Error updating order: " + e.getMessage());
            request.getRequestDispatcher(redirectUrl).forward(request, response);
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}