package com.hotel.service;

import com.hotel.dao.UserDAO;
import com.hotel.model.User;

import java.util.List;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    public List<User> getAllUsers() {
        return userDAO.getAll();
    }

    public User getUserById(int id) {
        return userDAO.getById(id);
    }

    public boolean addUser(User user) {
        return userDAO.insert(user);
    }

    public boolean updateUser(User user) {
        return userDAO.update(user);
    }

    public boolean deleteUser(int id) {
        return userDAO.delete(id);
    }

    public User login(String email, String password) {
        return userDAO.login(email, password);
    }

}