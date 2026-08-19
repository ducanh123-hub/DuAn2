package com.hotel.controller;

import com.hotel.dao.ContactDAO;
import com.hotel.model.Contact;
import com.hotel.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/contact", "/admin/contact/update-status"})
public class AdminContactController extends HttpServlet {

    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user.getRoleID() != 1) { // 1 = QUAN_LY
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
            return;
        }

        String path = request.getServletPath();

        if (path.equals("/admin/contact")) {
            List<Contact> contactList = contactDAO.getAll();
            request.setAttribute("contactList", contactList);
            request.getRequestDispatcher("/views/admin/contact/list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user.getRoleID() != 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thao tác!");
            return;
        }

        String path = request.getServletPath();

        if (path.equals("/admin/contact/update-status")) {
            try {
                int contactId = Integer.parseInt(request.getParameter("contactID"));
                String newStatus = request.getParameter("status"); // "Đã xử lý" hoặc "Chưa xử lý"

                Contact contact = contactDAO.getById(contactId);
                if (contact != null) {
                    contact.setStatus(newStatus);
                    contactDAO.update(contact);
                    request.getSession().setAttribute("message", "Cập nhật trạng thái thành công!");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("error", "Lỗi khi cập nhật trạng thái!");
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/admin/contact");
        }
    }
}
