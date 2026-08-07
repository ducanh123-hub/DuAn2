package com.hotel.controller;

import com.hotel.model.RoomCategory;
import com.hotel.service.RoomCategoryService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/room-category")
public class RoomCategoryController extends HttpServlet {

    private final RoomCategoryService service = new RoomCategoryService();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "add":
                request.getRequestDispatcher("/views/category/add.jsp")
                        .forward(request, response);
                break;

            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                RoomCategory category = service.getById(editId);
                request.setAttribute("category", category);
                request.getRequestDispatcher("/views/category/update.jsp")
                        .forward(request, response);
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                service.delete(deleteId);
                response.sendRedirect("room-category");
                break;

            default:
                List<RoomCategory> list = service.getAll();
                request.setAttribute("list", list);
                request.getRequestDispatcher("/views/category/list.jsp")
                        .forward(request, response);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            RoomCategory category = new RoomCategory();
            category.setCategoryName(request.getParameter("categoryName"));
            category.setDescription(request.getParameter("description"));
            category.setBasePrice(new BigDecimal(request.getParameter("basePrice")));
            category.setMaxPeople(Integer.parseInt(request.getParameter("maxPeople")));
            category.setStatus(request.getParameter("status"));

            service.insert(category);
            response.sendRedirect("room-category");

        } else if ("update".equals(action)) {
            RoomCategory category = new RoomCategory();
            category.setCategoryID(Integer.parseInt(request.getParameter("categoryID")));
            category.setCategoryName(request.getParameter("categoryName"));
            category.setDescription(request.getParameter("description"));
            category.setBasePrice(new BigDecimal(request.getParameter("basePrice")));
            category.setMaxPeople(Integer.parseInt(request.getParameter("maxPeople")));
            category.setStatus(request.getParameter("status"));

            service.update(category);
            response.sendRedirect("room-category");
        }

    }

}
