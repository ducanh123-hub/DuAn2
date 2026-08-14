package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.SystemLog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO cho bảng System_Log
 * Hỗ trợ ghi nhận và truy xuất nhật ký hệ thống
 */
public class SystemLogDAO {

    // Map ResultSet -> SystemLog
    private SystemLog mapRow(ResultSet rs) throws Exception {
        SystemLog log = new SystemLog();
        log.setLogID(rs.getInt("LogID"));
        int uid = rs.getInt("UserID");
        log.setUserID(rs.wasNull() ? null : uid);
        log.setAction(rs.getString("Action"));
        log.setDescription(rs.getString("Description"));
        log.setIpAddress(rs.getString("IpAddress"));
        log.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return log;
    }

    /**
     * Lấy toàn bộ log, sắp xếp mới nhất trước
     */
    public List<SystemLog> getAll() {
        List<SystemLog> list = new ArrayList<>();
        String sql = "SELECT * FROM System_Log ORDER BY CreatedAt DESC";
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy log theo ID
     */
    public SystemLog getById(int id) {
        String sql = "SELECT * FROM System_Log WHERE LogID = ?";
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Tìm kiếm log theo từ khóa, action và khoảng thời gian
     */
    public List<SystemLog> search(String keyword, String action,
                                   String fromDate, String toDate) {
        List<SystemLog> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT * FROM System_Log WHERE 1=1 "
        );
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (Description LIKE ? OR IpAddress LIKE ?) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }
        if (action != null && !action.trim().isEmpty()) {
            sql.append("AND Action = ? ");
            params.add(action.trim());
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append("AND CAST(CreatedAt AS DATE) >= ? ");
            params.add(fromDate);
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql.append("AND CAST(CreatedAt AS DATE) <= ? ");
            params.add(toDate);
        }
        sql.append("ORDER BY CreatedAt DESC");

        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql.toString())
        ) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Ghi nhận log
     */
    public boolean insert(SystemLog log) {
        String sql = """
            INSERT INTO System_Log (UserID, Action, Description, IpAddress)
            VALUES (?, ?, ?, ?)
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            if (log.getUserID() != null) {
                ps.setInt(1, log.getUserID());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setString(2, log.getAction());
            ps.setString(3, log.getDescription());
            ps.setString(4, log.getIpAddress());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lấy danh sách action riêng biệt (dùng cho dropdown lọc)
     */
    public List<String> getDistinctActions() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT Action FROM System_Log ORDER BY Action";
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                list.add(rs.getString("Action"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy log theo UserID
     */
    public List<SystemLog> getByUserId(int userId) {
        List<SystemLog> list = new ArrayList<>();
        String sql = "SELECT * FROM System_Log WHERE UserID = ? ORDER BY CreatedAt DESC";
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
