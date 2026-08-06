package com.hotel.controller;

import com.hotel.dao.UserDAO;
import com.hotel.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/login.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.login(email, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("user", user);

            response.sendRedirect(request.getContextPath() + "/home");

        } else {

            request.setAttribute("error",
                    "Email hoặc mật khẩu không đúng.");

            request.getRequestDispatcher("/views/login.jsp")
                    .forward(request, response);

        }

    }
}