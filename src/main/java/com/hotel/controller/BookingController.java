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
import java.util.List;
import java.util.UUID;

@WebServlet("/booking")
public class BookingController extends HttpServlet {

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

            case "manage":
                bookingManage(request, response);
                break;

            case "checkin":
                showCheckin(request, response);
                break;

            case "checkout":
                showCheckout(request, response);
                break;

            case "invoice":
                showInvoice(request, response);
                break;

            default:
                showBookingPage(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("confirmCheckin".equals(action)) {
            confirmCheckin(request, response);
        } else if ("confirmCheckout".equals(action)) {
            confirmCheckout(request, response);
        } else {
            saveBooking(request, response);
        }

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

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Booking> list = bookingService.getBookingsByUserId(user.getUserID());
        request.setAttribute("bookingList", list);

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

        // Kiểm tra xem phòng còn trống trong thời gian được chọn hay không
        if (!bookingService.isRoomAvailable(roomId, checkIn, checkOut)) {
            Room room = roomDAO.getById(roomId);
            request.setAttribute("room", room);
            request.setAttribute("error", "Phòng này đã được đặt hoặc đang sử dụng trong khoảng thời gian từ " + checkIn + " đến " + checkOut + "! Vui lòng chọn thời gian khác.");
            request.getRequestDispatcher("/views/booking/booking.jsp").forward(request, response);
            return;
        }

        BigDecimal total = new BigDecimal(request.getParameter("total"));

        int adults = 1;
        try {
            adults = Integer.parseInt(request.getParameter("adults"));
        } catch (Exception e) {}

        int children = 0;
        try {
            children = Integer.parseInt(request.getParameter("children"));
        } catch (Exception e) {}

        // Xử lý thông tin người đặt hộ nếu có
        String isBookingForOthers = request.getParameter("isBookingForOthers");
        String finalNote = request.getParameter("note");
        if (finalNote == null) {
            finalNote = "";
        }

        if ("on".equals(isBookingForOthers) || "true".equals(isBookingForOthers)) {
            String guestName = request.getParameter("guestName");
            String guestPhone = request.getParameter("guestPhone");
            String guestEmail = request.getParameter("guestEmail");
            
            String guestInfo = "[Đặt hộ] Khách lưu trú: " + guestName + " | SĐT: " + guestPhone + " | Email: " + guestEmail;
            if (finalNote.isEmpty()) {
                finalNote = guestInfo;
            } else {
                finalNote = guestInfo + " \nGhi chú: " + finalNote;
            }
        }

        Booking booking = new Booking();

        booking.setUserID(user.getUserID());
        booking.setBookingCode(UUID.randomUUID().toString().substring(0,8));
        booking.setCheckInDate(checkIn);
        booking.setCheckOutDate(checkOut);
        booking.setTotalAmount(total);
        booking.setRoomID(roomId);

        booking.setVoucherID(null);

        booking.setAdults(adults);

        booking.setChildren(children);

        booking.setRoomPrice(total);

        booking.setServicePrice(BigDecimal.ZERO);

        booking.setDiscountAmount(BigDecimal.ZERO);

        booking.setTotalAmount(total);

        booking.setBookingStatus("Pending");

        booking.setPaymentStatus("Unpaid");

        booking.setNote(finalNote);

        boolean result = bookingService.addBooking(booking);

        if (result) {

            response.sendRedirect(request.getContextPath() + "/booking?action=history");

        } else {

            request.setAttribute("error", "Đặt phòng thất bại!");
            Room room = roomDAO.getById(roomId);
            request.setAttribute("room", room);

            request.getRequestDispatcher("/views/booking/booking.jsp")
                    .forward(request, response);

        }

    }

    private void bookingManage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        if (currentUser == null || (currentUser.getRoleID() != 1 && currentUser.getRoleID() != 2)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
            return;
        }
        List<Booking> list = bookingService.getAllBookings();
        request.setAttribute("bookingList", list);
        request.setAttribute("roomList", roomDAO.getAll());
        request.setAttribute("userList", new com.hotel.dao.UserDAO().getAll());
        request.getRequestDispatcher("/views/employee/bookingManager.jsp").forward(request, response);
    }

    private void showCheckin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        Booking booking = bookingService.getBookingById(bookingId);
        Room room = roomDAO.getById(booking.getRoomID());
        User customer = new com.hotel.dao.UserDAO().getById(booking.getUserID());

        request.setAttribute("booking", booking);
        request.setAttribute("room", room);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/views/employee/checkin.jsp").forward(request, response);
    }

    private void confirmCheckin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        Booking booking = bookingService.getBookingById(bookingId);
        if (booking != null) {
            booking.setBookingStatus("Confirmed");
            bookingService.updateBooking(booking);

            Room room = roomDAO.getById(booking.getRoomID());
            if (room != null) {
                room.setStatus("Occupied");
                roomDAO.update(room);
            }
        }
        response.sendRedirect(request.getContextPath() + "/booking?action=manage");
    }

    private void showCheckout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        Booking booking = bookingService.getBookingById(bookingId);
        Room room = roomDAO.getById(booking.getRoomID());
        User customer = new com.hotel.dao.UserDAO().getById(booking.getUserID());

        request.setAttribute("booking", booking);
        request.setAttribute("room", room);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/views/employee/checkout.jsp").forward(request, response);
    }

    private void confirmCheckout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        BigDecimal servicePrice = new BigDecimal(request.getParameter("servicePrice"));
        BigDecimal totalAmount = new BigDecimal(request.getParameter("totalAmount"));
        String note = request.getParameter("note");

        Booking booking = bookingService.getBookingById(bookingId);
        if (booking != null) {
            booking.setBookingStatus("CheckedOut");
            booking.setPaymentStatus("Paid");
            booking.setServicePrice(servicePrice);
            booking.setTotalAmount(totalAmount);
            booking.setNote(note);
            bookingService.updateBooking(booking);

            Room room = roomDAO.getById(booking.getRoomID());
            if (room != null) {
                room.setStatus("Available");
                roomDAO.update(room);
            }
        }
        response.sendRedirect(request.getContextPath() + "/booking?action=manage");
    }

    private void showInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        Booking booking = bookingService.getBookingById(bookingId);
        Room room = roomDAO.getById(booking.getRoomID());
        User customer = new com.hotel.dao.UserDAO().getById(booking.getUserID());

        request.setAttribute("booking", booking);
        request.setAttribute("room", room);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/views/booking/invoice.jsp").forward(request, response);
    }

}
