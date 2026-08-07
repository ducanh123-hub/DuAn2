package com.hotel.controller;

import com.hotel.model.User;
import com.hotel.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/auth/register.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        User user = new User();

        user.setRoleID(3); // Khách hàng

        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        user.setPassword(request.getParameter("password"));
        user.setStatus("Active");

        boolean check = userService.addUser(user);

        if (check) {

            response.sendRedirect(request.getContextPath() + "/login");

        } else {

            request.setAttribute("error",
                    "Đăng ký thất bại!");

            request.getRequestDispatcher("/views/auth/register.jsp")
                    .forward(request, response);

        }

    }

}
