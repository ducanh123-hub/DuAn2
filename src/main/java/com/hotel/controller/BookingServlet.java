package com.hotel.controller;

import com.hotel.service.BookingService;
import com.hotel.dao.RoomDAO;
import com.hotel.model.Booking;
import com.hotel.model.Room;
import com.hotel.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.UUID;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            showBookingPage(request, response);
            return;
        }

        switch (action) {

            case "history":
                bookingHistory(request, response);
                break;

            default:
                showBookingPage(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        saveBooking(request, response);

    }

    private void showBookingPage(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {

        int roomId = Integer.parseInt(request.getParameter("roomId"));

        Room room = roomDAO.getById(roomId);

        request.setAttribute("room", room);

        request.getRequestDispatcher("/views/booking/booking.jsp")
                .forward(request, response);

    }

    private void bookingHistory(HttpServletRequest request,
                                HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/booking/history.jsp")
                .forward(request, response);

    }

    private void saveBooking(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String roomIdStr = request.getParameter("roomId");

        if (roomIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        int roomId = Integer.parseInt(roomIdStr);

        Date checkIn = Date.valueOf(request.getParameter("checkIn"));

        Date checkOut = Date.valueOf(request.getParameter("checkOut"));

        BigDecimal total = new BigDecimal(request.getParameter("total"));

        Booking booking = new Booking();

        booking.setUserID(user.getUserID());
        booking.setBookingCode(UUID.randomUUID().toString().substring(0,8));
        booking.setCheckInDate(checkIn);
        booking.setCheckOutDate(checkOut);
        booking.setTotalAmount(total);
        booking.setRoomID(roomId);

        booking.setVoucherID(null);

        booking.setAdults(2);

        booking.setChildren(0);

        booking.setRoomPrice(total);

        booking.setServicePrice(BigDecimal.ZERO);

        booking.setDiscountAmount(BigDecimal.ZERO);

        booking.setTotalAmount(total);

        booking.setBookingStatus("Pending");

        booking.setPaymentStatus("Unpaid");

        booking.setNote("");

        boolean result = bookingService.addBooking(booking);

        if (result) {

            response.sendRedirect(request.getContextPath() + "/booking?action=history");

        } else {

            request.setAttribute("error", "Đặt phòng thất bại!");

            request.getRequestDispatcher("/views/booking/booking.jsp")
                    .forward(request, response);

        }

    }

}