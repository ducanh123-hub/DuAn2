package com.hotel.service;

import com.hotel.dao.RoomCategoryDAO;
import com.hotel.model.RoomCategory;

import java.util.List;

public class RoomCategoryService {

    private final RoomCategoryDAO roomCategoryDAO = new RoomCategoryDAO();

    public List<RoomCategory> getAll() {
        return roomCategoryDAO.getAll();
    }

    public RoomCategory getById(int id) {
        return roomCategoryDAO.getById(id);
    }

    public boolean insert(RoomCategory category) {
        return roomCategoryDAO.insert(category);
    }

    public boolean update(RoomCategory category) {
        return roomCategoryDAO.update(category);
    }

    public boolean delete(int id) {
        return roomCategoryDAO.delete(id);
    }

}