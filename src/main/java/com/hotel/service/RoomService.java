package com.hotel.service;

import com.hotel.dao.RoomDAO;
import com.hotel.model.Room;

import java.util.List;

public class RoomService {

    private final RoomDAO roomDAO = new RoomDAO();

    public List<Room> getAllRooms() {
        return roomDAO.getAll();
    }

    public Room getRoomById(int id) {
        return roomDAO.getById(id);
    }

    public boolean addRoom(Room room) {
        return roomDAO.insert(room);
    }

    public boolean updateRoom(Room room) {
        return roomDAO.update(room);
    }

    public boolean deleteRoom(int id) {
        return roomDAO.delete(id);
    }

    public List<Room> searchRoom(String keyword) {
        return roomDAO.searchByName(keyword);
    }
}