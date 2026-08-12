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

        if (room == null) {
            return false;
        }

        return roomDAO.insert(room);
    }

    // =====================================================
    // UPDATE
    // =====================================================

    public boolean updateRoom(Room room) {

        if (room == null || room.getRoomID() <= 0) {
            return false;
        }

        return roomDAO.update(room);
    }

    // =====================================================
    // DELETE
    // =====================================================

    public boolean deleteRoom(int id) {

        if (id <= 0) {
            return false;
        }

        return roomDAO.delete(id);
    }

    // =====================================================
    // SEARCH CŨ
    // =====================================================

    public List<Room> searchRoom(String keyword) {

        if (keyword == null) {
            keyword = "";
        }

        return roomDAO.searchByName(
                keyword.trim()
        );
    }

    // =====================================================
    // SEARCH + FILTER + PAGINATION
    // =====================================================

    public List<Room> searchRooms(
            String keyword,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            Integer people,
            String sortPrice,
            int page,
            int pageSize
    ) {

        if (keyword != null) {
            keyword = keyword.trim();
        }

        if (keyword != null && keyword.isEmpty()) {
            keyword = null;
        }

        if (people != null && people <= 0) {
            people = null;
        }

        if (minPrice != null
                && minPrice.compareTo(BigDecimal.ZERO) < 0) {

            minPrice = BigDecimal.ZERO;
        }

        if (maxPrice != null
                && maxPrice.compareTo(BigDecimal.ZERO) < 0) {

            maxPrice = null;
        }

        if (minPrice != null
                && maxPrice != null
                && minPrice.compareTo(maxPrice) > 0) {

            BigDecimal temp = minPrice;
            minPrice = maxPrice;
            maxPrice = temp;
        }

        if (sortPrice == null) {
            sortPrice = "";
        }

        if (!sortPrice.equalsIgnoreCase("asc")
                && !sortPrice.equalsIgnoreCase("desc")) {

            sortPrice = "";
        }

        if (page < 1) {
            page = 1;
        }

        if (pageSize <= 0) {
            pageSize = 6;
        }

        return roomDAO.searchRooms(
                keyword,
                minPrice,
                maxPrice,
                people,
                sortPrice,
                page,
                pageSize
        );
    }

    // =====================================================
    // COUNT SEARCH + FILTER
    // =====================================================

    public int countSearchRooms(
            String keyword,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            Integer people
    ) {

        if (keyword != null) {
            keyword = keyword.trim();
        }

        if (keyword != null && keyword.isEmpty()) {
            keyword = null;
        }

        if (people != null && people <= 0) {
            people = null;
        }

        if (minPrice != null
                && minPrice.compareTo(BigDecimal.ZERO) < 0) {

            minPrice = BigDecimal.ZERO;
        }

        if (maxPrice != null
                && maxPrice.compareTo(BigDecimal.ZERO) < 0) {

            maxPrice = null;
        }

        if (minPrice != null
                && maxPrice != null
                && minPrice.compareTo(maxPrice) > 0) {

            BigDecimal temp = minPrice;
            minPrice = maxPrice;
            maxPrice = temp;
        }

        return roomDAO.countSearchRooms(
                keyword,
                minPrice,
                maxPrice,
                people
        );
    }

    // =====================================================
    // GET BY CATEGORY
    // =====================================================

    public List<Room> getRoomsByCategory(
            int categoryID
    ) {

        if (categoryID <= 0) {
            return List.of();
        }

        return roomDAO.getByCategory(
                categoryID
        );
    }

    // =====================================================
    // GET AVAILABLE
    // =====================================================

    public List<Room> getAvailableRooms() {
        return roomDAO.getAvailableRooms();
    }

    // =====================================================
    // GET AVAILABLE - PAGINATION
    // =====================================================

    public List<Room> getAvailableRooms(
            int page,
            int pageSize
    ) {

        if (page < 1) {
            page = 1;
        }

        if (pageSize <= 0) {
            pageSize = 6;
        }

        return roomDAO.getAvailableRooms(
                page,
                pageSize
        );
    }

    // =====================================================
    // COUNT ALL
    // =====================================================

    public int countRoom() {
        return roomDAO.countRoom();
    }

    // =====================================================
    // COUNT AVAILABLE
    // =====================================================

    public int countAvailableRooms() {
        return roomDAO.countAvailableRooms();
    }

    // =====================================================
    // FIND ROOM NUMBER
    // =====================================================

    public Room findByRoomNumber(
            String roomNumber
    ) {

        if (roomNumber == null
                || roomNumber.trim().isEmpty()) {

            return null;
        }

        return roomDAO.findByRoomNumber(
                roomNumber.trim()
        );
    }
}