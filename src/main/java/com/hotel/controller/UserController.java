package com.hotel.controller;

import com.hotel.model.User;
import com.hotel.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        switch (action) {
            case "profile":
                if (currentUser == null) {
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                }
                request.setAttribute("profileUser", currentUser);
                request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
                break;

            case "change-password":
                if (currentUser == null) {
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                }
                request.getRequestDispatcher("/views/customer/changePassword.jsp").forward(request, response);
                break;

            case "dashboard":
                if (currentUser == null || currentUser.getRoleID() != 1) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
                    return;
                }
                com.hotel.service.RoomService roomService = new com.hotel.service.RoomService();
                com.hotel.service.BookingService bookingService = new com.hotel.service.BookingService();

                request.setAttribute("totalRooms", roomService.getAllRooms().size());
                request.setAttribute("totalBookings", bookingService.getAllBookings().size());
                request.setAttribute("totalUsers", userService.getAllUsers().size());

                java.math.BigDecimal totalRevenue = java.math.BigDecimal.ZERO;
                for (com.hotel.model.Booking b : bookingService.getAllBookings()) {
                    if ("Đã trả phòng".equals(b.getStatus())) {
                        totalRevenue = totalRevenue.add(b.getFinalAmount());
                    }
                }
                request.setAttribute("totalRevenue", totalRevenue);

                request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
                break;
            case "list":
            default:
                if (currentUser == null || currentUser.getRoleID() != 1) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
                    return;
                }
                List<User> users = userService.getAllUsers();
                request.setAttribute("userList", users);
                request.getRequestDispatcher("/views/admin/user/list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("updateProfile".equals(action)) {
            currentUser.setFullName(request.getParameter("fullName"));
            currentUser.setPhone(request.getParameter("phone"));
            currentUser.setGender(request.getParameter("gender"));
            String dobStr = request.getParameter("date");
            if (dobStr != null && !dobStr.isEmpty()) {
                currentUser.setDate(java.sql.Date.valueOf(dobStr));
            }
            currentUser.setCccd(request.getParameter("cccd"));
            currentUser.setAddress(request.getParameter("address"));
            currentUser.setNationality(request.getParameter("nationality"));

            boolean success = userService.updateUser(currentUser);
            if (success) {
                session.setAttribute("user", currentUser);
                request.setAttribute("message", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("error", "Cập nhật thông tin thất bại!");
            }
            request.setAttribute("profileUser", currentUser);
            request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);

        } else if ("updatePassword".equals(action)) {
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!currentUser.getPassword().equals(oldPassword)) {
                request.setAttribute("error", "Mật khẩu cũ không chính xác!");
            } else if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu mới xác nhận không khớp!");
            } else if (newPassword.length() < 6) {
                request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            } else {
                currentUser.setPassword(newPassword);
                boolean success = userService.updateUser(currentUser);
                if (success) {
                    session.setAttribute("user", currentUser);
                    request.setAttribute("message", "Đổi mật khẩu thành công!");
                } else {
                    request.setAttribute("error", "Đổi mật khẩu thất bại!");
                }
            }
            request.getRequestDispatcher("/views/customer/changePassword.jsp").forward(request, response);
        }
    }
}
