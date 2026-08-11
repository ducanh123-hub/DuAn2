package com.hotel.service;

import com.hotel.dao.RoomDAO;
import com.hotel.model.Room;

import java.math.BigDecimal;
import java.util.List;

public class RoomService {

    private final RoomDAO roomDAO = new RoomDAO();


    // =====================================================
    // GET ALL
    // =====================================================

    public List<Room> getAllRooms() {

        return roomDAO.getAll();

    }


    // =====================================================
    // GET BY ID
    // =====================================================

    public Room getRoomById(int id) {

        return roomDAO.getById(id);

    }


    // =====================================================
    // ADD
    // =====================================================

    public boolean addRoom(Room room) {

        return roomDAO.insert(room);

    }


    // =====================================================
    // UPDATE
    // =====================================================

    public boolean updateRoom(Room room) {

        return roomDAO.update(room);

    }


    // =====================================================
    // DELETE
    // =====================================================

    public boolean deleteRoom(int id) {

        return roomDAO.delete(id);

    }


    // =====================================================
    // SEARCH CŨ
    // =====================================================

    public List<Room> searchRoom(String keyword) {

        return roomDAO.searchByName(keyword);

    }


    // =====================================================
    // SEARCH + FILTER
    // =====================================================

    public List<Room> searchRooms(
            String keyword,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            Integer people,
            String sortPrice
    ) {

        return roomDAO.searchRooms(
                keyword,
                minPrice,
                maxPrice,
                people,
                sortPrice
        );
    }


    // =====================================================
    // GET BY CATEGORY
    // =====================================================

    public List<Room> getRoomsByCategory(int categoryID) {

        return roomDAO.getByCategory(categoryID);

    }


    // =====================================================
    // AVAILABLE ROOMS
    // =====================================================

    public List<Room> getAvailableRooms() {

        return roomDAO.getAvailableRooms();

    }


    // =====================================================
    // COUNT
    // =====================================================

    public int countRoom() {

        return roomDAO.countRoom();

    }


    // =====================================================
    // FIND ROOM NUMBER
    // =====================================================

    public Room findByRoomNumber(String roomNumber) {

        return roomDAO.findByRoomNumber(roomNumber);

    }
}