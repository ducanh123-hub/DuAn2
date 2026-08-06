package com.hotel.controller;

import com.hotel.dao.RoomDAO;
import com.hotel.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Room> roomList = roomDAO.getAll();

        request.setAttribute("roomList", roomList);

        request.getRequestDispatcher("/views/home/index.jsp")
                .forward(request, response);

    }
}