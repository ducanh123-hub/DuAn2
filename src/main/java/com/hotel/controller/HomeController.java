package com.hotel.controller;

import com.hotel.model.Room;
import com.hotel.service.RoomFavoriteService;
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
    private final RoomFavoriteService favoriteService = new RoomFavoriteService();


    // =====================================================
    // CẤU HÌNH PHÂN TRANG
    // =====================================================

    private static final int ROOMS_PER_PAGE = 7;


    // =====================================================
    // DO GET
    // =====================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");


        // =================================================
        // LẤY PAGE
        // =================================================

        int currentPage = 1;

        String pageParam =
                request.getParameter("page");


        if (pageParam != null
                && !pageParam.trim().isEmpty()) {

            try {

                currentPage =
                        Integer.parseInt(
                                pageParam.trim()
                        );

            } catch (NumberFormatException e) {

                currentPage = 1;
            }
        }


        // Không cho page < 1

        if (currentPage < 1) {

            currentPage = 1;
        }


        // =================================================
        // ĐẾM PHÒNG CÒN TRỐNG
        // =================================================

        int totalRooms =
                roomService.countAvailableRooms();


        // =================================================
        // TÍNH TỔNG SỐ TRANG
        // =================================================

        int totalPages;

        if (totalRooms == 0) {

            totalPages = 1;

        } else {

            totalPages =
                    (int) Math.ceil(
                            (double) totalRooms
                                    / ROOMS_PER_PAGE
                    );
        }


        // =================================================
        // PAGE KHÔNG ĐƯỢC VƯỢT QUÁ TOTAL PAGE
        // =================================================

        if (currentPage > totalPages) {

            currentPage = totalPages;
        }


        // =================================================
        // LẤY PHÒNG CỦA TRANG HIỆN TẠI
        //
        // MỖI TRANG 7 PHÒNG
        // =================================================

        List<Room> roomList =
                roomService.getAvailableRooms(
                        currentPage,
                        ROOMS_PER_PAGE
                );

        favoriteService.populateFavoriteCounts(roomList);


        // =================================================
        // GỬI SANG JSP
        // =================================================

        request.setAttribute(
                "roomList",
                roomList
        );

        request.setAttribute(
                "currentPage",
                currentPage
        );

        request.setAttribute(
                "totalPages",
                totalPages
        );

        request.setAttribute(
                "totalRooms",
                totalRooms
        );

        request.setAttribute(
                "roomsPerPage",
                ROOMS_PER_PAGE
        );


        // =================================================
        // HIỂN THỊ HOME
        // =================================================

        request.getRequestDispatcher(
                "/views/home/index.jsp"
        ).forward(
                request,
                response
        );
    }
}