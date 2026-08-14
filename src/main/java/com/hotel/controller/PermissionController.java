package com.hotel.controller;

import com.hotel.dao.RoleDAO;
import com.hotel.model.Permission;
import com.hotel.model.Role;
import com.hotel.model.User;
import com.hotel.service.SystemLogService;
import com.hotel.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * Controller phân quyền.
 * URL: /admin/permission — chỉ QUAN_LY.
 * Quản lý vai trò và phân công vai trò cho người dùng.
 */
@WebServlet("/admin/permission")
public class PermissionController extends HttpServlet {

    private final UserService userService = new UserService();
    private final RoleDAO roleDAO = new RoleDAO();
    private final SystemLogService logService = new SystemLogService();

    private boolean checkRole(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        User user = (User) session.getAttribute("user");
        if (user.getRoleID() != 1) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Không có quyền!");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        if (!checkRole(request, response)) return;

        // Danh sách vai trò và người dùng
        List<Role> roles = roleDAO.getAll();
        List<User> users = userService.getAllUsers();

        request.setAttribute("roles", roles);
        request.setAttribute("users", users);

        // Flash messages
        HttpSession session = request.getSession(false);
        if (session != null) {
            request.setAttribute("successMsg", session.getAttribute("successMsg"));
            request.setAttribute("errorMsg", session.getAttribute("errorMsg"));
            session.removeAttribute("successMsg");
            session.removeAttribute("errorMsg");
        }

        request.getRequestDispatcher("/views/admin/permission/list.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        if (!checkRole(request, response)) return;

        String action = request.getParameter("action");

        if ("assign-role".equals(action)) {
            // Gán vai trò cho người dùng
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                int newRole = Integer.parseInt(request.getParameter("roleId"));

                // Không cho phép tự đổi quyền của chính mình
                User self = (User) request.getSession().getAttribute("user");
                if (self.getUserID() == userId) {
                    request.getSession().setAttribute("errorMsg",
                            "Không thể thay đổi vai trò của chính mình!");
                    response.sendRedirect(request.getContextPath() + "/admin/permission");
                    return;
                }

                boolean ok = userService.changeRole(userId, newRole);
                if (ok) {
                    logService.logFromRequest(request, "UPDATE",
                            "Thay đổi quyền UserID=" + userId + " -> RoleID=" + newRole);
                    request.getSession().setAttribute("successMsg",
                            "Thay đổi vai trò thành công!");
                } else {
                    request.getSession().setAttribute("errorMsg",
                            "Thay đổi vai trò thất bại!");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMsg", "Dữ liệu không hợp lệ!");
            }

        } else if ("lock".equals(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean ok = userService.lockUser(userId);
                request.getSession().setAttribute(
                        ok ? "successMsg" : "errorMsg",
                        ok ? "Khóa tài khoản thành công!" : "Khóa tài khoản thất bại!");
                if (ok) logService.logFromRequest(request, "UPDATE", "Khóa tài khoản UserID=" + userId);
            } catch (NumberFormatException ignore) {}

        } else if ("unlock".equals(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean ok = userService.unlockUser(userId);
                request.getSession().setAttribute(
                        ok ? "successMsg" : "errorMsg",
                        ok ? "Mở khóa tài khoản thành công!" : "Mở khóa tài khoản thất bại!");
                if (ok) logService.logFromRequest(request, "UPDATE", "Mở khóa tài khoản UserID=" + userId);
            } catch (NumberFormatException ignore) {}
        }

        response.sendRedirect(request.getContextPath() + "/admin/permission");
    }
}
