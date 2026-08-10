package com.hotel.filter;

import com.hotel.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class CustomerFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        String path = request.getRequestURI().substring(request.getContextPath().length());

        if (isCustomerPath(path)) {
            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("user") : null;

            // 3 = Customer, 1 = Admin (model Role)
            if (user == null || (user.getRoleID() != 3 && user.getRoleID() != 1)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Yêu cầu quyền truy cập của khách hàng!");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    private boolean isCustomerPath(String path) {
        return path.startsWith("/customer/")
                || path.startsWith("/views/customer/");
    }
}