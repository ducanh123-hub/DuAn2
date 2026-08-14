package com.hotel.controller;

import com.hotel.model.User;
import com.hotel.service.BookingService;
import com.hotel.service.ReportService;
import com.hotel.service.RoomService;
import com.hotel.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Controller xử lý Dashboard của Quản lý.
 * URL: /admin
 * Yêu cầu đăng nhập và có RoleID = 1 (QUAN_LY).
 */
@WebServlet("/admin")
public class AdminController extends HttpServlet {

    private final RoomService roomService = new RoomService();
    private final BookingService bookingService = new BookingService();
    private final UserService userService = new UserService();
    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // ── 1. Kiểm tra đăng nhập ──────────────────────────────────
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ── 2. Kiểm tra quyền QUAN_LY (RoleID = 1) ─────────────────
        User user = (User) session.getAttribute("user");
        if (user.getRoleID() != 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Bạn không có quyền truy cập trang quản lý!");
            return;
        }

        // ── 3. Tổng hợp số liệu Dashboard ──────────────────────────
        try {
            int totalRooms = roomService.getAllRooms().size();
            int totalBookings = bookingService.getAllBookings().size();
            int totalUsers = userService.getAllUsers().size();
            int newCustomersThisMonth = reportService.getNewCustomersThisMonth();
            int completedBookings = reportService.getTotalCompletedBookings();
            java.math.BigDecimal totalRevenue = reportService.getTotalRevenue();

            // Tỷ lệ lấp đầy phòng
            java.util.Map<String, Integer> roomOccupancy = reportService.getRoomOccupancy();

            request.setAttribute("totalRooms", totalRooms);
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("newCustomersThisMonth", newCustomersThisMonth);
            request.setAttribute("completedBookings", completedBookings);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("roomOccupancy", roomOccupancy);

        } catch (Exception e) {
            e.printStackTrace();
            // Đặt giá trị mặc định nếu có lỗi
            request.setAttribute("totalRooms", 0);
            request.setAttribute("totalBookings", 0);
            request.setAttribute("totalUsers", 0);
            request.setAttribute("totalRevenue", java.math.BigDecimal.ZERO);
        }

        // ── 4. Forward sang JSP ─────────────────────────────────────
        request.getRequestDispatcher("/views/admin/dashboard.jsp")
               .forward(request, response);
    }
}
