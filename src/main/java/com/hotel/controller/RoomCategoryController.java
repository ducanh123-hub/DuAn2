package com.hotel.controller;

import com.hotel.model.RoomCategory;
import com.hotel.model.User;
import com.hotel.service.RoomCategoryService;
import com.hotel.service.SystemLogService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * Controller quản lý danh mục phòng.
 * URL: /room-category
 * Yêu cầu đăng nhập và RoleID = 1 (QUAN_LY).
 */
@WebServlet("/room-category")
public class RoomCategoryController extends HttpServlet {

    private final RoomCategoryService service = new RoomCategoryService();
    private final SystemLogService logService = new SystemLogService();

    // ── Kiểm tra quyền QUAN_LY ─────────────────────────────────────
    private boolean checkRole(HttpServletRequest request,
                              HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        User user = (User) session.getAttribute("user");
        if (user.getRoleID() != 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
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
        if (action == null) action = "list";

        switch (action) {

            case "add":
                // Hiển thị form thêm mới
                request.getRequestDispatcher("/views/admin/roomCategory/form.jsp")
                        .forward(request, response);
                break;

            case "edit":
                // Hiển thị form chỉnh sửa
                try {
                    int editId = Integer.parseInt(request.getParameter("id"));
                    RoomCategory category = service.getById(editId);
                    if (category == null) {
                        request.setAttribute("error", "Không tìm thấy loại phòng!");
                        List<RoomCategory> list = service.getAll();
                        request.setAttribute("list", list);
                        request.getRequestDispatcher("/views/admin/roomCategory/list.jsp")
                                .forward(request, response);
                        return;
                    }
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("/views/admin/roomCategory/form.jsp")
                            .forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/room-category");
                }
                break;

            case "delete":
                // Xóa loại phòng — kiểm tra ràng buộc
                try {
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    String error = service.deleteCategory(deleteId);
                    if (error != null) {
                        request.getSession().setAttribute("errorMsg", error);
                    } else {
                        logService.logFromRequest(request, "DELETE",
                                "Xóa loại phòng ID=" + deleteId);
                        request.getSession().setAttribute("successMsg",
                                "Xóa loại phòng thành công!");
                    }
                } catch (NumberFormatException e) {
                    request.getSession().setAttribute("errorMsg", "ID không hợp lệ!");
                }
                response.sendRedirect(request.getContextPath() + "/room-category");
                break;

            case "search":
                String keyword = request.getParameter("keyword");
                List<RoomCategory> searchResult = service.search(keyword);
                request.setAttribute("list", searchResult);
                request.setAttribute("keyword", keyword);
                request.getRequestDispatcher("/views/admin/roomCategory/list.jsp")
                        .forward(request, response);
                break;

            default: // list
                List<RoomCategory> list = service.getAll();
                request.setAttribute("list", list);

                // Lấy thông báo từ session (sau redirect)
                HttpSession session = request.getSession(false);
                if (session != null) {
                    request.setAttribute("successMsg", session.getAttribute("successMsg"));
                    request.setAttribute("errorMsg", session.getAttribute("errorMsg"));
                    session.removeAttribute("successMsg");
                    session.removeAttribute("errorMsg");
                }

                request.getRequestDispatcher("/views/admin/roomCategory/list.jsp")
                        .forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        if (!checkRole(request, response)) return;

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            // ── Thêm loại phòng mới ──────────────────────────────
            RoomCategory category = buildCategory(request);
            String error = service.addCategory(category);
            if (error != null) {
                request.setAttribute("error", error);
                request.setAttribute("category", category);
                request.getRequestDispatcher("/views/admin/roomCategory/form.jsp")
                        .forward(request, response);
                return;
            }
            logService.logFromRequest(request, "ADD",
                    "Thêm loại phòng: " + category.getCategoryName());
            request.getSession().setAttribute("successMsg",
                    "Thêm loại phòng \"" + category.getCategoryName() + "\" thành công!");
            response.sendRedirect(request.getContextPath() + "/room-category");

        } else if ("update".equals(action)) {
            // ── Cập nhật loại phòng ──────────────────────────────
            RoomCategory category = buildCategory(request);
            try {
                category.setCategoryID(Integer.parseInt(request.getParameter("categoryID")));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID không hợp lệ!");
                request.getRequestDispatcher("/views/admin/roomCategory/list.jsp")
                        .forward(request, response);
                return;
            }
            String error = service.updateCategory(category);
            if (error != null) {
                request.setAttribute("error", error);
                request.setAttribute("category", category);
                request.getRequestDispatcher("/views/admin/roomCategory/form.jsp")
                        .forward(request, response);
                return;
            }
            logService.logFromRequest(request, "UPDATE",
                    "Cập nhật loại phòng ID=" + category.getCategoryID()
                    + " - " + category.getCategoryName());
            request.getSession().setAttribute("successMsg",
                    "Cập nhật loại phòng thành công!");
            response.sendRedirect(request.getContextPath() + "/room-category");

        } else {
            response.sendRedirect(request.getContextPath() + "/room-category");
        }
    }

    // ── Build RoomCategory từ form parameters ──────────────────────
    private RoomCategory buildCategory(HttpServletRequest request) {
        RoomCategory category = new RoomCategory();
        category.setCategoryName(request.getParameter("categoryName"));
        category.setDescription(request.getParameter("description"));
        category.setStatus(request.getParameter("status"));
        try {
            category.setBasePrice(new BigDecimal(request.getParameter("basePrice")));
        } catch (Exception e) {
            category.setBasePrice(BigDecimal.ZERO);
        }
        try {
            category.setMaxPeople(Integer.parseInt(request.getParameter("maxPeople")));
        } catch (Exception e) {
            category.setMaxPeople(0);
        }
        return category;
    }
}
