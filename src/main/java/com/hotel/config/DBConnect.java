package com.hotel.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {

    // 1. Cấu hình thông tin tài khoản SQL Server của bạn
    private static final String HOST = "localhost";
    private static final String PORT = "1433"; // Mặc định là 1433 (đối với bản Developer/Enterprise hoặc Express đã bật cổng tĩnh)
    private static final String INSTANCE = "SQLEXPRESS"; // Đối với SQL Server Express (nếu kết nối qua cổng tĩnh thất bại)
    private static final String DATABASE = "HotelManagement";
    private static final String USER = "sa";
    private static final String PASSWORD = "123456"; // Đổi mật khẩu tài khoản SQL Server của bạn ở đây

    // 2. Lựa chọn URL kết nối phù hợp:
    
    // Cách A: Kết nối trực tiếp qua Cổng (Port) tĩnh 1433 (KHUYÊN DÙNG vì tính ổn định cao)
    private static final String URL_PORT = "jdbc:sqlserver://" + HOST + ":" + PORT + 
            ";databaseName=" + DATABASE + 
            ";encrypt=true;" + 
            ";trustServerCertificate=true";

    // Cách B: Kết nối qua Tên thể hiện (Instance Name - SQLEXPRESS) 
    // (Yêu cầu dịch vụ "SQL Server Browser" trong Services của Windows phải được bật/running)
    private static final String URL_INSTANCE = "jdbc:sqlserver://" + HOST + 
            ";instanceName=" + INSTANCE + 
            ";databaseName=" + DATABASE + 
            ";encrypt=true;" + 
            ";trustServerCertificate=true";

    public static Connection getConnection() {
        // Thay đổi URL ở dòng dưới (URL_PORT hoặc URL_INSTANCE) tùy theo cấu hình máy bạn
        String selectedUrl = URL_PORT; 

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            Connection conn = DriverManager.getConnection(selectedUrl, USER, PASSWORD);
            System.out.println("========== KẾT NỐI DATABASE THÀNH CÔNG ==========");
            return conn;

        } catch (Exception e1) {
            // Nếu kết nối qua cổng thất bại, tự động thử kết nối qua Instance Name
            if (selectedUrl.equals(URL_PORT)) {
                try {
                    System.out.println("Thử kết nối qua Instance (SQLEXPRESS)...");
                    Connection conn = DriverManager.getConnection(URL_INSTANCE, USER, PASSWORD);
                    System.out.println("========== KẾT NỐI DATABASE THÀNH CÔNG (INSTANCE) ==========");
                    return conn;
                } catch (Exception e2) {
                    System.out.println("========== KẾT NỐI DATABASE THẤT BẠI ==========");
                    e2.printStackTrace();
                }
            } else {
                System.out.println("========== KẾT NỐI DATABASE THẤT BẠI ==========");
                e1.printStackTrace();
            }
            return null;
        }
    }
}