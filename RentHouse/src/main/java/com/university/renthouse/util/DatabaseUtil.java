package com.university.renthouse.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {
    // Thông tin kết nối cơ sở dữ liệu
    private static final String URL = "jdbc:mysql://localhost:3306/renthouse?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root"; 
    private static final String PASSWORD = "t1234567890"; 

    // Phương thức lấy kết nối đến cơ sở dữ liệu
    public static Connection getConnection() throws SQLException {
        try {
            // Đăng ký driver JDBC (không cần với phiên bản JDBC mới, nhưng để đảm bảo tương thích)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }
        // Trả về kết nối
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Phương thức đóng kết nối (tùy chọn, nếu cần)
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}