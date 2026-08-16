package com.hotel.controller;

import com.hotel.model.Room;
import com.hotel.model.User;
import com.hotel.service.RoomCategoryService;
import com.hotel.service.RoomFavoriteService;
import com.hotel.service.RoomService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/favorite")
public class FavoriteController extends HttpServlet {

    private final RoomFavoriteService favoriteService = new RoomFavoriteService();
    private final RoomService roomService = new RoomService();
    private final RoomCategoryService categoryService = new RoomCategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }

        switch (action) {
            case "add":
                handleAdd(request, response);
                break;
            case "remove":
                handleRemove(request, response);
                break;
            case "toggle":
                handleToggle(request, response);
                break;
            case "list":
            default:
                handleList(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("error", "Vui lòng đăng nhập để sử dụng chức năng phòng yêu thích.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserID();

        List<Room> favoriteRooms = favoriteService.getFavoriteRoomsByUser(userId);
        favoriteService.populateFavoriteCounts(favoriteRooms);
        request.setAttribute("favoriteRooms", favoriteRooms);
        request.setAttribute("categories", categoryService.getAll());

        // Lấy thông báo từ session nếu có
        if (session.getAttribute("successMsg") != null) {
            request.setAttribute("successMsg", session.getAttribute("successMsg"));
            session.removeAttribute("successMsg");
        }
        if (session.getAttribute("errorMsg") != null) {
            request.setAttribute("errorMsg", session.getAttribute("errorMsg"));
            session.removeAttribute("errorMsg");
        }

        request.getRequestDispatcher("/views/customer/favorite.jsp").forward(request, response);
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("error", "Vui lòng đăng nhập để sử dụng chức năng phòng yêu thích.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserID();

        int roomId = parseRoomId(request.getParameter("roomId"));
        if (roomId <= 0 || roomService.getRoomById(roomId) == null) {
            session.setAttribute("errorMsg", "Phòng không hợp lệ hoặc không tồn tại.");
            redirectBack(request, response, "/favorite");
            return;
        }

        boolean success = favoriteService.addFavorite(userId, roomId);
        if (success) {
            session.setAttribute("successMsg", "Đã thêm phòng vào danh sách yêu thích!");
        } else {
            session.setAttribute("errorMsg", "Không thể thêm vào danh sách yêu thích.");
        }

        redirectBack(request, response, "/favorite");
    }

    private void handleRemove(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("error", "Vui lòng đăng nhập để thực hiện thao tác này.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserID();

        int roomId = parseRoomId(request.getParameter("roomId"));
        if (roomId <= 0) {
            session.setAttribute("errorMsg", "Phòng không hợp lệ.");
            redirectBack(request, response, "/favorite");
            return;
        }

        boolean success = favoriteService.removeFavorite(userId, roomId);
        if (success) {
            session.setAttribute("successMsg", "Đã xóa phòng khỏi danh sách yêu thích!");
        } else {
            session.setAttribute("errorMsg", "Không thể xóa phòng khỏi danh sách yêu thích.");
        }

        redirectBack(request, response, "/favorite");
    }

    private void handleToggle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("error", "Vui lòng đăng nhập để thêm/xóa phòng yêu thích.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserID();

        int roomId = parseRoomId(request.getParameter("roomId"));
        if (roomId <= 0 || roomService.getRoomById(roomId) == null) {
            session.setAttribute("errorMsg", "Phòng không hợp lệ.");
            redirectBack(request, response, "/favorite");
            return;
        }

        boolean isFav = favoriteService.isFavorite(userId, roomId);
        if (isFav) {
            favoriteService.removeFavorite(userId, roomId);
            session.setAttribute("successMsg", "Đã xóa phòng khỏi danh sách yêu thích!");
        } else {
            favoriteService.addFavorite(userId, roomId);
            session.setAttribute("successMsg", "Đã thêm phòng vào danh sách yêu thích!");
        }

        redirectBack(request, response, "/favorite");
    }

    private int parseRoomId(String param) {
        if (param == null || param.trim().isEmpty()) {
            return -1;
        }
        try {
            return Integer.parseInt(param.trim());
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response, String defaultPath)
            throws IOException {
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.trim().isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + defaultPath);
        }
    }
}
