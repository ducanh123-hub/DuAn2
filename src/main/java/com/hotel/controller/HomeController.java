package com.hotel.controller;

import com.hotel.model.Room;
import com.hotel.service.RoomService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/", "/home"})
public class HomeController extends HttpServlet {

    private final RoomService roomService = new RoomService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy danh sách phòng từ database
        List<Room> roomList = roomService.getAllRooms();

        // Đưa danh sách phòng sang JSP
        request.setAttribute("roomList", roomList);

        // Hiển thị trang chủ
        request.getRequestDispatcher("/views/home/index.jsp")
                .forward(request, response);
    }
}
