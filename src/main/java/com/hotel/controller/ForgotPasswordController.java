package com.hotel.controller;

import com.hotel.model.User;
import com.hotel.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        boolean exists = false;

        List<User> users = userService.getAllUsers();
        if (users != null) {
            for (User u : users) {
                if (u.getEmail() != null && u.getEmail().equalsIgnoreCase(email)) {
                    exists = true;
                    break;
                }
            }
        }

        if (exists) {
            request.setAttribute("message", "Một liên kết khôi phục mật khẩu đã được gửi đến email của bạn!");
        } else {
            request.setAttribute("error", "Email không tồn tại trong hệ thống!");
        }
        request.getRequestDispatcher("/views/auth/forgotPassword.jsp").forward(request, response);
    }
}
