package com.hotel.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {

    private static final String SERVER = "localhost\\SQLEXPRESS"; // Đổi theo máy bạn
    private static final String DATABASE = "HotelManagement";
    private static final String USER = "sa";
    private static final String PASSWORD = "123456"; // Đổi mật khẩu SQL Server

    private static final String URL =
            "jdbc:sqlserver://" + SERVER +
                    ";databaseName=" + DATABASE +
                    ";encrypt=true;" +
                    ";trustServerCertificate=true";

    public static Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("========== KẾT NỐI THÀNH CÔNG ==========");

            return conn;

        } catch (Exception e) {

            System.out.println("========== KẾT NỐI THẤT BẠI ==========");
            e.printStackTrace();

            return null;
        }
    }
}