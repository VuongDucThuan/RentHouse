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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String confirmPassword = request.getParameter("c_pass");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");

        // Kiểm tra các trường bắt buộc
        if (isEmpty(username) || isEmpty(email) || isEmpty(password) || 
            isEmpty(confirmPassword) || isEmpty(role) || isEmpty(phone)) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu khớp
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra định dạng phone (chỉ chứa số và độ dài hợp lý)
        if (!phone.matches("\\d{10,15}")) {
            request.setAttribute("errorMessage", "Phone number must be 10-15 digits.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DatabaseUtil.getConnection()) {
            // Kiểm tra trùng username
            String checkUsernameQuery = "SELECT COUNT(*) FROM users WHERE username = ?";
            try (PreparedStatement checkUsernameStmt = conn.prepareStatement(checkUsernameQuery)) {
                checkUsernameStmt.setString(1, username);
                try (ResultSet rsUsername = checkUsernameStmt.executeQuery()) {
                    rsUsername.next();
                    if (rsUsername.getInt(1) > 0) {
                        request.setAttribute("errorMessage", "Username already taken.");
                        request.getRequestDispatcher("/register.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Kiểm tra trùng email
            String checkEmailQuery = "SELECT COUNT(*) FROM users WHERE email = ?";
            try (PreparedStatement checkEmailStmt = conn.prepareStatement(checkEmailQuery)) {
                checkEmailStmt.setString(1, email);
                try (ResultSet rsEmail = checkEmailStmt.executeQuery()) {
                    rsEmail.next();
                    if (rsEmail.getInt(1) > 0) {
                        request.setAttribute("errorMessage", "Email already registered.");
                        request.getRequestDispatcher("/register.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Chèn dữ liệu vào bảng users
            String insertQuery = "INSERT INTO users (username, email, password, role, phone) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                insertStmt.setString(1, username);
                insertStmt.setString(2, email);
                insertStmt.setString(3, password); // Lưu ý: Nên mã hóa mật khẩu trong thực tế
                insertStmt.setString(4, role);
                insertStmt.setString(5, phone);
                int rowsAffected = insertStmt.executeUpdate();

                if (rowsAffected > 0) {
                    request.setAttribute("successMessage", "Registration successful! Please log in.");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Registration failed. Please try again.");
                    request.getRequestDispatcher("/register.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    private boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
}