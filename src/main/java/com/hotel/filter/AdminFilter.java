package com.hotel.filter;

import com.hotel.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Set;

public class AdminFilter extends HttpFilter {

    // Action của /room yêu cầu quyền Admin
    private static final Set<String> ADMIN_ROOM_ACTIONS = Set.of("add", "edit", "delete", "insert", "update");

    // Action của /user không cần Admin (user tự quản lý profile)
    private static final Set<String> USER_SELF_ACTIONS = Set.of("profile", "updateProfile", "change-password", "updatePassword");

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String path = request.getRequestURI().substring(request.getContextPath().length());

        if (isAdminPath(path, request)) {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            if (user == null || user.getRoleID() != 1) { // 1 = Admin (model Role)
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    private boolean isAdminPath(String path, HttpServletRequest request) {
        String action = request.getParameter("action");

        // /user: cần Admin trừ các action tự quản lý profile
        if (path.startsWith("/user")) {
            return action == null || !USER_SELF_ACTIONS.contains(action);
        }

        // /room-category: luôn cần Admin
        if (path.startsWith("/room-category")) {
            return true;
        }

        // /room: chỉ cần Admin với action CUD
        if (path.startsWith("/room")) {
            return action != null && ADMIN_ROOM_ACTIONS.contains(action);
        }

        // Trang view admin
        if (path.startsWith("/views/admin/")) {
            return true;
        }

        return false;
    }
}