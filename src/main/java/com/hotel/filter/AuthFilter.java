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
public class AuthFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String path = request.getRequestURI().substring(request.getContextPath().length());

        // Allow public pages and assets
        boolean isPublicPath = path.equals("/") ||
                path.startsWith("/home") ||
                path.startsWith("/login") ||
                path.startsWith("/register") ||
                path.startsWith("/forgot-password") ||
                path.startsWith("/room") && (request.getParameter("action") == null || request.getParameter("action").equals("list") || request.getParameter("action").equals("detail") || request.getParameter("action").equals("search")) ||
                path.startsWith("/assets/") ||
                path.startsWith("/views/auth/") ||
                path.startsWith("/views/home/") ||
                path.startsWith("/views/layout/");

        if (isPublicPath) {
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
}
