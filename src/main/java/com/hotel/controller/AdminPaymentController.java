package com.hotel.controller;

import com.hotel.model.Payment;
import com.hotel.model.User;
import com.hotel.service.AdminPaymentService;
import com.hotel.service.SystemLogService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * Controller quản lý thanh toán.
 * URL: /admin/payment — chỉ QUAN_LY.
 */
@WebServlet("/admin/payment")
public class AdminPaymentController extends HttpServlet {

    private final AdminPaymentService service = new AdminPaymentService();
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

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "detail": {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Payment p = service.getById(id);
                    request.setAttribute("payment", p);
                    request.getRequestDispatcher("/views/admin/payment/detail.jsp")
                            .forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/admin/payment");
                }
                break;
            }
            case "confirm": {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String error = service.confirmPayment(id);
                    if (error == null) {
                        logService.logFromRequest(request, "UPDATE", "Xác nhận thanh toán ID=" + id);
                        request.getSession().setAttribute("successMsg", "Xác nhận thanh toán thành công!");
                    } else {
                        request.getSession().setAttribute("errorMsg", error);
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("errorMsg", "ID không hợp lệ!");
                }
                response.sendRedirect(request.getContextPath() + "/admin/payment");
                break;
            }
            default: { // list
                List<Payment> list = service.getAll();
                request.setAttribute("list", list);

                HttpSession session = request.getSession(false);
                if (session != null) {
                    request.setAttribute("successMsg", session.getAttribute("successMsg"));
                    request.setAttribute("errorMsg", session.getAttribute("errorMsg"));
                    session.removeAttribute("successMsg");
                    session.removeAttribute("errorMsg");
                }
                request.getRequestDispatcher("/views/admin/payment/list.jsp")
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

        if ("refund".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String reason = request.getParameter("refundReason");
                String error = service.processRefund(id, reason);
                if (error == null) {
                    logService.logFromRequest(request, "UPDATE", "Hoàn tiền thanh toán ID=" + id);
                    request.getSession().setAttribute("successMsg", "Xử lý hoàn tiền thành công!");
                } else {
                    request.getSession().setAttribute("errorMsg", error);
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMsg", "ID không hợp lệ!");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/payment");
    }
}
