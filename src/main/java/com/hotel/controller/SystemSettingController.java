package com.hotel.controller;

import com.hotel.model.SystemSetting;
import com.hotel.model.User;
import com.hotel.service.SystemLogService;
import com.hotel.service.SystemSettingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Time;

/**
 * Controller cấu hình hệ thống.
 * URL: /admin/setting — chỉ QUAN_LY.
 */
@WebServlet("/admin/setting")
public class SystemSettingController extends HttpServlet {

    private final SystemSettingService service = new SystemSettingService();
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

        SystemSetting setting = service.getSetting();
        request.setAttribute("setting", setting);

        // Flash messages
        HttpSession session = request.getSession(false);
        if (session != null) {
            request.setAttribute("successMsg", session.getAttribute("successMsg"));
            request.setAttribute("errorMsg", session.getAttribute("errorMsg"));
            session.removeAttribute("successMsg");
            session.removeAttribute("errorMsg");
        }

        request.getRequestDispatcher("/views/admin/setting/index.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        if (!checkRole(request, response)) return;

        SystemSetting setting = new SystemSetting();
        try {
            setting.setSettingID(Integer.parseInt(request.getParameter("settingID")));
        } catch (Exception ignore) {}
        setting.setHotelName(request.getParameter("hotelName"));
        setting.setAddress(request.getParameter("address"));
        setting.setPhone(request.getParameter("phone"));
        setting.setEmail(request.getParameter("email"));
        try {
            setting.setCheckinTime(Time.valueOf(request.getParameter("checkinTime") + ":00"));
        } catch (Exception ignore) {}
        try {
            setting.setCheckoutTime(Time.valueOf(request.getParameter("checkoutTime") + ":00"));
        } catch (Exception ignore) {}
        setting.setCancelPolicy(request.getParameter("cancelPolicy"));
        setting.setPaymentMethods(request.getParameter("paymentMethods"));
        setting.setOtherSetting(request.getParameter("otherSetting"));

        boolean ok = service.updateSetting(setting);
        if (ok) {
            logService.logFromRequest(request, "UPDATE", "Cập nhật cấu hình hệ thống");
            request.getSession().setAttribute("successMsg",
                    "Cập nhật cấu hình hệ thống thành công!");
        } else {
            request.getSession().setAttribute("errorMsg",
                    "Cập nhật thất bại! Vui lòng kiểm tra lại.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/setting");
    }
}
