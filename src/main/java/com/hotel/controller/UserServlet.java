package com.hotel.controller;

import com.hotel.model.User;
import com.hotel.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = userService.getAllUsers();

        request.setAttribute("userList", users);

        request.getRequestDispatcher("/views/admin/user/list.jsp")
                .forward(request, response);
    }
}