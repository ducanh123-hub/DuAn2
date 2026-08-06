package com.hotel.test;

import com.hotel.dao.RoomCategoryDAO;
import com.hotel.model.RoomCategory;

public class TestRoomCategoryDAO {

    public static void main(String[] args) {

        RoomCategoryDAO dao = new RoomCategoryDAO();

        for (RoomCategory category : dao.getAll()) {
            System.out.println(category);
        }

    }

}