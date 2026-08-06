package com.hotel.test;

import com.hotel.dao.UserDAO;
import com.hotel.model.User;

public class TestUserDAO {

    public static void main(String[] args) {

        UserDAO dao = new UserDAO();

        for (User u : dao.getAll()) {

            System.out.println(u);

        }

    }

}