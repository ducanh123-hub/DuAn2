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

    private final RoomService roomService =
            new RoomService();

    // =====================================================
    // CẤU HÌNH PHÂN TRANG
    // =====================================================

    private static final int PAGE_SIZE = 6;

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

        String action =
                request.getParameter("action");

        if (action == null
                || action.trim().isEmpty()) {

            action = "list";
        }

        switch (action) {

            case "home":
                home(request, response);
                break;

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

        String action =
                request.getParameter("action");

        if ("insert".equals(action)) {

            insert(request, response);

        } else if ("update".equals(action)) {

            update(request, response);

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/room"
            );
        }
    }

    // =====================================================
    // HOME
    //
    // CHỈ HIỂN THỊ PHÒNG CÒN TRỐNG
    // =====================================================

    private void home(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        int page =
                getPage(request);

        int totalRooms =
                roomService.countAvailableRooms();

        int totalPages =
                calculateTotalPages(
                        totalRooms,
                        PAGE_SIZE
                );

        if (page > totalPages) {
            page = totalPages;
        }

        List<Room> roomList =
                roomService.getAvailableRooms(
                        page,
                        PAGE_SIZE
                );

        request.setAttribute(
                "roomList",
                roomList
        );

        request.setAttribute(
                "currentPage",
                page
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
                "pageSize",
                PAGE_SIZE
        );

        request.getRequestDispatcher(
                "/views/home/home.jsp"
        ).forward(
                request,
                response
        );
    }

    // =====================================================
    // LIST - QUẢN LÝ PHÒNG
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
        ).forward(
                request,
                response
        );
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
        ).forward(
                request,
                response
        );
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

        if (idParam == null
                || idParam.trim().isEmpty()) {

            redirectList(request, response);
            return;
        }

        int id;

        try {

            id = Integer.parseInt(
                    idParam.trim()
            );

        } catch (NumberFormatException e) {

            redirectList(request, response);
            return;
        }

        Room room =
                roomService.getRoomById(id);

        if (room == null) {

            redirectList(request, response);
            return;
        }

        request.setAttribute(
                "room",
                room
        );

        request.getRequestDispatcher(
                "/views/room/update.jsp"
        ).forward(
                request,
                response
        );
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

        if (idParam == null
                || idParam.trim().isEmpty()) {

            redirectList(request, response);
            return;
        }

        int id;

        try {

            id = Integer.parseInt(
                    idParam.trim()
            );

        } catch (NumberFormatException e) {

            redirectList(request, response);
            return;
        }

        Room room =
                roomService.getRoomById(id);

        if (room == null) {

            redirectList(request, response);
            return;
        }

        request.setAttribute(
                "room",
                room
        );

        request.getRequestDispatcher(
                "/views/room/detail.jsp"
        ).forward(
                request,
                response
        );
    }

    // =====================================================
    // INSERT
    // =====================================================

    private void insert(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        try {

            Room room = new Room();

            room.setCategoryID(
                    Integer.parseInt(
                            request.getParameter(
                                    "categoryID"
                            )
                    )
            );

            room.setRoomNumber(
                    request.getParameter(
                            "roomNumber"
                    )
            );

            room.setRoomName(
                    request.getParameter(
                            "roomName"
                    )
            );

            room.setPrice(
                    new BigDecimal(
                            request.getParameter(
                                    "price"
                            )
                    )
            );

            room.setAcreage(
                    new BigDecimal(
                            request.getParameter(
                                    "acreage"
                            )
                    )
            );

            room.setBed(
                    Integer.parseInt(
                            request.getParameter(
                                    "bed"
                            )
                    )
            );

            room.setArea(
                    request.getParameter(
                            "area"
                    )
            );

            room.setDescription(
                    request.getParameter(
                            "description"
                    )
            );

            room.setStatus(
                    request.getParameter(
                            "status"
                    )
            );

            roomService.addRoom(room);

        } catch (Exception e) {

            e.printStackTrace();
        }

        redirectList(request, response);
    }

    // =====================================================
    // UPDATE
    // =====================================================

    private void update(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        try {

            Room room = new Room();

            room.setRoomID(
                    Integer.parseInt(
                            request.getParameter(
                                    "roomID"
                            )
                    )
            );

            room.setCategoryID(
                    Integer.parseInt(
                            request.getParameter(
                                    "categoryID"
                            )
                    )
            );

            room.setRoomNumber(
                    request.getParameter(
                            "roomNumber"
                    )
            );

            room.setRoomName(
                    request.getParameter(
                            "roomName"
                    )
            );

            room.setPrice(
                    new BigDecimal(
                            request.getParameter(
                                    "price"
                            )
                    )
            );

            room.setAcreage(
                    new BigDecimal(
                            request.getParameter(
                                    "acreage"
                            )
                    )
            );

            room.setBed(
                    Integer.parseInt(
                            request.getParameter(
                                    "bed"
                            )
                    )
            );

            room.setArea(
                    request.getParameter(
                            "area"
                    )
            );

            room.setDescription(
                    request.getParameter(
                            "description"
                    )
            );

            room.setStatus(
                    request.getParameter(
                            "status"
                    )
            );

            roomService.updateRoom(room);

        } catch (Exception e) {

            e.printStackTrace();
        }

        redirectList(request, response);
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

        if (idParam == null
                || idParam.trim().isEmpty()) {

            redirectList(request, response);
            return;
        }

        try {

            int id =
                    Integer.parseInt(
                            idParam.trim()
                    );

            roomService.deleteRoom(id);

        } catch (NumberFormatException e) {

            e.printStackTrace();
        }

        redirectList(request, response);
    }

    // =====================================================
    // SEARCH + FILTER + PAGINATION
    // =====================================================

    private void search(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        // =================================================
        // PAGE
        // =================================================

        int page =
                getPage(request);

        // =================================================
        // KEYWORD
        // =================================================

        String keyword =
                request.getParameter(
                        "keyword"
                );

        if (keyword != null) {
            keyword = keyword.trim();
        }

        if (keyword != null
                && keyword.isEmpty()) {

            keyword = null;
        }

        // =================================================
        // MIN PRICE
        // =================================================

        BigDecimal minPrice =
                parseBigDecimal(
                        request.getParameter(
                                "minPrice"
                        )
                );

        // =================================================
        // MAX PRICE
        // =================================================

        BigDecimal maxPrice =
                parseBigDecimal(
                        request.getParameter(
                                "maxPrice"
                        )
                );

        // =================================================
        // PEOPLE
        // =================================================

        Integer people =
                parseInteger(
                        request.getParameter(
                                "people"
                        )
                );

        if (people != null
                && people <= 0) {

            people = null;
        }

        // =================================================
        // SORT
        // =================================================

        String sortPrice =
                request.getParameter(
                        "sortPrice"
                );

        if (sortPrice == null) {
            sortPrice = "";
        }

        if (!"asc".equalsIgnoreCase(sortPrice)
                && !"desc".equalsIgnoreCase(sortPrice)) {

            sortPrice = "";
        }

        // =================================================
        // ĐẢO GIÁ NẾU NHẬP NGƯỢC
        // =================================================

        if (minPrice != null
                && maxPrice != null
                && minPrice.compareTo(maxPrice) > 0) {

            BigDecimal temp =
                    minPrice;

            minPrice =
                    maxPrice;

            maxPrice =
                    temp;
        }

        // =================================================
        // COUNT
        // =================================================

        int totalRooms =
                roomService.countSearchRooms(
                        keyword,
                        minPrice,
                        maxPrice,
                        people
                );

        // =================================================
        // TOTAL PAGES
        // =================================================

        int totalPages =
                calculateTotalPages(
                        totalRooms,
                        PAGE_SIZE
                );

        if (page > totalPages) {
            page = totalPages;
        }

        // =================================================
        // SEARCH DATABASE
        // =================================================

        List<Room> list =
                roomService.searchRooms(
                        keyword,
                        minPrice,
                        maxPrice,
                        people,
                        sortPrice,
                        page,
                        PAGE_SIZE
                );

        // =================================================
        // SEND JSP
        // =================================================

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

        request.setAttribute(
                "currentPage",
                page
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
                "pageSize",
                PAGE_SIZE
        );

        request.getRequestDispatcher(
                "/views/room/search.jsp"
        ).forward(
                request,
                response
        );
    }

    // =====================================================
    // GET PAGE
    // =====================================================

    private int getPage(
            HttpServletRequest request
    ) {

        String pageParam =
                request.getParameter(
                        "page"
                );

        if (pageParam == null
                || pageParam.trim().isEmpty()) {

            return 1;
        }

        try {

            int page =
                    Integer.parseInt(
                            pageParam.trim()
                    );

            return Math.max(page, 1);

        } catch (NumberFormatException e) {

            return 1;
        }
    }

    // =====================================================
    // CALCULATE TOTAL PAGES
    // =====================================================

    private int calculateTotalPages(
            int totalRooms,
            int pageSize
    ) {

        if (totalRooms <= 0) {
            return 1;
        }

        return (int) Math.ceil(
                (double) totalRooms
                        / pageSize
        );
    }

    // =====================================================
    // PARSE BIG DECIMAL
    // =====================================================

    private BigDecimal parseBigDecimal(
            String value
    ) {

        if (value == null
                || value.trim().isEmpty()) {

            return null;
        }

        try {

            return new BigDecimal(
                    value.trim()
            );

        } catch (NumberFormatException e) {

            return null;
        }
    }

    // =====================================================
    // PARSE INTEGER
    // =====================================================

    private Integer parseInteger(
            String value
    ) {

        if (value == null
                || value.trim().isEmpty()) {

            return null;
        }

        try {

            return Integer.parseInt(
                    value.trim()
            );

        } catch (NumberFormatException e) {

            return null;
        }
    }

    // =====================================================
    // REDIRECT LIST
    // =====================================================

    private void redirectList(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        response.sendRedirect(
                request.getContextPath()
                        + "/room"
        );
    }
}