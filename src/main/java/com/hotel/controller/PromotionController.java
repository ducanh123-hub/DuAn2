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

@WebServlet("/promotion")
public class PromotionController extends HttpServlet {

    private final PromotionService service = new PromotionService();
    private final SystemLogService logService = new SystemLogService();

    private boolean checkRole(HttpServletRequest req, HttpServletResponse res) throws IOException {
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

            case "edit":
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

            case "delete":
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

            default:
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        if (!checkRole(request, response)) return;

        String action = request.getParameter("action");
        Voucher v = buildVoucher(request);
        String error;

        if ("insert".equals(action)) {
            error = service.addPromotion(v);

            if (error == null) {
                logService.logFromRequest(request, "ADD", "Thêm voucher: " + v.getCode());
                request.getSession().setAttribute("successMsg",
                        "Thêm khuyến mãi \"" + v.getCode() + "\" thành công!");
                response.sendRedirect(request.getContextPath() + "/promotion");
                return;
            }

        } else if ("update".equals(action)) {
            try {
                v.setPromotionID(Integer.parseInt(request.getParameter("promotionID")));
            } catch (NumberFormatException e) {
                error = "ID voucher không hợp lệ!";
                request.setAttribute("error", error);
                request.setAttribute("voucher", v);
                request.getRequestDispatcher("/views/admin/promotion/form.jsp")
                        .forward(request, response);
                return;
            }

            error = service.updatePromotion(v);

            if (error == null) {
                logService.logFromRequest(request, "UPDATE", "Cập nhật voucher: " + v.getCode());
                request.getSession().setAttribute("successMsg", "Cập nhật khuyến mãi thành công!");
                response.sendRedirect(request.getContextPath() + "/promotion");
                return;
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/promotion");
            return;
        }

        request.setAttribute("error", error);
        request.setAttribute("voucher", v);
        request.getRequestDispatcher("/views/admin/promotion/form.jsp")
                .forward(request, response);
    }

    private Voucher buildVoucher(HttpServletRequest request) {
        Voucher v = new Voucher();

        String code = request.getParameter("code");
        v.setCode(code != null ? code.trim().toUpperCase() : "");

        v.setName(request.getParameter("name"));
        v.setDescription(request.getParameter("description"));
        v.setDiscountType(request.getParameter("discountType"));
        v.setStatus(request.getParameter("status"));

        try {
            String value = request.getParameter("discountValue");
            if (value != null && !value.trim().isEmpty())
                v.setDiscountValue(new BigDecimal(value.trim()));
        } catch (Exception ignored) {}

        try {
            String value = request.getParameter("minOrderAmount");
            if (value != null && !value.trim().isEmpty())
                v.setMinOrderAmount(new BigDecimal(value.trim()));
        } catch (Exception ignored) {}

        try {
            String value = request.getParameter("maxDiscountAmount");
            if (value != null && !value.trim().isEmpty())
                v.setMaxDiscountAmount(new BigDecimal(value.trim()));
        } catch (Exception ignored) {}

        try {
            String value = request.getParameter("usageLimit");
            if (value != null && !value.trim().isEmpty())
                v.setUsageLimit(Integer.parseInt(value.trim()));
        } catch (Exception ignored) {}

        try {
            String value = request.getParameter("startDate");
            if (value != null && !value.trim().isEmpty())
                v.setStartDate(Date.valueOf(value));
        } catch (Exception ignored) {}

        try {
            String value = request.getParameter("endDate");
            if (value != null && !value.trim().isEmpty())
                v.setEndDate(Date.valueOf(value));
        } catch (Exception ignored) {}

        return v;
    }
}