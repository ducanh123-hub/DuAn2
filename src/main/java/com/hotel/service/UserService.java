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

    public List<User> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return userDAO.getAll();
        }
        return userDAO.search(keyword);
    }

    public boolean lockUser(int userId) {
        return userDAO.updateStatus(userId, "Locked");
    }

    public boolean unlockUser(int userId) {
        return userDAO.updateStatus(userId, "Active");
    }

    public boolean resetPassword(int userId, String newPassword) {
        if (newPassword == null || newPassword.length() < 6) {
            return false;
        }
        return userDAO.resetPassword(userId, newPassword);
    }

    public boolean changeRole(int userId, int newRoleId) {
        if (newRoleId < 1 || newRoleId > 3) {
            return false;
        }
        return userDAO.updateRole(userId, newRoleId);
    }

    public List<User> getUsersByRole(int roleId) {
        return userDAO.getByRole(roleId);
    }

    public String createUser(User user) {

        if (user.getFullName() == null ||
                user.getFullName().trim().isEmpty()) {
            return "Họ tên không được để trống!";
        }

        if (user.getEmail() == null ||
                user.getEmail().trim().isEmpty()) {
            return "Email không được để trống!";
        }

        if (userDAO.existsByEmail(user.getEmail().trim())) {
            return "Email đã tồn tại!";
        }

        if (user.getPassword() == null ||
                user.getPassword().length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự!";
        }

        if (user.getRoleID() < 1 || user.getRoleID() > 3) {
            return "Vai trò không hợp lệ!";
        }

        user.setStatus("Active");

        return userDAO.insert(user)
                ? null
                : "Thêm người dùng thất bại!";
    }
}