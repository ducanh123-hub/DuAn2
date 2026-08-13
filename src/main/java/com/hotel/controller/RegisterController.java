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

        String fullName        = request.getParameter("fullName");
        String email           = request.getParameter("email");
        String phone           = request.getParameter("phone");
        String password        = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // ── 1. Validate email ──────────────────────────────────────────
        String emailRegex = "^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$";
        if (email == null || !email.trim().matches(emailRegex)) {
            request.setAttribute("error", "Email không đúng định dạng.");
            request.setAttribute("fullNameValue", fullName);
            request.setAttribute("emailValue", email);
            request.setAttribute("phoneValue", phone);
            request.getRequestDispatcher("/views/auth/register.jsp")
                    .forward(request, response);
            return;
        }

        // ── 2. Kiểm tra email đã tồn tại chưa ────────────────────────────
        if (userService.existsByEmail(email.trim())) {
            request.setAttribute("error", "Email đã được sử dụng.");
            request.setAttribute("fullNameValue", fullName);
            request.setAttribute("phoneValue", phone);
            request.getRequestDispatcher("/views/auth/register.jsp")
                    .forward(request, response);
            return;
        }

        // ── 3. Validate mật khẩu ─────────────────────────────────────────
        if (password == null || password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự.");
            request.setAttribute("fullNameValue", fullName);
            request.setAttribute("emailValue", email);
            request.setAttribute("phoneValue", phone);
            request.getRequestDispatcher("/views/auth/register.jsp")
                    .forward(request, response);
            return;
        }

        // ── 4. Validate xác nhận mật khẩu ────────────────────────────────
        if (confirmPassword == null || !confirmPassword.equals(password)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            request.setAttribute("fullNameValue", fullName);
            request.setAttribute("emailValue", email);
            request.setAttribute("phoneValue", phone);
            request.getRequestDispatcher("/views/auth/register.jsp")
                    .forward(request, response);
            return;
        }

        // ── 5. Tạo user (trạng thái Pending, chờ xác minh OTP) ───────────
        User user = new User();
        user.setRoleID(3); // Khách hàng
        user.setFullName(fullName);
        user.setEmail(email.trim());
        user.setPhone(phone);
        user.setPassword(password);

        userService.register(user); // insert Status='Pending' + gửi OTP qua email

        // Lưu email vào session để bước /verify-otp biết đang xác minh cho ai
        request.getSession().setAttribute("pendingEmail", email.trim());

        response.sendRedirect(request.getContextPath() + "/verify-otp");

    }

}