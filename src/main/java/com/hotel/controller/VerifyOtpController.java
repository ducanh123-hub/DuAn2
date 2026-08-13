package com.hotel.controller;

import com.hotel.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/verify-otp")
public class VerifyOtpController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("pendingEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }
        request.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = (String) request.getSession().getAttribute("pendingEmail");
        String otpInput = request.getParameter("otp");

        if (email == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        if (userService.verifyOtp(email, otpInput)) {
            request.getSession().removeAttribute("pendingEmail");
            request.setAttribute("success", "Xác minh thành công! Bạn có thể đăng nhập.");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Mã OTP không đúng hoặc đã hết hạn.");
            request.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(request, response);
        }
    }
}
