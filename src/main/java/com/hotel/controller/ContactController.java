package com.hotel.controller;

import com.hotel.model.Contact;
import com.hotel.dao.ContactDAO;
import com.hotel.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/contact")
public class ContactController extends HttpServlet {

    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/home/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        Contact contact = new Contact();
        if (user != null) {
            contact.setUserID(user.getUserID());
        }
        contact.setFullName(request.getParameter("fullName"));
        contact.setEmail(request.getParameter("email"));
        contact.setPhone(request.getParameter("phone"));
        contact.setSubject(request.getParameter("subject"));
        contact.setMessage(request.getParameter("message"));
        contact.setStatus("Chưa xử lý");
        contact.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        boolean success = contactDAO.insert(contact);
        if (success) {
            request.setAttribute("message", "Gửi liên hệ thành công! Chúng tôi sẽ phản hồi sớm nhất có thể.");
        } else {
            request.setAttribute("error", "Gửi liên hệ thất bại. Vui lòng thử lại!");
        }

        request.getRequestDispatcher("/views/home/contact.jsp").forward(request, response);
    }
}
