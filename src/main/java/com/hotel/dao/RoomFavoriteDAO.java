package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Room;
import com.hotel.model.RoomFavorite;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class RoomFavoriteDAO implements BaseDAO<RoomFavorite> {

    @Override
    public List<RoomFavorite> getAll() {
        List<RoomFavorite> list = new ArrayList<>();
        String sql = "SELECT FavoriteID, UserID, RoomID, CreatedAt FROM Room_Favorite ORDER BY FavoriteID DESC";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RoomFavorite rf = new RoomFavorite(
                        rs.getInt("FavoriteID"),
                        rs.getInt("UserID"),
                        rs.getInt("RoomID"),
                        rs.getTimestamp("CreatedAt")
                );
                list.add(rf);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public RoomFavorite getById(int id) {
        String sql = "SELECT FavoriteID, UserID, RoomID, CreatedAt FROM Room_Favorite WHERE FavoriteID = ?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new RoomFavorite(
                            rs.getInt("FavoriteID"),
                            rs.getInt("UserID"),
                            rs.getInt("RoomID"),
                            rs.getTimestamp("CreatedAt")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(RoomFavorite obj) {
        if (obj == null) return false;
        return addFavorite(obj.getUserID(), obj.getRoomID());
    }

    public boolean addFavorite(int userId, int roomId) {
        if (isFavorite(userId, roomId)) {
            return false; // Đã yêu thích rồi
        }
        String sql = "INSERT INTO Room_Favorite(UserID, RoomID, CreatedAt) VALUES (?, ?, GETDATE())";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, roomId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(RoomFavorite obj) {
        return false; // Không hỗ trợ update bảng favorite
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Room_Favorite WHERE FavoriteID = ?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeFavorite(int userId, int roomId) {
        String sql = "DELETE FROM Room_Favorite WHERE UserID = ? AND RoomID = ?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, roomId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isFavorite(int userId, int roomId) {
        String sql = "SELECT COUNT(1) FROM Room_Favorite WHERE UserID = ? AND RoomID = ?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Set<Integer> getFavoriteRoomIdsByUserId(int userId) {
        Set<Integer> set = new HashSet<>();
        String sql = "SELECT RoomID FROM Room_Favorite WHERE UserID = ?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    set.add(rs.getInt("RoomID"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return set;
    }

    public List<Room> getFavoriteRoomsByUserId(int userId) {
        List<Room> list = new ArrayList<>();
        String sql = """
                SELECT r.RoomID, r.CategoryID, r.RoomNumber, r.RoomName, r.Price,
                       r.Acreage, r.Bed, r.Area, r.Description, r.Status, r.CreatedAt, r.UpdatedAt
                FROM Room r
                INNER JOIN Room_Favorite rf ON r.RoomID = rf.RoomID
                WHERE rf.UserID = ?
                ORDER BY rf.CreatedAt DESC
                """;

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Room room = new Room(
                            rs.getInt("RoomID"),
                            rs.getInt("CategoryID"),
                            rs.getString("RoomNumber"),
                            rs.getString("RoomName"),
                            rs.getBigDecimal("Price"),
                            rs.getBigDecimal("Acreage"),
                            rs.getInt("Bed"),
                            rs.getString("Area"),
                            rs.getString("Description"),
                            rs.getString("Status"),
                            rs.getTimestamp("CreatedAt"),
                            rs.getTimestamp("UpdatedAt")
                    );
                    list.add(room);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getFavoriteCountByRoomId(int roomId) {
        String sql = "SELECT COUNT(*) FROM Room_Favorite WHERE RoomID = ?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Map<Integer, Integer> getAllFavoriteCounts() {
        Map<Integer, Integer> map = new HashMap<>();
        String sql = "SELECT RoomID, COUNT(FavoriteID) AS FavoriteCount FROM Room_Favorite GROUP BY RoomID";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                map.put(rs.getInt("RoomID"), rs.getInt("FavoriteCount"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}
