package com.hotel.controller;

import com.hotel.model.User;
import com.hotel.model.Voucher;
import com.hotel.service.PromotionService;
import com.hotel.service.SystemLogService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

/**
 * Controller quản lý khuyến mãi / voucher.
 * URL: /promotion — chỉ QUAN_LY (RoleID = 1).
 */
@WebServlet("/promotion")
public class PromotionController extends HttpServlet {

    private final PromotionService service = new PromotionService();
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
        response.setCharacterEncoding("UTF-8");

        if (!checkRole(request, response)) return;

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.getRequestDispatcher("/views/admin/promotion/form.jsp")
                        .forward(request, response);
                break;

            case "edit": {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Voucher v = service.getById(id);
                    if (v == null) {
                        request.getSession().setAttribute("errorMsg", "Không tìm thấy khuyến mãi!");
                        response.sendRedirect(request.getContextPath() + "/promotion");
                        return;
                    }
                    request.setAttribute("voucher", v);
                    request.getRequestDispatcher("/views/admin/promotion/form.jsp")
                            .forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/promotion");
                }
                break;
            }

            case "delete": {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    boolean ok = service.delete(id);
                    if (ok) {
                        logService.logFromRequest(request, "DELETE", "Xóa voucher ID=" + id);
                        request.getSession().setAttribute("successMsg", "Xóa khuyến mãi thành công!");
                    } else {
                        request.getSession().setAttribute("errorMsg", "Xóa thất bại!");
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("errorMsg", "ID không hợp lệ!");
                }
                response.sendRedirect(request.getContextPath() + "/promotion");
                break;
            }

            default: { // list
                List<Voucher> list = service.getAll();
                request.setAttribute("list", list);

                HttpSession session = request.getSession(false);
                if (session != null) {
                    request.setAttribute("successMsg", session.getAttribute("successMsg"));
                    request.setAttribute("errorMsg", session.getAttribute("errorMsg"));
                    session.removeAttribute("successMsg");
                    session.removeAttribute("errorMsg");
                }
                request.getRequestDispatcher("/views/admin/promotion/list.jsp")
                        .forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        if (!checkRole(request, response)) return;

        String action = request.getParameter("action");

        Voucher v = buildVoucher(request);
        String error;

        if ("insert".equals(action)) {
            error = service.addPromotion(v);
            if (error == null) {
                logService.logFromRequest(request, "ADD", "Thêm voucher: " + v.getVoucherCode());
                request.getSession().setAttribute("successMsg",
                        "Thêm khuyến mãi \"" + v.getVoucherCode() + "\" thành công!");
                response.sendRedirect(request.getContextPath() + "/promotion");
                return;
            }

        } else if ("update".equals(action)) {
            try {
                v.setVoucherID(Integer.parseInt(request.getParameter("voucherID")));
            } catch (NumberFormatException ignore) {}
            error = service.updatePromotion(v);
            if (error == null) {
                logService.logFromRequest(request, "UPDATE", "Cập nhật voucher: " + v.getVoucherCode());
                request.getSession().setAttribute("successMsg", "Cập nhật khuyến mãi thành công!");
                response.sendRedirect(request.getContextPath() + "/promotion");
                return;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/promotion");
            return;
        }

        // Nếu có lỗi — quay lại form
        request.setAttribute("error", error);
        request.setAttribute("voucher", v);
        request.getRequestDispatcher("/views/admin/promotion/form.jsp")
                .forward(request, response);
    }

    private Voucher buildVoucher(HttpServletRequest request) {
        Voucher v = new Voucher();
        v.setVoucherCode(request.getParameter("voucherCode") != null
                ? request.getParameter("voucherCode").trim().toUpperCase() : "");
        v.setVoucherName(request.getParameter("voucherName"));
        v.setDiscountType(request.getParameter("discountType"));
        v.setStatus(request.getParameter("status"));
        try { v.setDiscountValue(new BigDecimal(request.getParameter("discountValue"))); }
        catch (Exception ignore) {}
        try { v.setMaxDiscount(new BigDecimal(request.getParameter("maxDiscount"))); }
        catch (Exception ignore) {}
        try { v.setMinOrderValue(new BigDecimal(request.getParameter("minOrderValue"))); }
        catch (Exception ignore) {}
        try { v.setQuantity(Integer.parseInt(request.getParameter("quantity"))); }
        catch (Exception ignore) {}
        try { v.setStartDate(Date.valueOf(request.getParameter("startDate"))); }
        catch (Exception ignore) {}
        try { v.setEndDate(Date.valueOf(request.getParameter("endDate"))); }
        catch (Exception ignore) {}
        return v;
    }
}
