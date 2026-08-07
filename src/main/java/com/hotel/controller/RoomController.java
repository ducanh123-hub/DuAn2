package com.hotel.controller;

import com.hotel.model.Room;
import com.hotel.service.RoomService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/room")
public class RoomController extends HttpServlet {

    private final RoomService roomService = new RoomService();

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
                showAdd(request, response);
                break;

            case "edit":
                showEdit(request, response);
                break;

            case "delete":
                delete(request, response);
                break;

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

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action)) {

            insert(request, response);

        } else if ("update".equals(action)) {

            update(request, response);

        }

    }

    private void list(HttpServletRequest request,
                      HttpServletResponse response)
            throws ServletException, IOException {

        List<Room> list = roomService.getAllRooms();

        request.setAttribute("list", list);

        request.getRequestDispatcher("/views/room/list.jsp")
                .forward(request, response);

    }

    private void showAdd(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/room/add.jsp")
                .forward(request, response);

    }

    private void showEdit(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Room room = roomService.getRoomById(id);

        request.setAttribute("room", room);

        request.getRequestDispatcher("/views/room/update.jsp")
                .forward(request, response);

    }

    private void detail(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Room room = roomService.getRoomById(id);

        request.setAttribute("room", room);

        request.getRequestDispatcher("/views/room/detail.jsp")
                .forward(request, response);

    }
    private void insert(HttpServletRequest request,
                        HttpServletResponse response)
            throws IOException {

        Room room = new Room();

        room.setCategoryID(Integer.parseInt(request.getParameter("categoryID")));
        room.setRoomNumber(request.getParameter("roomNumber"));
        room.setRoomName(request.getParameter("roomName"));
        room.setPrice(new BigDecimal(request.getParameter("price")));
        room.setAcreage(new BigDecimal(request.getParameter("acreage")));
        room.setBed(Integer.parseInt(request.getParameter("bed")));
        room.setArea(request.getParameter("area"));
        room.setDescription(request.getParameter("description"));
        room.setStatus(request.getParameter("status"));

        roomService.addRoom(room);

        response.sendRedirect("room");
    }
    private void update(HttpServletRequest request,
                        HttpServletResponse response)
            throws IOException {

        Room room = new Room();

        room.setRoomID(Integer.parseInt(request.getParameter("roomID")));
        room.setCategoryID(Integer.parseInt(request.getParameter("categoryID")));
        room.setRoomNumber(request.getParameter("roomNumber"));
        room.setRoomName(request.getParameter("roomName"));
        room.setPrice(new BigDecimal(request.getParameter("price")));
        room.setAcreage(new BigDecimal(request.getParameter("acreage")));
        room.setBed(Integer.parseInt(request.getParameter("bed")));
        room.setArea(request.getParameter("area"));
        room.setDescription(request.getParameter("description"));
        room.setStatus(request.getParameter("status"));

        roomService.updateRoom(room);

        response.sendRedirect("room");
    }
    private void delete(HttpServletRequest request,
                        HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        roomService.deleteRoom(id);

        response.sendRedirect("room");
    }
    private void search(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        List<Room> list = roomService.searchRoom(keyword);

        request.setAttribute("list", list);

        request.getRequestDispatcher("/views/room/search.jsp")
                .forward(request, response);
    }
}
