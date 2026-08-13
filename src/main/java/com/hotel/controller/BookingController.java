package com.hotel.controller;

import com.hotel.service.BookingService;
import com.hotel.dao.RoomDAO;
import com.hotel.dao.UserDAO;
import com.hotel.model.Booking;
import com.hotel.model.Room;
import com.hotel.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.UUID;

@WebServlet("/booking")
public class BookingController extends HttpServlet {

    private final BookingService bookingService = new BookingService();
    private final RoomDAO roomDAO = new RoomDAO();
    private final UserDAO userDAO = new UserDAO();

    // ================================================================
    // GET
    // ================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            showBookingPage(request, response);
            return;
        }

        switch (action) {
            case "history" -> bookingHistory(request, response);
            case "manage" -> bookingManage(request, response);
            case "checkin" -> showCheckin(request, response);
            case "checkout" -> showCheckout(request, response);
            case "invoice" -> showInvoice(request, response);
            case "success" -> showBookingSuccess(request, response);
            default -> showBookingPage(request, response);
        }
    }

    // ================================================================
    // POST
    // ================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

    // ================================================================
    // HIỂN THỊ FORM ĐẶT PHÒNG
    // ================================================================
    private void showBookingPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = getLoginUser(request);

        // Chưa đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String roomIdStr = request.getParameter("roomId");

        if (roomIdStr == null || roomIdStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        int roomId;

        try {
            roomId = Integer.parseInt(roomIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        Room room = roomDAO.getById(roomId);

        if (room == null) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        request.setAttribute("room", room);

        request.getRequestDispatcher("/views/booking/booking.jsp")
                .forward(request, response);
    }

    // ================================================================
    // LỊCH SỬ ĐẶT PHÒNG - CUSTOMER
    // ================================================================
    private void bookingHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = getLoginUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Booking> list =
                bookingService.getBookingsByUserId(user.getUserID());

        request.setAttribute("bookingList", list);

        request.getRequestDispatcher("/views/booking/history.jsp")
                .forward(request, response);
    }

    // ================================================================
    // LƯU ĐẶT PHÒNG
    // ================================================================
    private void saveBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ------------------------------------------------------------
        // 1. Kiểm tra đăng nhập
        // ------------------------------------------------------------
        User user = getLoginUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ------------------------------------------------------------
        // 2. Lấy dữ liệu từ form
        // ------------------------------------------------------------
        String roomIdStr = request.getParameter("roomId");
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");

        // ------------------------------------------------------------
        // 3. Kiểm tra RoomID
        // ------------------------------------------------------------
        if (roomIdStr == null || roomIdStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        int roomId;

        try {
            roomId = Integer.parseInt(roomIdStr);
        } catch (NumberFormatException e) {

            request.setAttribute("error",
                    "Mã phòng không hợp lệ!");

            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        // ------------------------------------------------------------
        // 4. Lấy thông tin phòng từ DATABASE
        // ------------------------------------------------------------
        Room room = roomDAO.getById(roomId);

        if (room == null) {

            request.setAttribute("error",
                    "Không tìm thấy phòng!");

            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        // ------------------------------------------------------------
        // 5. Kiểm tra ngày
        // ------------------------------------------------------------
        if (checkInStr == null || checkInStr.isBlank()
                || checkOutStr == null || checkOutStr.isBlank()) {

            request.setAttribute("error",
                    "Vui lòng chọn ngày nhận phòng và ngày trả phòng!");

            request.setAttribute("room", room);

            request.getRequestDispatcher("/views/booking/booking.jsp")
                    .forward(request, response);

            return;
        }

        Date checkIn;
        Date checkOut;

        try {

            checkIn = Date.valueOf(checkInStr);
            checkOut = Date.valueOf(checkOutStr);

        } catch (IllegalArgumentException e) {

            request.setAttribute("error",
                    "Ngày nhận hoặc ngày trả phòng không hợp lệ!");

            request.setAttribute("room", room);

            request.getRequestDispatcher("/views/booking/booking.jsp")
                    .forward(request, response);

            return;
        }

        // ------------------------------------------------------------
        // 6. Ngày trả phải sau ngày nhận
        // ------------------------------------------------------------
        if (!checkOut.after(checkIn)) {

            request.setAttribute("error",
                    "Ngày trả phòng phải sau ngày nhận phòng ít nhất 1 ngày!");

            request.setAttribute("room", room);

            request.getRequestDispatcher("/views/booking/booking.jsp")
                    .forward(request, response);

            return;
        }

        // ------------------------------------------------------------
        // 7. Tính số đêm
        // ------------------------------------------------------------
        long numberOfNights = ChronoUnit.DAYS.between(
                checkIn.toLocalDate(),
                checkOut.toLocalDate()
        );

        if (numberOfNights <= 0) {

            request.setAttribute("error",
                    "Số đêm lưu trú không hợp lệ!");

            request.setAttribute("room", room);

            request.getRequestDispatcher("/views/booking/booking.jsp")
                    .forward(request, response);

            return;
        }

        // ------------------------------------------------------------
        // 8. Lấy giá phòng từ DATABASE
        // ------------------------------------------------------------
        BigDecimal roomPrice = room.getPrice();

        if (roomPrice == null
                || roomPrice.compareTo(BigDecimal.ZERO) <= 0) {

            request.setAttribute("error",
                    "Giá phòng không hợp lệ!");

            request.setAttribute("room", room);

            request.getRequestDispatcher("/views/booking/booking.jsp")
                    .forward(request, response);

            return;
        }

        // ------------------------------------------------------------
        // 9. TỰ TÍNH TỔNG TIỀN TRÊN SERVER
        //
        // Không lấy total từ input của người dùng nữa.
        // ------------------------------------------------------------
        BigDecimal total = roomPrice.multiply(
                BigDecimal.valueOf(numberOfNights)
        );

        // ------------------------------------------------------------
        // 10. Số người lớn
        // ------------------------------------------------------------
        int adults = 1;

        try {

            String adultsStr = request.getParameter("adults");

            if (adultsStr != null && !adultsStr.isBlank()) {
                adults = Integer.parseInt(adultsStr);
            }

        } catch (NumberFormatException ignored) {
            adults = 1;
        }

        if (adults < 1) {
            adults = 1;
        }

        // ------------------------------------------------------------
        // 11. Số trẻ em
        // ------------------------------------------------------------
        int children = 0;

        try {

            String childrenStr = request.getParameter("children");

            if (childrenStr != null && !childrenStr.isBlank()) {
                children = Integer.parseInt(childrenStr);
            }

        } catch (NumberFormatException ignored) {
            children = 0;
        }

        if (children < 0) {
            children = 0;
        }

        // ------------------------------------------------------------
        // 12. Ghi chú
        // ------------------------------------------------------------
        String finalNote = request.getParameter("note");

        if (finalNote == null) {
            finalNote = "";
        }

        // ------------------------------------------------------------
        // 13. Đặt phòng hộ
        // ------------------------------------------------------------
        String isBookingForOthers =
                request.getParameter("isBookingForOthers");

        if ("on".equals(isBookingForOthers)
                || "true".equals(isBookingForOthers)) {

            String guestName = request.getParameter("guestName");
            String guestPhone = request.getParameter("guestPhone");
            String guestEmail = request.getParameter("guestEmail");

            if (guestName == null) {
                guestName = "";
            }

            if (guestPhone == null) {
                guestPhone = "";
            }

            if (guestEmail == null) {
                guestEmail = "";
            }

            String guestInfo =
                    "[Đặt hộ] Khách lưu trú: " + guestName
                            + " | SĐT: " + guestPhone
                            + " | Email: " + guestEmail;

            if (finalNote.isBlank()) {
                finalNote = guestInfo;
            } else {
                finalNote = guestInfo
                        + "\nGhi chú: "
                        + finalNote;
            }
        }

        // ------------------------------------------------------------
        // 14. Kiểm tra phòng còn trống
        // ------------------------------------------------------------
        if (!bookingService.isRoomAvailable(
                roomId,
                checkIn,
                checkOut)) {

            request.setAttribute(
                    "error",
                    "Phòng đã được đặt trong khoảng thời gian từ "
                            + checkIn
                            + " đến "
                            + checkOut
                            + "! Vui lòng chọn thời gian khác."
            );

            request.setAttribute("room", room);

            request.getRequestDispatcher(
                    "/views/booking/booking.jsp"
            ).forward(request, response);

            return;
        }

        // ------------------------------------------------------------
        // 15. Tạo Booking
        // ------------------------------------------------------------
        Booking booking = new Booking();

        booking.setUserID(user.getUserID());

        booking.setBookingCode(
                UUID.randomUUID()
                        .toString()
                        .substring(0, 8)
                        .toUpperCase()
        );

        booking.setCheckInDate(checkIn);
        booking.setCheckOutDate(checkOut);

        booking.setGuestCount(adults + children);

        booking.setVoucherID(null);

        booking.setTotalAmount(total);

        booking.setDiscountAmount(
                BigDecimal.ZERO
        );

        booking.setFinalAmount(total);

        booking.setStatus("Chờ xác nhận");

        booking.setNote(finalNote);

        // ------------------------------------------------------------
        // Field phụ dùng để INSERT Booking_Detail
        // ------------------------------------------------------------
        booking.setRoomID(roomId);

        booking.setRoomPrice(roomPrice);

        // ------------------------------------------------------------
        // 16. INSERT DATABASE
        // ------------------------------------------------------------
        boolean result = bookingService.addBooking(booking);

        // ------------------------------------------------------------
        // 17. Đặt phòng thành công
        // ------------------------------------------------------------
        if (result) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/booking?action=success"
                            + "&bookingCode="
                            + booking.getBookingCode()
            );

            return;
        }

        // ------------------------------------------------------------
        // 18. Đặt phòng thất bại
        // ------------------------------------------------------------
        request.setAttribute(
                "error",
                "Đặt phòng thất bại! Vui lòng thử lại."
        );

        request.setAttribute("room", room);

        request.getRequestDispatcher(
                "/views/booking/booking.jsp"
        ).forward(request, response);
    }

    // ================================================================
    // QUẢN LÝ ĐẶT PHÒNG
    // ================================================================
    private void bookingManage(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = getLoginUser(request);

        if (currentUser == null
                || (currentUser.getRoleID() != 1
                && currentUser.getRoleID() != 2)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Bạn không có quyền truy cập trang này!"
            );

            return;
        }

        List<Booking> list =
                bookingService.getAllBookings();

        request.setAttribute(
                "bookingList",
                list
        );

        request.setAttribute(
                "roomList",
                roomDAO.getAll()
        );

        request.setAttribute(
                "userList",
                userDAO.getAll()
        );

        request.getRequestDispatcher(
                "/views/employee/bookingManager.jsp"
        ).forward(request, response);
    }

    // ================================================================
    // CHECK-IN
    // ================================================================
    private void showCheckin(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId;

        try {

            bookingId = Integer.parseInt(
                    request.getParameter("id")
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/booking?action=manage"
            );

            return;
        }

        Booking booking =
                bookingService.getBookingById(bookingId);

        if (booking == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/booking?action=manage"
            );

            return;
        }

        Room room =
                roomDAO.getById(booking.getRoomID());

        User customer =
                userDAO.getById(booking.getUserID());

        request.setAttribute(
                "booking",
                booking
        );

        request.setAttribute(
                "room",
                room
        );

        request.setAttribute(
                "customer",
                customer
        );

        request.getRequestDispatcher(
                "/views/employee/checkin.jsp"
        ).forward(request, response);
    }

    // ================================================================
    // XÁC NHẬN CHECK-IN
    // ================================================================
    private void confirmCheckin(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        int bookingId;

        try {

            bookingId = Integer.parseInt(
                    request.getParameter("bookingId")
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/booking?action=manage"
            );

            return;
        }

        Booking booking =
                bookingService.getBookingById(bookingId);

        if (booking != null) {

            booking.setStatus("Đã xác nhận");

            bookingService.updateBooking(booking);

            Room room =
                    roomDAO.getById(booking.getRoomID());

            if (room != null) {

                room.setStatus("Đang sử dụng");

                roomDAO.update(room);
            }
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/booking?action=manage"
        );
    }

    // ================================================================
    // CHECK-OUT
    // ================================================================
    private void showCheckout(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId;

        try {

            bookingId = Integer.parseInt(
                    request.getParameter("id")
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/booking?action=manage"
            );

            return;
        }

        Booking booking =
                bookingService.getBookingById(bookingId);

        if (booking == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/booking?action=manage"
            );

            return;
        }

        Room room =
                roomDAO.getById(booking.getRoomID());

        User customer =
                userDAO.getById(booking.getUserID());

        request.setAttribute(
                "booking",
                booking
        );

        request.setAttribute(
                "room",
                room
        );

        request.setAttribute(
                "customer",
                customer
        );

        request.getRequestDispatcher(
                "/views/employee/checkout.jsp"
        ).forward(request, response);
    }

    // ================================================================
    // XÁC NHẬN CHECK-OUT
    // ================================================================
    private void confirmCheckout(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        int bookingId;

        try {

            bookingId = Integer.parseInt(
                    request.getParameter("bookingId")
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/booking?action=manage"
            );

            return;
        }

        String note =
                request.getParameter("note");

        String totalAmountStr =
                request.getParameter("totalAmount");

        BigDecimal totalAmount;

        try {

            if (totalAmountStr == null
                    || totalAmountStr.isBlank()) {

                throw new NumberFormatException();
            }

            totalAmount =
                    new BigDecimal(
                            totalAmountStr.trim()
                    );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/booking?action=manage"
            );

            return;
        }

        Booking booking =
                bookingService.getBookingById(bookingId);

        if (booking != null) {

            booking.setStatus("Đã trả phòng");

            booking.setFinalAmount(totalAmount);

            booking.setTotalAmount(totalAmount);

            booking.setNote(note);

            bookingService.updateBooking(booking);

            // Phòng trở lại trạng thái còn trống
            Room room =
                    roomDAO.getById(
                            booking.getRoomID()
                    );

            if (room != null) {

                room.setStatus("Còn trống");

                roomDAO.update(room);
            }
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/booking?action=manage"
        );
    }

    // ================================================================
    // HÓA ĐƠN
    // ================================================================
    private void showInvoice(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId;

        try {

            bookingId = Integer.parseInt(
                    request.getParameter("id")
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/booking?action=manage"
            );

            return;
        }

        Booking booking =
                bookingService.getBookingById(bookingId);

        if (booking == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/booking?action=manage"
            );

            return;
        }

        Room room =
                roomDAO.getById(booking.getRoomID());

        User customer =
                userDAO.getById(booking.getUserID());

        request.setAttribute(
                "booking",
                booking
        );

        request.setAttribute(
                "room",
                room
        );

        request.setAttribute(
                "customer",
                customer
        );

        request.getRequestDispatcher(
                "/views/booking/invoice.jsp"
        ).forward(request, response);
    }

    // ================================================================
    // LẤY USER ĐANG LOGIN
    // ================================================================
    private User getLoginUser(
            HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            return null;
        }

        return (User) session.getAttribute("user");
    }
    private void showBookingSuccess(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        User user = getLoginUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String bookingCode = request.getParameter("bookingCode");

        if (bookingCode == null || bookingCode.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        Booking booking = bookingService.getByBookingCode(bookingCode.trim());

        if (booking == null) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        if (booking.getUserID() != user.getUserID()) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        request.setAttribute("booking", booking);

        request.getRequestDispatcher(
                "/views/booking/booking-success.jsp"
        ).forward(request, response);
    }
}