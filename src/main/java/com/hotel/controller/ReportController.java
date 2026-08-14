package com.hotel.controller;

import com.hotel.model.User;
import com.hotel.service.ReportService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Calendar;

/**
 * Controller thống kê doanh thu và khách hàng.
 * URL: /admin/report?tab=revenue | tab=customer
 */
@WebServlet("/admin/report")
public class ReportController extends HttpServlet {

    private final ReportService reportService = new ReportService();

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

        String tab = request.getParameter("tab");
        if (tab == null) tab = "revenue";

        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;

        // Parse year/month từ query string
        int year = currentYear;
        int month = currentMonth;
        try {
            if (request.getParameter("year") != null)
                year = Integer.parseInt(request.getParameter("year"));
        } catch (NumberFormatException ignore) {}
        try {
            if (request.getParameter("month") != null)
                month = Integer.parseInt(request.getParameter("month"));
        } catch (NumberFormatException ignore) {}

        request.setAttribute("tab", tab);
        request.setAttribute("year", year);
        request.setAttribute("month", month);
        request.setAttribute("currentYear", currentYear);

        if ("revenue".equals(tab)) {
            // Doanh thu
            request.setAttribute("revenueByDay",
                    reportService.getRevenueByDay(month, year));
            request.setAttribute("revenueByMonth",
                    reportService.getRevenueByMonth(year));
            request.setAttribute("revenueByYear",
                    reportService.getRevenueByYear());
            request.setAttribute("revenueByCategory",
                    reportService.getRevenueByRoomCategory());
            request.setAttribute("totalRevenue",
                    reportService.getTotalRevenue());
            request.setAttribute("roomOccupancy",
                    reportService.getRoomOccupancy());

            request.getRequestDispatcher("/views/admin/report/revenue.jsp")
                    .forward(request, response);

        } else {
            // Khách hàng
            request.setAttribute("newCustomersThisMonth",
                    reportService.getNewCustomersThisMonth());
            request.setAttribute("totalCompleted",
                    reportService.getTotalCompletedBookings());
            request.setAttribute("topCustomers",
                    reportService.getTopCustomers(10));
            request.setAttribute("customerByMonth",
                    reportService.getNewCustomersByMonth(year));

            request.getRequestDispatcher("/views/admin/report/customer.jsp")
                    .forward(request, response);
        }
    }
}
