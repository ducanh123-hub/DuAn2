package com.hotel.controller;

import com.hotel.model.Room;
import com.hotel.service.RoomService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeController extends HttpServlet {

    private final RoomService roomService = new RoomService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy tất cả phòng
        List<Room> roomList = roomService.getAllRooms();

        request.setAttribute("roomList", roomList);

        request.getRequestDispatcher("/views/home/index.jsp")
                .forward(request, response);

    }

}
