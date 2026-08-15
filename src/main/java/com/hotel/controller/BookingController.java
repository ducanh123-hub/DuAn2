package com.hotel.controller;

import com.hotel.dao.RoomDAO;
import com.hotel.dao.UserDAO;
import com.hotel.model.Booking;
import com.hotel.model.Room;
import com.hotel.model.User;
import com.hotel.model.Voucher;
import com.hotel.service.BookingService;
import com.hotel.service.SystemLogService;
import com.hotel.service.VoucherService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.UUID;

@WebServlet("/booking")
public class BookingController extends HttpServlet {

    private final BookingService   bookingService = new BookingService();
    private final VoucherService   voucherService = new VoucherService();
    private final RoomDAO          roomDAO        = new RoomDAO();
    private final UserDAO          userDAO        = new UserDAO();
    private final SystemLogService logService     = new SystemLogService();

    // ================================================================
    // GET
    // ================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "history"       -> bookingHistory(request, response);
            case "manage"        -> bookingManage(request, response);
            case "admin-detail"  -> bookingAdminDetail(request, response);
            case "update-status" -> bookingUpdateStatus(request, response);
            case "checkin"       -> showCheckin(request, response);
            case "checkout"      -> showCheckout(request, response);
            case "invoice"       -> showInvoice(request, response);
            case "success"       -> showBookingSuccess(request, response);
            default              -> showBookingPage(request, response);
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
    // LƯU ĐẶT PHÒNG
    // ================================================================
    private void saveBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── 1. Kiểm tra đăng nhập ─────────────────────────────────
        User user = getLoginUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ── 2. Lấy & validate roomId ──────────────────────────────
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

        // ── 3. Validate ngày ──────────────────────────────────────
        String checkInStr  = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");

        if (checkInStr == null || checkInStr.isBlank()
                || checkOutStr == null || checkOutStr.isBlank()) {
            setErrorAndForward(request, response, room,
                    "Vui lòng chọn ngày nhận phòng và ngày trả phòng!");
            return;
        }

        Date checkIn, checkOut;
        try {
            checkIn  = Date.valueOf(checkInStr);
            checkOut = Date.valueOf(checkOutStr);
        } catch (IllegalArgumentException e) {
            setErrorAndForward(request, response, room,
                    "Ngày nhận hoặc ngày trả phòng không hợp lệ!");
            return;
        }

        if (!checkOut.after(checkIn)) {
            setErrorAndForward(request, response, room,
                    "Ngày trả phòng phải sau ngày nhận phòng ít nhất 1 ngày!");
            return;
        }

        // ── 4. Tính số đêm & tổng tiền gốc (server tự tính) ──────
        long nights = ChronoUnit.DAYS.between(
                checkIn.toLocalDate(), checkOut.toLocalDate());

        if (nights <= 0) {
            setErrorAndForward(request, response, room,
                    "Số đêm lưu trú không hợp lệ!");
            return;
        }

        BigDecimal roomPrice = room.getPrice();
        if (roomPrice == null || roomPrice.compareTo(BigDecimal.ZERO) <= 0) {
            setErrorAndForward(request, response, room, "Giá phòng không hợp lệ!");
            return;
        }

        // totalAmount = giá phòng × số đêm (CHƯA giảm giá)
        BigDecimal totalAmount = roomPrice.multiply(BigDecimal.valueOf(nights));

        // ── 5. XỬ LÝ VOUCHER ──────────────────────────────────────
        String     voucherCode    = request.getParameter("voucherCode");
        Integer    voucherID      = null;
        BigDecimal discountAmount = BigDecimal.ZERO;
        BigDecimal finalAmount    = totalAmount;

        if (voucherCode != null && !voucherCode.isBlank()) {

            Voucher voucher = voucherService
                    .getVoucherByCode(voucherCode.trim().toUpperCase());

            // 5a. Voucher không tồn tại hoặc không active
            if (voucher == null || !"Active".equalsIgnoreCase(voucher.getStatus())) {
                request.setAttribute("voucherCode", voucherCode);
                setErrorAndForward(request, response, room,
                        "Mã voucher không hợp lệ hoặc đã bị vô hiệu hóa!");
                return;
            }

            // 5b. Kiểm tra ngày hiệu lực
            Date today = new Date(System.currentTimeMillis());
            if (today.before(voucher.getStartDate()) || today.after(voucher.getEndDate())) {
                request.setAttribute("voucherCode", voucherCode);
                setErrorAndForward(request, response, room,
                        "Mã voucher chưa hoặc đã hết hạn sử dụng!");
                return;
            }

            // 5c. Kiểm tra giới hạn lượt dùng
            if (voucher.getUsageLimit() != null
                    && voucher.getUsedCount() >= voucher.getUsageLimit()) {
                request.setAttribute("voucherCode", voucherCode);
                setErrorAndForward(request, response, room,
                        "Mã voucher đã hết lượt sử dụng!");
                return;
            }

            // 5d. Kiểm tra giá trị đơn tối thiểu
            if (voucher.getMinOrderAmount() != null
                    && totalAmount.compareTo(voucher.getMinOrderAmount()) < 0) {
                String minStr = String.format("%,.0f VNĐ", voucher.getMinOrderAmount());
                request.setAttribute("voucherCode", voucherCode);
                setErrorAndForward(request, response, room,
                        "Đơn hàng phải từ " + minStr + " mới được dùng voucher này!");
                return;
            }

            // 5e. Tính tiền giảm
            discountAmount = voucherService.calculateDiscount(voucher, totalAmount);
            finalAmount    = totalAmount.subtract(discountAmount);
            voucherID      = voucher.getPromotionID();
        }

        // ── 6. Số người lớn & trẻ em ──────────────────────────────
        int adults = 1;
        try {
            String s = request.getParameter("adults");
            if (s != null && !s.isBlank()) adults = Integer.parseInt(s);
        } catch (NumberFormatException ignored) {}
        if (adults < 1) adults = 1;

        int children = 0;
        try {
            String s = request.getParameter("children");
            if (s != null && !s.isBlank()) children = Integer.parseInt(s);
        } catch (NumberFormatException ignored) {}
        if (children < 0) children = 0;

        // ── 7. Ghi chú ────────────────────────────────────────────
        String note = request.getParameter("note");
        if (note == null) note = "";

        String isBookingForOthers = request.getParameter("isBookingForOthers");
        if ("on".equals(isBookingForOthers) || "true".equals(isBookingForOthers)) {
            String guestName  = request.getParameter("guestName");
            String guestPhone = request.getParameter("guestPhone");
            String guestEmail = request.getParameter("guestEmail");
            if (guestName  == null) guestName  = "";
            if (guestPhone == null) guestPhone = "";
            if (guestEmail == null) guestEmail = "";

            String guestInfo = "[Đặt hộ] Khách: " + guestName
                    + " | SĐT: " + guestPhone + " | Email: " + guestEmail;
            note = note.isBlank() ? guestInfo : guestInfo + "\nGhi chú: " + note;
        }

        // ── 8. Kiểm tra phòng còn trống ───────────────────────────
        if (!bookingService.isRoomAvailable(roomId, checkIn, checkOut)) {
            setErrorAndForward(request, response, room,
                    "Phòng đã được đặt từ " + checkIn + " đến " + checkOut
                            + "! Vui lòng chọn thời gian khác.");
            return;
        }

        // ── 9. Tạo Booking object ──────────────────────────────────
        Booking booking = new Booking();
        booking.setUserID(user.getUserID());
        booking.setBookingCode(
                UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        booking.setCheckInDate(checkIn);
        booking.setCheckOutDate(checkOut);
        booking.setGuestCount(adults + children);
        booking.setVoucherID(voucherID);           // null nếu không dùng voucher
        booking.setTotalAmount(totalAmount);        // tổng TRƯỚC giảm giá
        booking.setDiscountAmount(discountAmount);  // tiền được giảm
        booking.setFinalAmount(finalAmount);        // tổng SAU giảm giá
        booking.setStatus("Chờ xác nhận");
        booking.setNote(note);
        booking.setRoomID(roomId);
        booking.setRoomPrice(roomPrice);

        // ── 10. INSERT vào database ────────────────────────────────
        boolean result = bookingService.addBooking(booking);

        if (result) {
            // Tăng usedCount của voucher (chỉ sau khi booking thành công)
            if (voucherID != null) {
                voucherService.increaseUsedCount(voucherID);
            }
            response.sendRedirect(request.getContextPath()
                    + "/booking?action=success&bookingCode=" + booking.getBookingCode());
            return;
        }

        // ── 11. Insert thất bại ────────────────────────────────────
        setErrorAndForward(request, response, room,
                "Đặt phòng thất bại! Vui lòng thử lại.");
    }

    // ================================================================
    // LỊCH SỬ ĐẶT PHÒNG
    // ================================================================
    private void bookingHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = getLoginUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Booking> list = bookingService.getBookingsByUserId(user.getUserID());
        request.setAttribute("bookingList", list);
        request.getRequestDispatcher("/views/booking/history.jsp")
                .forward(request, response);
    }

    // ================================================================
    // QUẢN LÝ ĐẶT PHÒNG (Admin/Nhân viên)
    // ================================================================
    private void bookingManage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = getLoginUser(request);
        if (currentUser == null
                || (currentUser.getRoleID() != 1 && currentUser.getRoleID() != 2)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Bạn không có quyền truy cập trang này!");
            return;
        }

        List<Booking> list = bookingService.getAllBookings();
        request.setAttribute("bookingList", list);
        request.setAttribute("roomList", roomDAO.getAll());
        request.setAttribute("userList", userDAO.getAll());
        request.getRequestDispatcher("/views/employee/bookingManager.jsp")
                .forward(request, response);
    }

    // ================================================================
    // CHECK-IN – hiển thị trang
    // ================================================================
    private void showCheckin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId;
        try {
            bookingId = Integer.parseInt(request.getParameter("id"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        Booking booking = bookingService.getBookingById(bookingId);
        if (booking == null) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        request.setAttribute("booking",  booking);
        request.setAttribute("room",     roomDAO.getById(booking.getRoomID()));
        request.setAttribute("customer", userDAO.getById(booking.getUserID()));
        request.getRequestDispatcher("/views/employee/checkin.jsp")
                .forward(request, response);
    }

    // ================================================================
    // CHECK-IN – xác nhận
    // ================================================================
    private void confirmCheckin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int bookingId;
        try {
            bookingId = Integer.parseInt(request.getParameter("bookingId"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        Booking booking = bookingService.getBookingById(bookingId);
        if (booking != null) {
            booking.setStatus("Đã xác nhận");
            bookingService.updateBooking(booking);

            Room room = roomDAO.getById(booking.getRoomID());
            if (room != null) {
                room.setStatus("Đang sử dụng");
                roomDAO.update(room);
            }
        }

        response.sendRedirect(request.getContextPath() + "/booking?action=manage");
    }

    // ================================================================
    // CHECK-OUT – hiển thị trang
    // ================================================================
    private void showCheckout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId;
        try {
            bookingId = Integer.parseInt(request.getParameter("id"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        Booking booking = bookingService.getBookingById(bookingId);
        if (booking == null) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        request.setAttribute("booking",  booking);
        request.setAttribute("room",     roomDAO.getById(booking.getRoomID()));
        request.setAttribute("customer", userDAO.getById(booking.getUserID()));
        request.getRequestDispatcher("/views/employee/checkout.jsp")
                .forward(request, response);
    }

    // ================================================================
    // CHECK-OUT – xác nhận
    // ================================================================
    private void confirmCheckout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int bookingId;
        try {
            String s = request.getParameter("bookingId");
            if (s == null || s.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/booking?action=manage");
                return;
            }
            bookingId = Integer.parseInt(s.trim());
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        Booking booking = bookingService.getBookingById(bookingId);
        if (booking == null) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        if (!"Đã xác nhận".equals(booking.getStatus())) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        String note = request.getParameter("note");
        if (note == null) note = "";

        // Dùng finalAmount đã lưu trong DB, không lấy từ input client
        BigDecimal finalAmount = booking.getFinalAmount() != null
                ? booking.getFinalAmount() : booking.getTotalAmount();
        if (finalAmount == null) finalAmount = BigDecimal.ZERO;

        booking.setStatus("Đã trả phòng");
        booking.setFinalAmount(finalAmount);
        booking.setTotalAmount(finalAmount);
        booking.setNote(note);

        boolean result = bookingService.updateBooking(booking);

        if (result) {
            Room room = roomDAO.getById(booking.getRoomID());
            if (room != null) {
                room.setStatus("Còn trống");
                roomDAO.update(room);
            }
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        response.sendRedirect(
                request.getContextPath() + "/booking?action=manage&error=checkout");
    }

    // ================================================================
    // HÓA ĐƠN
    // ================================================================
    private void showInvoice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId;
        try {
            bookingId = Integer.parseInt(request.getParameter("id"));
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        Booking booking = bookingService.getBookingById(bookingId);
        if (booking == null) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        request.setAttribute("booking",  booking);
        request.setAttribute("room",     roomDAO.getById(booking.getRoomID()));
        request.setAttribute("customer", userDAO.getById(booking.getUserID()));

        // Tính tổng tiền phòng chưa giảm để hiển thị hóa đơn
        if (booking.getRoomPrice() != null
                && booking.getCheckInDate() != null
                && booking.getCheckOutDate() != null) {

            long nights = ChronoUnit.DAYS.between(
                    booking.getCheckInDate().toLocalDate(),
                    booking.getCheckOutDate().toLocalDate());

            BigDecimal roomTotal = booking.getRoomPrice()
                    .multiply(BigDecimal.valueOf(nights));
            request.setAttribute("roomTotal", roomTotal);
        }

        request.getRequestDispatcher("/views/booking/invoice.jsp")
                .forward(request, response);
    }

    // ================================================================
    // TRANG ĐẶT PHÒNG THÀNH CÔNG
    // ================================================================
    private void showBookingSuccess(HttpServletRequest request, HttpServletResponse response)
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
        if (booking == null || booking.getUserID() != user.getUserID()) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        request.setAttribute("booking", booking);
        request.getRequestDispatcher("/views/booking/booking-success.jsp")
                .forward(request, response);
    }

    // ================================================================
    // CHI TIẾT ĐƠN – ADMIN
    // ================================================================
    private void bookingAdminDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!checkAdminRole(request, response)) return;

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
            return;
        }

        try {
            int bookingId = Integer.parseInt(idStr);
            Booking booking = bookingService.getBookingById(bookingId);
            if (booking == null) {
                response.sendRedirect(request.getContextPath() + "/booking?action=manage");
                return;
            }
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/views/admin/booking/detail.jsp")
                    .forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/booking?action=manage");
        }
    }

    // ================================================================
    // CẬP NHẬT TRẠNG THÁI – ADMIN
    // ================================================================
    private void bookingUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!checkAdminRole(request, response)) return;

        try {
            int    bookingId    = Integer.parseInt(request.getParameter("id"));
            String status       = request.getParameter("status");
            String cancelReason = request.getParameter("cancelReason");

            Booking booking = bookingService.getBookingById(bookingId);
            if (booking != null && status != null && !status.isBlank()) {
                booking.setStatus(status);
                if ("Đã hủy".equals(status) && cancelReason != null) {
                    booking.setCancelReason(cancelReason);
                    booking.setCancelDate(
                            new java.sql.Timestamp(System.currentTimeMillis()));
                }
                bookingService.updateBooking(booking);
                logService.logFromRequest(request, "UPDATE",
                        "Cập nhật trạng thái đơn #" + booking.getBookingCode()
                                + " -> " + status);
                request.getSession().setAttribute("successMsg",
                        "Cập nhật trạng thái thành công!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Cập nhật thất bại!");
        }

        response.sendRedirect(request.getContextPath() + "/booking?action=manage");
    }

    // ================================================================
    // PRIVATE HELPERS
    // ================================================================

    /** Trả về user đang login, hoặc null nếu chưa đăng nhập */
    private User getLoginUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute("user");
    }

    /** Kiểm tra quyền Admin (RoleID = 1) */
    private boolean checkAdminRole(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        User u = (User) session.getAttribute("user");
        if (u.getRoleID() != 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Không có quyền!");
            return false;
        }
        return true;
    }

    /**
     * Gán error và forward về booking.jsp,
     * giữ lại voucherCode (nếu đã có) để hiển thị lại trên form.
     */
    private void setErrorAndForward(HttpServletRequest request,
                                    HttpServletResponse response,
                                    Room room,
                                    String errorMsg)
            throws ServletException, IOException {

        request.setAttribute("error", errorMsg);
        request.setAttribute("room", room);
        request.getRequestDispatcher("/views/booking/booking.jsp")
                .forward(request, response);
    }
}