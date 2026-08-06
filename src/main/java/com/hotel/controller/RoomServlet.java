package com.hotel.controller;

import com.hotel.dao.RoomDAO;
import com.hotel.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/room")
public class RoomServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "detail":
                detail(request, response);
                break;

            case "search":
                search(request, response);
                break;

            default:
                list(request, response);
                break;
        }

    }

    private void list(HttpServletRequest request,
                      HttpServletResponse response)
            throws ServletException, IOException {

        List<Room> list = roomDAO.getAll();

        request.setAttribute("roomList", list);

        request.getRequestDispatcher("/views/room/list.jsp")
                .forward(request, response);

    }

    private void detail(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Room room = roomDAO.getById(id);

        request.setAttribute("room", room);

        request.getRequestDispatcher("/views/room/detail.jsp")
                .forward(request, response);

    }

    private void search(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        List<Room> list = roomDAO.searchByName(keyword);

        request.setAttribute("roomList", list);

        request.getRequestDispatcher("/views/room/search.jsp")
                .forward(request, response);

    }

}