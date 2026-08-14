package com.hotel.controller;

import com.hotel.model.User;
import com.hotel.service.AdminReviewService;
import com.hotel.service.SystemLogService;
import com.hotel.model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * Controller quản lý bình luận - phòng đánh giá.
 * URL: /review
 * action=admin-list  → Danh sách bình luận (QUAN_LY)
 * action=admin-detail → Chi tiết (QUAN_LY)
 * action=approve     → Duyệt (QUAN_LY)
 * action=hide        → Ẩn (QUAN_LY)
 * action=delete      → Xóa (QUAN_LY)
 * action=reply (POST)→ Phản hồi (QUAN_LY)
 */
@WebServlet("/review")
public class ReviewController extends HttpServlet {

    private final AdminReviewService service = new AdminReviewService();
    private final SystemLogService logService = new SystemLogService();

    // ── Kiểm tra quyền QUAN_LY ──────────────────────────────────────
    private boolean checkRole(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        User user = (User) session.getAttribute("user");
        if (user.getRoleID() != 1) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Bạn không có quyền truy cập chức năng này!");
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
        if (action == null) action = "admin-list";

        switch (action) {

            case "admin-list": {
                String keyword = request.getParameter("keyword");
                String status = request.getParameter("status");
                List<Review> list = service.search(keyword, status);
                request.setAttribute("list", list);
                request.setAttribute("keyword", keyword);
                request.setAttribute("filterStatus", status);

                // Flash messages
                HttpSession session = request.getSession(false);
                if (session != null) {
                    request.setAttribute("successMsg", session.getAttribute("successMsg"));
                    request.setAttribute("errorMsg", session.getAttribute("errorMsg"));
                    session.removeAttribute("successMsg");
                    session.removeAttribute("errorMsg");
                }
                request.getRequestDispatcher("/views/admin/review/list.jsp")
                        .forward(request, response);
                break;
            }

            case "admin-detail": {
                int id = Integer.parseInt(request.getParameter("id"));
                Review review = service.getById(id);
                request.setAttribute("review", review);
                request.getRequestDispatcher("/views/admin/review/detail.jsp")
                        .forward(request, response);
                break;
            }

            case "approve": {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = service.approve(id);
                if (ok) {
                    logService.logFromRequest(request, "UPDATE", "Duyệt bình luận ID=" + id);
                    request.getSession().setAttribute("successMsg", "Đã duyệt bình luận!");
                } else {
                    request.getSession().setAttribute("errorMsg", "Duyệt thất bại!");
                }
                response.sendRedirect(request.getContextPath() + "/review?action=admin-list");
                break;
            }

            case "hide": {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = service.hide(id);
                if (ok) {
                    logService.logFromRequest(request, "UPDATE", "Ẩn bình luận ID=" + id);
                    request.getSession().setAttribute("successMsg", "Đã ẩn bình luận!");
                } else {
                    request.getSession().setAttribute("errorMsg", "Ẩn thất bại!");
                }
                response.sendRedirect(request.getContextPath() + "/review?action=admin-list");
                break;
            }

            case "delete": {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = service.delete(id);
                if (ok) {
                    logService.logFromRequest(request, "DELETE", "Xóa bình luận ID=" + id);
                    request.getSession().setAttribute("successMsg", "Đã xóa bình luận!");
                } else {
                    request.getSession().setAttribute("errorMsg", "Xóa thất bại!");
                }
                response.sendRedirect(request.getContextPath() + "/review?action=admin-list");
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/review?action=admin-list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        if (!checkRole(request, response)) return;

        String action = request.getParameter("action");

        if ("reply".equals(action)) {
            int id = Integer.parseInt(request.getParameter("reviewId"));
            String replyText = request.getParameter("reply");
            String error = service.reply(id, replyText);
            if (error == null) {
                logService.logFromRequest(request, "UPDATE", "Phản hồi bình luận ID=" + id);
                request.getSession().setAttribute("successMsg", "Đã gửi phản hồi!");
            } else {
                request.getSession().setAttribute("errorMsg", error);
            }
        }

        response.sendRedirect(request.getContextPath() + "/review?action=admin-list");
    }
}
