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
import java.util.logging.Logger;

@WebServlet("/PostPropertyServlet")
public class PostPropertyServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(PostPropertyServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String location = request.getParameter("location");
        String price = request.getParameter("price");
        String image = request.getParameter("image");
        String type = request.getParameter("type");
        String status = request.getParameter("status");
        String bedrooms = request.getParameter("bedrooms");
        String bathrooms = request.getParameter("bathrooms");
        String balcony = request.getParameter("balcony");
        String area = request.getParameter("area");
        String age = request.getParameter("age");
        String roomFloor = request.getParameter("room_floor");
        String totalFloors = request.getParameter("total_floors");
        String furnished = request.getParameter("furnished");
        String loan = request.getParameter("loan");
        String amenities = request.getParameter("amenities");
        String description = request.getParameter("description");
        String deposit = request.getParameter("deposit");
        String propertyStatus = request.getParameter("property_status");

        // Lấy thông tin landlord từ session
        String owner = (String) request.getSession().getAttribute("username");
        String phone = (String) request.getSession().getAttribute("phone");

        // Kiểm tra dữ liệu session
       
        // Kiểm tra các trường bắt buộc
        if (isEmpty(name) || isEmpty(location)) {
            LOGGER.warning("Required fields (name, location) are missing.");
            request.setAttribute("errorMessage", "Please fill in all required fields (name, location).");
            request.getRequestDispatcher("/postproperty.jsp").forward(request, response);
            return;
        }

        // Kiểm tra và parse số
        int bedroomsInt = 0, bathroomsInt = 0, balconyInt = 0;
        try {
            if (!isEmpty(bedrooms)) bedroomsInt = Integer.parseInt(bedrooms);
            if (!isEmpty(bathrooms)) bathroomsInt = Integer.parseInt(bathrooms);
            if (!isEmpty(balcony)) balconyInt = Integer.parseInt(balcony);
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid number format: " + e.getMessage());
            request.setAttribute("errorMessage", "Invalid number format for bedrooms, bathrooms, or balcony.");
            request.getRequestDispatcher("/postproperty.jsp").forward(request, response);
            return;
        }

        // Kiểm tra kết nối database
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection.");
            }
        } catch (SQLException e) {
            LOGGER.severe("Database connection error: " + e.getMessage());
            request.setAttribute("errorMessage", "Database connection error: " + e.getMessage());
            request.getRequestDispatcher("/postproperty.jsp").forward(request, response);
            return;
        }

        // Lưu vào cơ sở dữ liệu
        String sql = "INSERT INTO properties (name, location, price, image, images, owner, phone, type, status, posted_date, total_images, rooms, deposit, property_status, bedrooms, bathrooms, balcony, area, age, room_floor, total_floors, furnished, loan, amenities, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_DATE, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, location);
            stmt.setString(3, price != null ? price : "");
            stmt.setString(4, image != null && !image.trim().isEmpty() ? image : "default.jpg");
            stmt.setString(5, ""); // images: Để trống vì form hiện tại không hỗ trợ nhiều ảnh
            stmt.setString(6, owner);
            stmt.setString(7, phone);
            stmt.setString(8, type != null ? type : "");
            stmt.setString(9, status != null ? status : "");
            stmt.setInt(10, 1); // total_images: Mặc định là 1
            stmt.setString(11, ""); // rooms: Để trống vì form không có trường này
            stmt.setString(12, deposit != null ? deposit : "");
            stmt.setString(13, propertyStatus != null ? propertyStatus : "");
            stmt.setInt(14, bedroomsInt);
            stmt.setInt(15, bathroomsInt);
            stmt.setInt(16, balconyInt);
            stmt.setString(17, area != null ? area : "");
            stmt.setString(18, age != null ? age : "");
            stmt.setString(19, roomFloor != null ? roomFloor : "");
            stmt.setString(20, totalFloors != null ? totalFloors : "");
            stmt.setString(21, furnished != null ? furnished : "");
            stmt.setString(22, loan != null ? loan : "");
            stmt.setString(23, amenities != null ? amenities : "");
            stmt.setString(24, description != null ? description : "");

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("dashboard.jsp?success=Property posted successfully");
            } else {
                LOGGER.warning("No rows affected while inserting property.");
                request.setAttribute("errorMessage", "Failed to post property. No changes made.");
                request.getRequestDispatcher("/postproperty.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            LOGGER.severe("SQL Error: " + e.getMessage());
            request.setAttribute("errorMessage", "SQL Error: " + e.getMessage());
            request.getRequestDispatcher("/postproperty.jsp").forward(request, response);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    LOGGER.severe("Error closing connection: " + e.getMessage());
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/postproperty.jsp").forward(request, response);
    }

    private boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
}