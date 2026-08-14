package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.SystemSetting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;

/**
 * DAO cho bảng System_Setting
 * Chỉ có 1 bản ghi duy nhất — get() và update()
 */
public class SystemSettingDAO {

    private SystemSetting mapRow(ResultSet rs) throws Exception {
        SystemSetting s = new SystemSetting();
        s.setSettingID(rs.getInt("SettingID"));
        s.setHotelName(rs.getString("HotelName"));
        s.setAddress(rs.getString("Address"));
        s.setPhone(rs.getString("Phone"));
        s.setEmail(rs.getString("Email"));
        s.setCheckinTime(rs.getTime("CheckinTime"));
        s.setCheckoutTime(rs.getTime("CheckoutTime"));
        s.setCancelPolicy(rs.getString("CancelPolicy"));
        s.setPaymentMethods(rs.getString("PaymentMethods"));
        s.setOtherSetting(rs.getString("OtherSetting"));
        s.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
        return s;
    }

    /**
     * Lấy cấu hình hệ thống (lấy record đầu tiên)
     */
    public SystemSetting get() {
        String sql = "SELECT TOP 1 * FROM System_Setting";
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật cấu hình hệ thống theo SettingID
     */
    public boolean update(SystemSetting s) {
        String sql = """
            UPDATE System_Setting SET
                HotelName = ?,
                Address = ?,
                Phone = ?,
                Email = ?,
                CheckinTime = ?,
                CheckoutTime = ?,
                CancelPolicy = ?,
                PaymentMethods = ?,
                OtherSetting = ?,
                UpdatedAt = GETDATE()
            WHERE SettingID = ?
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, s.getHotelName());
            ps.setString(2, s.getAddress());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getEmail());
            ps.setTime(5, s.getCheckinTime());
            ps.setTime(6, s.getCheckoutTime());
            ps.setString(7, s.getCancelPolicy());
            ps.setString(8, s.getPaymentMethods());
            ps.setString(9, s.getOtherSetting());
            ps.setInt(10, s.getSettingID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Khởi tạo record mặc định nếu bảng trống
     */
    public void initIfEmpty() {
        String checkSql = "SELECT COUNT(*) FROM System_Setting";
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(checkSql);
            ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next() && rs.getInt(1) == 0) {
                String insertSql = """
                    INSERT INTO System_Setting
                    (HotelName, Address, Phone, Email, CheckinTime, CheckoutTime,
                     CancelPolicy, PaymentMethods, OtherSetting, UpdatedAt)
                    VALUES (N'Luxury Hotel', N'Chưa cấu hình', '', '', '14:00', '12:00',
                     N'Hủy trước 24h được hoàn tiền 100%', N'Tiền mặt,Chuyển khoản', '', GETDATE())
                    """;
                try (PreparedStatement ps2 = con.prepareStatement(insertSql)) {
                    ps2.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
