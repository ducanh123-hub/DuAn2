package com.hotel.controller;

import com.hotel.model.User;
import com.hotel.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/user")
public class UserController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) action = "list";

        HttpSession session = req.getSession(false);
        User currentUser = session != null ? (User) session.getAttribute("user") : null;

        switch (action) {
            case "profile" -> {
                if (currentUser == null) { res.sendRedirect(req.getContextPath() + "/login"); return; }
                req.setAttribute("profileUser", currentUser);
                req.getRequestDispatcher("/views/customer/profile.jsp").forward(req, res);
            }
            case "change-password" -> {
                if (currentUser == null) { res.sendRedirect(req.getContextPath() + "/login"); return; }
                req.getRequestDispatcher("/views/customer/changePassword.jsp").forward(req, res);
            }
            case "dashboard" -> {
                if (!isManager(currentUser)) { res.sendError(403, "Bạn không có quyền truy cập!"); return; }
                var roomService    = new com.hotel.service.RoomService();
                var bookingService = new com.hotel.service.BookingService();
                req.setAttribute("totalRooms",    roomService.getAllRooms().size());
                req.setAttribute("totalBookings", bookingService.getAllBookings().size());
                req.setAttribute("totalUsers",    userService.getAllUsers().size());
                BigDecimal rev = BigDecimal.ZERO;
                for (var b : bookingService.getAllBookings())
                    if ("Đã trả phòng".equals(b.getStatus()) && b.getFinalAmount() != null)
                        rev = rev.add(b.getFinalAmount());
                req.setAttribute("totalRevenue", rev);
                req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, res);
            }
            case "list", "admin-list" -> {
                if (!isManager(currentUser)) { res.sendError(403, "Bạn không có quyền truy cập!"); return; }
                String keyword = req.getParameter("keyword");
                List<User> users = (keyword != null && !keyword.trim().isEmpty())
                        ? userService.search(keyword) : userService.getAllUsers();
                req.setAttribute("userList", users);
                // Hiển thị message / error từ redirect param
                if (req.getParameter("message") != null)
                    req.setAttribute("message", req.getParameter("message"));
                if (req.getParameter("error") != null)
                    req.setAttribute("error", req.getParameter("error"));
                req.getRequestDispatcher("/views/admin/user/list.jsp").forward(req, res);
            }
            case "edit" -> {
                if (!isManager(currentUser)) { res.sendError(403, "Bạn không có quyền truy cập!"); return; }
                int id = parseId(req.getParameter("id"));
                if (id <= 0) { res.sendRedirect(req.getContextPath() + "/user?action=list"); return; }
                User editUser = userService.getUserById(id);
                if (editUser == null) { res.sendError(404, "Không tìm thấy người dùng!"); return; }
                req.setAttribute("editUser", editUser);
                req.getRequestDispatcher("/views/admin/user/form.jsp").forward(req, res);
            }
            default -> res.sendRedirect(req.getContextPath() + "/user?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);
        User currentUser = session != null ? (User) session.getAttribute("user") : null;

        if (currentUser == null) { res.sendRedirect(req.getContextPath() + "/login"); return; }

        if ("updateProfile".equals(action))  { updateProfile(req, res, currentUser, session); return; }
        if ("updatePassword".equals(action)) { updatePassword(req, res, currentUser, session); return; }

        if (!isManager(currentUser)) { res.sendError(403, "Bạn không có quyền!"); return; }

        switch (action) {
            case "createUser" -> createUser(req, res);
            case "updateUser" -> updateUser(req, res);
            case "lockUser"   -> toggleLock(req, res, false);
            case "unlockUser" -> toggleLock(req, res, true);
            case "resetPassword" -> resetPassword(req, res);
            default -> res.sendRedirect(req.getContextPath() + "/user?action=list");
        }
    }

    // ── Profile ──────────────────────────────────────────────────────────────
    private void updateProfile(HttpServletRequest req, HttpServletResponse res,
                               User cur, HttpSession session) throws ServletException, IOException {
        cur.setFullName(req.getParameter("fullName"));
        cur.setPhone(req.getParameter("phone"));
        cur.setGender(req.getParameter("gender"));
        cur.setCccd(req.getParameter("cccd"));
        cur.setAddress(req.getParameter("address"));
        cur.setNationality(req.getParameter("nationality"));
        String dob = req.getParameter("date");
        if (dob != null && !dob.isEmpty()) cur.setDate(java.sql.Date.valueOf(dob));

        if (userService.updateUser(cur)) {
            session.setAttribute("user", cur);
            req.setAttribute("message", "Cập nhật thông tin thành công!");
        } else {
            req.setAttribute("error", "Cập nhật thông tin thất bại!");
        }
        req.setAttribute("profileUser", cur);
        req.getRequestDispatcher("/views/customer/profile.jsp").forward(req, res);
    }

    private void updatePassword(HttpServletRequest req, HttpServletResponse res,
                                User cur, HttpSession session) throws ServletException, IOException {
        String oldPw  = req.getParameter("oldPassword");
        String newPw  = req.getParameter("newPassword");
        String confPw = req.getParameter("confirmPassword");

        if (!cur.getPassword().equals(oldPw)) {
            req.setAttribute("error", "Mật khẩu cũ không chính xác!");
        } else if (!newPw.equals(confPw)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
        } else if (newPw.length() < 6) {
            req.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
        } else {
            cur.setPassword(newPw);
            if (userService.updateUser(cur)) {
                session.setAttribute("user", cur);
                req.setAttribute("message", "Đổi mật khẩu thành công!");
            } else {
                req.setAttribute("error", "Đổi mật khẩu thất bại!");
            }
        }
        req.getRequestDispatcher("/views/customer/changePassword.jsp").forward(req, res);
    }

    // ── Admin CRUD ────────────────────────────────────────────────────────────
    private void createUser(HttpServletRequest req, HttpServletResponse res) throws IOException {
        User user = buildUser(req);
        String err = userService.createUser(user);
        if (err == null) {
            redirect(req, res, "message", "Thêm người dùng thành công!");
        } else {
            redirect(req, res, "error", err);
        }
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse res) throws IOException {
        int id = parseId(req.getParameter("userID"));
        if (id <= 0) { res.sendRedirect(req.getContextPath() + "/user?action=list"); return; }

        User user = userService.getUserById(id);
        if (user == null) { redirect(req, res, "error", "Không tìm thấy người dùng!"); return; }

        user.setFullName(req.getParameter("fullName"));
        user.setPhone(req.getParameter("phone"));
        user.setGender(req.getParameter("gender"));
        user.setCccd(req.getParameter("cccd"));
        user.setAddress(req.getParameter("address"));
        user.setNationality(req.getParameter("nationality"));

        String date = req.getParameter("date");
        if (date != null && !date.isEmpty()) user.setDate(java.sql.Date.valueOf(date));

        String roleId = req.getParameter("roleID");
        if (roleId != null && !roleId.isEmpty()) user.setRoleID(Integer.parseInt(roleId));

        String status = req.getParameter("status");
        if (status != null && !status.isEmpty()) user.setStatus(status);

        boolean ok = userService.updateUser(user);
        redirect(req, res, ok ? "message" : "error", ok ? "Cập nhật thành công!" : "Cập nhật thất bại!");
    }

    private void toggleLock(HttpServletRequest req, HttpServletResponse res, boolean unlock)
            throws IOException {
        int id = parseId(req.getParameter("userId"));
        boolean ok = unlock ? userService.unlockUser(id) : userService.lockUser(id);
        redirect(req, res,
                ok ? "message" : "error",
                ok ? (unlock ? "Mở khóa thành công!" : "Khóa tài khoản thành công!")
                        : (unlock ? "Mở khóa thất bại!"  : "Khóa tài khoản thất bại!"));
    }

    private void resetPassword(HttpServletRequest req, HttpServletResponse res) throws IOException {
        int id = parseId(req.getParameter("userId"));
        String newPw = req.getParameter("newPassword");
        if (newPw == null || newPw.trim().isEmpty()) newPw = "123456";
        boolean ok = userService.resetPassword(id, newPw);
        redirect(req, res,
                ok ? "message" : "error",
                ok ? "Đặt lại mật khẩu thành công!" : "Đặt lại mật khẩu thất bại!");
    }

    // ── Helpers ───────────────────────────────────────────────────────────────
    private User buildUser(HttpServletRequest req) {
        User u = new User();
        String roleId = req.getParameter("roleID");
        u.setRoleID(roleId == null || roleId.isEmpty() ? 3 : Integer.parseInt(roleId));
        u.setFullName(req.getParameter("fullName"));
        u.setEmail(req.getParameter("email"));
        u.setPhone(req.getParameter("phone"));
        u.setPassword(req.getParameter("password"));
        u.setGender(req.getParameter("gender"));
        u.setCccd(req.getParameter("cccd"));
        u.setAddress(req.getParameter("address"));
        u.setNationality(req.getParameter("nationality"));
        u.setStatus("Active");
        String date = req.getParameter("date");
        if (date != null && !date.isEmpty()) u.setDate(java.sql.Date.valueOf(date));
        return u;
    }

    private void redirect(HttpServletRequest req, HttpServletResponse res,
                          String paramKey, String msg) throws IOException {
        res.sendRedirect(req.getContextPath() + "/user?action=list&"
                + paramKey + "=" + java.net.URLEncoder.encode(msg, "UTF-8"));
    }

    private boolean isManager(User user) { return user != null && user.getRoleID() == 1; }

    private int parseId(String val) {
        try { return Integer.parseInt(val); } catch (Exception e) { return -1; }
    }
}