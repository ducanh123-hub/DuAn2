package com.hotel.controller;

import com.hotel.model.Room;
import com.hotel.service.RoomService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/room")
public class RoomController extends HttpServlet {

    private final RoomService roomService = new RoomService();


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

        String action = request.getParameter("action");


        if (action == null || action.trim().isEmpty()) {

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


    // =====================================================
    // DO POST
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");


        if ("insert".equals(action)) {

            insert(request, response);

        } else if ("update".equals(action)) {

            update(request, response);

        } else {

            response.sendRedirect(
                    request.getContextPath() + "/room"
            );
        }
    }


    // =====================================================
    // LIST
    // =====================================================

    private void list(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        List<Room> list =
                roomService.getAllRooms();

        request.setAttribute(
                "list",
                list
        );

        request.getRequestDispatcher(
                "/views/room/list.jsp"
        ).forward(request, response);
    }


    // =====================================================
    // SHOW ADD
    // =====================================================

    private void showAdd(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.getRequestDispatcher(
                "/views/room/add.jsp"
        ).forward(request, response);
    }


    // =====================================================
    // SHOW EDIT
    // =====================================================

    private void showEdit(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String idParam =
                request.getParameter("id");


        if (idParam == null || idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/room"
            );

            return;
        }


        int id = Integer.parseInt(idParam);


        Room room =
                roomService.getRoomById(id);


        if (room == null) {

            response.sendRedirect(
                    request.getContextPath() + "/room"
            );

            return;
        }


        request.setAttribute(
                "room",
                room
        );


        request.getRequestDispatcher(
                "/views/room/update.jsp"
        ).forward(request, response);
    }


    // =====================================================
    // DETAIL
    // =====================================================

    private void detail(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String idParam =
                request.getParameter("id");


        if (idParam == null || idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/room"
            );

            return;
        }


        int id = Integer.parseInt(idParam);


        Room room =
                roomService.getRoomById(id);


        if (room == null) {

            response.sendRedirect(
                    request.getContextPath() + "/room"
            );

            return;
        }


        request.setAttribute(
                "room",
                room
        );


        request.getRequestDispatcher(
                "/views/room/detail.jsp"
        ).forward(request, response);
    }


    // =====================================================
    // INSERT
    // =====================================================

    private void insert(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        Room room = new Room();


        room.setCategoryID(
                Integer.parseInt(
                        request.getParameter("categoryID")
                )
        );


        room.setRoomNumber(
                request.getParameter("roomNumber")
        );


        room.setRoomName(
                request.getParameter("roomName")
        );


        room.setPrice(
                new BigDecimal(
                        request.getParameter("price")
                )
        );


        room.setAcreage(
                new BigDecimal(
                        request.getParameter("acreage")
                )
        );


        room.setBed(
                Integer.parseInt(
                        request.getParameter("bed")
                )
        );


        room.setArea(
                request.getParameter("area")
        );


        room.setDescription(
                request.getParameter("description")
        );


        room.setStatus(
                request.getParameter("status")
        );


        roomService.addRoom(room);


        response.sendRedirect(
                request.getContextPath() + "/room"
        );
    }


    // =====================================================
    // UPDATE
    // =====================================================

    private void update(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        Room room = new Room();


        room.setRoomID(
                Integer.parseInt(
                        request.getParameter("roomID")
                )
        );


        room.setCategoryID(
                Integer.parseInt(
                        request.getParameter("categoryID")
                )
        );


        room.setRoomNumber(
                request.getParameter("roomNumber")
        );


        room.setRoomName(
                request.getParameter("roomName")
        );


        room.setPrice(
                new BigDecimal(
                        request.getParameter("price")
                )
        );


        room.setAcreage(
                new BigDecimal(
                        request.getParameter("acreage")
                )
        );


        room.setBed(
                Integer.parseInt(
                        request.getParameter("bed")
                )
        );


        room.setArea(
                request.getParameter("area")
        );


        room.setDescription(
                request.getParameter("description")
        );


        room.setStatus(
                request.getParameter("status")
        );


        roomService.updateRoom(room);


        response.sendRedirect(
                request.getContextPath() + "/room"
        );
    }


    // =====================================================
    // DELETE
    // =====================================================

    private void delete(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        String idParam =
                request.getParameter("id");


        if (idParam == null || idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/room"
            );

            return;
        }


        int id =
                Integer.parseInt(idParam);


        roomService.deleteRoom(id);


        response.sendRedirect(
                request.getContextPath() + "/room"
        );
    }


    // =====================================================
    // SEARCH + FILTER
    // =====================================================

    private void search(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {


        // -------------------------------------------------
        // KEYWORD
        // -------------------------------------------------

        String keyword =
                request.getParameter("keyword");


        if (keyword != null) {

            keyword = keyword.trim();

        }


        // -------------------------------------------------
        // MIN PRICE
        // -------------------------------------------------

        String minPriceParam =
                request.getParameter("minPrice");


        BigDecimal minPrice = null;


        if (minPriceParam != null
                && !minPriceParam.trim().isEmpty()) {

            try {

                minPrice =
                        new BigDecimal(
                                minPriceParam.trim()
                        );

            } catch (NumberFormatException e) {

                minPrice = null;

            }
        }


        // -------------------------------------------------
        // MAX PRICE
        // -------------------------------------------------

        String maxPriceParam =
                request.getParameter("maxPrice");


        BigDecimal maxPrice = null;


        if (maxPriceParam != null
                && !maxPriceParam.trim().isEmpty()) {

            try {

                maxPrice =
                        new BigDecimal(
                                maxPriceParam.trim()
                        );

            } catch (NumberFormatException e) {

                maxPrice = null;

            }
        }


        // -------------------------------------------------
        // PEOPLE
        // -------------------------------------------------

        String peopleParam =
                request.getParameter("people");


        Integer people = null;


        if (peopleParam != null
                && !peopleParam.trim().isEmpty()) {

            try {

                people =
                        Integer.parseInt(
                                peopleParam.trim()
                        );

            } catch (NumberFormatException e) {

                people = null;

            }
        }


        // -------------------------------------------------
        // SORT PRICE
        // -------------------------------------------------

        String sortPrice =
                request.getParameter("sortPrice");


        if (sortPrice == null) {

            sortPrice = "";

        }


        // -------------------------------------------------
        // KIỂM TRA GIÁ
        // -------------------------------------------------

        if (minPrice != null
                && maxPrice != null
                && minPrice.compareTo(maxPrice) > 0) {

            BigDecimal temp = minPrice;

            minPrice = maxPrice;

            maxPrice = temp;
        }


        // -------------------------------------------------
        // SEARCH DATABASE
        // -------------------------------------------------

        List<Room> list =
                roomService.searchRooms(
                        keyword,
                        minPrice,
                        maxPrice,
                        people,
                        sortPrice
                );


        // -------------------------------------------------
        // GỬI DỮ LIỆU SANG JSP
        // -------------------------------------------------

        request.setAttribute(
                "list",
                list
        );


        request.setAttribute(
                "keyword",
                keyword
        );


        request.setAttribute(
                "minPrice",
                minPrice
        );


        request.setAttribute(
                "maxPrice",
                maxPrice
        );


        request.setAttribute(
                "people",
                people
        );


        request.setAttribute(
                "sortPrice",
                sortPrice
        );


        // -------------------------------------------------
        // FORWARD
        // -------------------------------------------------

        request.getRequestDispatcher(
                "/views/room/search.jsp"
        ).forward(request, response);
    }
}