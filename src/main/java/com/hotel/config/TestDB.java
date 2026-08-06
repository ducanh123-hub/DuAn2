package com.hotel.config;

import java.sql.Connection;

public class TestDB {

    public static void main(String[] args) {

        Connection con = DBConnect.getConnection();

        if (con != null) {
            System.out.println("Đã kết nối SQL Server thành công!");
        } else {
            System.out.println("Không thể kết nối SQL Server!");
        }

    }

}