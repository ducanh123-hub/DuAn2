package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO implements BaseDAO<User> {

    @Override
    public List<User> getAll() {

        List<User> list = new ArrayList<>();

        String sql = "SELECT * FROM [User]";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                User user = new User();

                user.setUserID(rs.getInt("UserID"));
                user.setRoleID(rs.getInt("RoleID"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setPassword(rs.getString("Password"));
                user.setGender(rs.getString("Gender"));
                user.setDate(rs.getDate("Date"));
                user.setCccd(rs.getString("CCCD"));
                user.setAddress(rs.getString("Address"));
                user.setNationality(rs.getString("Nationality"));
                user.setStatus(rs.getString("Status"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                user.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

                list.add(user);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }

    @Override
    public User getById(int id) {

        String sql = "SELECT * FROM [User] WHERE UserID = ?";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();

                    user.setUserID(rs.getInt("UserID"));
                    user.setRoleID(rs.getInt("RoleID"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPhone(rs.getString("Phone"));
                    user.setPassword(rs.getString("Password"));
                    user.setGender(rs.getString("Gender"));
                    user.setDate(rs.getDate("Date"));
                    user.setCccd(rs.getString("CCCD"));
                    user.setAddress(rs.getString("Address"));
                    user.setNationality(rs.getString("Nationality"));
                    user.setStatus(rs.getString("Status"));
                    user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    user.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

                    return user; }
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean insert(User user) {

        String sql = """
            INSERT INTO [User]
            (
                RoleID,
                FullName,
                Email,
                Phone,
                Password,
                Gender,
                Date,
                CCCD,
                Address,
                Nationality,
                Status
            )
            VALUES(?,?,?,?,?,?,?,?,?,?,?)
            """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, user.getRoleID());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getGender());
            ps.setDate(7, user.getDate());
            ps.setString(8, user.getCccd());
            ps.setString(9, user.getAddress());
            ps.setString(10, user.getNationality());
            ps.setString(11, user.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean update(User user) {

        String sql = """
            UPDATE [User]
            SET
                RoleID=?,
                FullName=?,
                Email=?,
                Phone=?,
                Password=?,
                Gender=?,
                Date=?,
                CCCD=?,
                Address=?,
                Nationality=?,
                Status=?,
                UpdatedAt=GETDATE()
            WHERE UserID=?
            """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, user.getRoleID());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getGender());
            ps.setDate(7, user.getDate());
            ps.setString(8, user.getCccd());
            ps.setString(9, user.getAddress());
            ps.setString(10, user.getNationality());
            ps.setString(11, user.getStatus());
            ps.setInt(12, user.getUserID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean delete(int id) {

        String sql = "DELETE FROM [User] WHERE UserID=?";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public User getByEmail(String email) {
        String sql = "SELECT * FROM [User] WHERE Email = ? AND Status = 'Active'";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, email.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserID(rs.getInt("UserID"));
                    user.setRoleID(rs.getInt("RoleID"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setPhone(rs.getString("Phone"));
                    user.setPassword(rs.getString("Password")); // cần để so sánh
                    user.setStatus(rs.getString("Status"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Hàm Xác minh Email
    public boolean existsByEmail(String email) {

        String sql = """
        SELECT 1
        FROM [User]
        WHERE Email = ?
        AND Status = 'Active'
        """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, email.trim());

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean insertPendingUser(User user, String otpCode) {
        String sql = """
        INSERT INTO [User]
        (RoleID, FullName, Email, Phone, Password, Gender, Date, CCCD, Address, Nationality, Status, OTPCode, OTPExpiredAt)
        VALUES (?,?,?,?,?,?,?,?,?,?, 'Pending', ?, DATEADD(MINUTE, 5, GETDATE()))
        """;
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, user.getRoleID());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getGender());
            ps.setDate(7, user.getDate());
            ps.setString(8, user.getCccd());
            ps.setString(9, user.getAddress());
            ps.setString(10, user.getNationality());
            ps.setString(11, otpCode);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra OTP còn hạn và đúng, dùng cho bước xác minh
    public boolean verifyOtp(String email, String otpInput) {
        String sql = """
        SELECT 1 FROM [User]
        WHERE Email = ? AND OTPCode = ? AND OTPExpiredAt > GETDATE() AND Status = 'Pending'
        """;
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, email.trim());
            ps.setString(2, otpInput.trim());
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean activateUser(String email) {
        String sql = "UPDATE [User] SET Status = 'Active', OTPCode = NULL, OTPExpiredAt = NULL WHERE Email = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, email.trim());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateOtp(String email, String newOtp) {
        String sql = "UPDATE [User] SET OTPCode = ?, OTPExpiredAt = DATEADD(MINUTE, 5, GETDATE()) WHERE Email = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, newOtp);
            ps.setString(2, email.trim());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}