package com.hotel.filter;

import com.hotel.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AdminFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String path = request.getRequestURI().substring(request.getContextPath().length());
        String action = request.getParameter("action");

        boolean isAdminPath = (path.startsWith("/user") && (action == null || (!action.equals("profile") && !action.equals("updateProfile") && !action.equals("change-password") && !action.equals("updatePassword")))) ||
                path.startsWith("/room-category") ||
                (path.startsWith("/room") && (action != null && (action.equals("add") || action.equals("edit") || action.equals("delete") || action.equals("insert") || action.equals("update")))) ||
                path.startsWith("/views/admin/");

        if (isAdminPath) {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            if (user == null || user.getRoleID() != 1) { // RoleID 1 is Admin
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
