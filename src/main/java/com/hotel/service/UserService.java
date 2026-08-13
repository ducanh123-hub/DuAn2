package com.hotel.service;

import com.hotel.dao.UserDAO;
import com.hotel.model.User;
import com.hotel.util.MailUtil;

import java.util.List;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    public User getByEmail(String email) {
        return userDAO.getByEmail(email);
    }

    public boolean checkPassword(String rawPassword, String passwordFromDb) {
        return rawPassword.equals(passwordFromDb);
    }

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


    public boolean existsByEmail(String email) {
        return userDAO.existsByEmail(email);
    }

    public void register(User user) {
        String otp = MailUtil.generateOtp();
        userDAO.insertPendingUser(user, otp);
        MailUtil.sendOtpEmail(user.getEmail(), otp);
    }

    public void resendOtp(String email) {
        String otp = MailUtil.generateOtp();
        userDAO.updateOtp(email, otp);
        MailUtil.sendOtpEmail(email, otp);
    }

    public boolean verifyOtp(String email, String otpInput) {
        if (userDAO.verifyOtp(email, otpInput)) {
            return userDAO.activateUser(email);
        }
        return false;
    }

}