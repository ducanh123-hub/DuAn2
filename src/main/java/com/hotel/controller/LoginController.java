package com.hotel.controller;

import com.hotel.model.User;
import com.hotel.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/auth/login.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // ── 1. Validate email ──────────────────────────────────────────
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không được để trống.");
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        String emailRegex = "^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$";
        if (!email.trim().matches(emailRegex)) {
            request.setAttribute("error", "Email không đúng định dạng.");
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        // ── 2. Validate password ───────────────────────────────────────
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Mật khẩu không được để trống.");
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự.");
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        // ── 3. Kiểm tra trong database ─────────────────────────────────
        User user = userService.getByEmail(email.trim());

        if (user == null) {
            request.setAttribute("error", "Email không tồn tại trong hệ thống!");
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        if (!userService.checkPassword(password, user.getPassword())) {
            request.setAttribute("error", "Mật khẩu không đúng!");
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
