package com.hotel.controller;

import com.hotel.model.SystemLog;
import com.hotel.model.User;
import com.hotel.service.SystemLogService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * Controller nhật ký hệ thống.
 * URL: /admin/system-log — chỉ QUAN_LY.
 */
@WebServlet("/admin/system-log")
public class SystemLogController extends HttpServlet {

    private final SystemLogService service = new SystemLogService();

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

        String keyword  = request.getParameter("keyword");
        String action   = request.getParameter("filterAction");
        String fromDate = request.getParameter("fromDate");
        String toDate   = request.getParameter("toDate");

        List<SystemLog> list = service.search(keyword, action, fromDate, toDate);
        List<String> actions = service.getDistinctActions();

        request.setAttribute("list", list);
        request.setAttribute("actions", actions);
        request.setAttribute("keyword", keyword);
        request.setAttribute("filterAction", action);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);

        request.getRequestDispatcher("/views/admin/system-log/list.jsp")
                .forward(request, response);
    }
}
