package com.hotel.service;

import com.hotel.dao.RoomDAO;
import com.hotel.dao.RoomFavoriteDAO;
import com.hotel.dao.UserDAO;
import com.hotel.model.Room;
import com.hotel.model.User;

import java.util.Collections;
import java.util.List;
import java.util.Set;

public class RoomFavoriteService {

    private final RoomFavoriteDAO favoriteDAO = new RoomFavoriteDAO();
    private final RoomDAO roomDAO = new RoomDAO();
    private final UserDAO userDAO = new UserDAO();

    public boolean addFavorite(int userId, int roomId) {
        if (userId <= 0 || roomId <= 0) {
            return false;
        }

        User user = userDAO.getById(userId);
        if (user == null) {
            return false;
        }

        Room room = roomDAO.getById(roomId);
        if (room == null) {
            return false;
        }

        if (favoriteDAO.isFavorite(userId, roomId)) {
            return true; // Đã yêu thích rồi (tránh thêm trùng)
        }

        return favoriteDAO.addFavorite(userId, roomId);
    }

    public boolean removeFavorite(int userId, int roomId) {
        if (userId <= 0 || roomId <= 0) {
            return false;
        }
        return favoriteDAO.removeFavorite(userId, roomId);
    }

    public boolean isFavorite(int userId, int roomId) {
        if (userId <= 0 || roomId <= 0) {
            return false;
        }
        return favoriteDAO.isFavorite(userId, roomId);
    }

    public List<Room> getFavoriteRoomsByUser(int userId) {
        if (userId <= 0) {
            return Collections.emptyList();
        }
        return favoriteDAO.getFavoriteRoomsByUserId(userId);
    }

    public Set<Integer> getFavoriteRoomIdsByUser(int userId) {
        if (userId <= 0) {
            return Collections.emptySet();
        }
        return favoriteDAO.getFavoriteRoomIdsByUserId(userId);
    }

    public int getFavoriteCountByRoomId(int roomId) {
        if (roomId <= 0) {
            return 0;
        }
        return favoriteDAO.getFavoriteCountByRoomId(roomId);
    }

    public java.util.Map<Integer, Integer> getAllFavoriteCounts() {
        return favoriteDAO.getAllFavoriteCounts();
    }

    public void populateFavoriteCounts(List<Room> rooms) {
        if (rooms == null || rooms.isEmpty()) {
            return;
        }
        java.util.Map<Integer, Integer> countMap = favoriteDAO.getAllFavoriteCounts();
        for (Room room : rooms) {
            if (room != null) {
                int count = countMap.getOrDefault(room.getRoomID(), 0);
                room.setFavoriteCount(count);
            }
        }
    }
}
