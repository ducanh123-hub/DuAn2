package com.hotel.filter;

import com.hotel.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Set;

public class AuthFilter extends HttpFilter {

    private static final Set<String> PUBLIC_ROOM_ACTIONS = Set.of("list", "detail", "search");

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String path = request.getRequestURI().substring(request.getContextPath().length());

        if (isPublicPath(path, request)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            chain.doFilter(request, response);
        }
    }

    private boolean isPublicPath(String path, HttpServletRequest request) {
        if (path.equals("/")
                || path.startsWith("/home")
                || path.startsWith("/login")
                || path.startsWith("/register")
                || path.startsWith("/forgot-password")
                || path.startsWith("/assets/")
                || path.startsWith("/views/auth/")
                || path.startsWith("/views/home/")
                || path.startsWith("/views/layout/")) {
            return true;
        }

        // /room public chỉ với action: list, detail, search (hoặc không có action)
        if (path.startsWith("/room")) {
            String action = request.getParameter("action");
            return action == null || PUBLIC_ROOM_ACTIONS.contains(action);
        }

        return false;
    }
}