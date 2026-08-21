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
            case "cancel"        -> cancelBooking(request, response);
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

        // ── 3. Validate Họ và tên, SĐT, Email ────────────────────
        String fullName = request.getParameter("fullName");
        String phone    = request.getParameter("phone");
        String email    = request.getParameter("email");
        String isBookingForOthers = request.getParameter("isBookingForOthers");
        boolean isOthers = "on".equals(isBookingForOthers) || "true".equals(isBookingForOthers);

        String targetName  = isOthers ? request.getParameter("guestName") : fullName;
        String targetPhone = isOthers ? request.getParameter("guestPhone") : phone;
        String targetEmail = isOthers ? request.getParameter("guestEmail") : email;

        if (targetName == null || targetName.isBlank()) {
            setErrorAndForward(request, response, room, "Họ và tên là phần bắt buộc!");
            return;
        }

        if (targetPhone == null || targetPhone.isBlank()) {
            setErrorAndForward(request, response, room, "Số điện thoại là phần bắt buộc!");
            return;
        }

        if (!targetPhone.matches("^(0|\\+84)[3|5|7|8|9]\\d{8}$")) {
            setErrorAndForward(request, response, room, "Số điện thoại không hợp lệ!");
            return;
        }

        if (!isOthers || (targetEmail != null && !targetEmail.isBlank())) {
            if (targetEmail == null || targetEmail.isBlank()) {
                setErrorAndForward(request, response, room, "Email là phần bắt buộc!");
                return;
            }
            if (!targetEmail.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                setErrorAndForward(request, response, room, "Email không đúng định dạng!");
                return;
            }
        }

        // ── 4. Validate ngày nhận/trả phòng ──────────────────────
        String checkInStr  = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");

        if (checkInStr == null || checkInStr.isBlank()) {
            setErrorAndForward(request, response, room, "Ngày nhận phòng là phần bắt buộc!");
            return;
        }

        if (checkOutStr == null || checkOutStr.isBlank()) {
            setErrorAndForward(request, response, room, "Ngày trả phòng là phần bắt buộc!");
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

        Date today = Date.valueOf(java.time.LocalDate.now());
        if (checkIn.before(today)) {
            setErrorAndForward(request, response, room,
                    "Ngày nhận phòng không được ở quá khứ!");
            return;
        }

        if (!checkOut.after(checkIn)) {
            setErrorAndForward(request, response, room,
                    "Ngày trả phòng phải sau ngày nhận phòng!");
            return;
        }

        // ── 5. Tính số đêm & tổng tiền gốc (server tự tính) ──────
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

        // ── 6. XỬ LÝ VOUCHER ──────────────────────────────────────
        String     voucherCode    = request.getParameter("voucherCode");
        Integer    voucherID      = null;
        BigDecimal discountAmount = BigDecimal.ZERO;
        BigDecimal finalAmount    = totalAmount;

        if (voucherCode != null && !voucherCode.isBlank()) {

            Voucher voucher = voucherService
                    .getVoucherByCode(voucherCode.trim().toUpperCase());

            if (voucher == null || !"Active".equalsIgnoreCase(voucher.getStatus())) {
                request.setAttribute("voucherCode", voucherCode);
                setErrorAndForward(request, response, room,
                        "Mã voucher không hợp lệ hoặc đã bị vô hiệu hóa!");
                return;
            }

            Date nowSql = new Date(System.currentTimeMillis());
            if (nowSql.before(voucher.getStartDate()) || nowSql.after(voucher.getEndDate())) {
                request.setAttribute("voucherCode", voucherCode);
                setErrorAndForward(request, response, room,
                        "Mã voucher chưa hoặc đã hết hạn sử dụng!");
                return;
            }

            if (voucher.getUsageLimit() != null
                    && voucher.getUsedCount() >= voucher.getUsageLimit()) {
                request.setAttribute("voucherCode", voucherCode);
                setErrorAndForward(request, response, room,
                        "Mã voucher đã hết lượt sử dụng!");
                return;
            }

            if (voucher.getMinOrderAmount() != null
                    && totalAmount.compareTo(voucher.getMinOrderAmount()) < 0) {
                String minStr = String.format("%,.0f VNĐ", voucher.getMinOrderAmount());
                request.setAttribute("voucherCode", voucherCode);
                setErrorAndForward(request, response, room,
                        "Đơn hàng phải từ " + minStr + " mới được dùng voucher này!");
                return;
            }

            discountAmount = voucherService.calculateDiscount(voucher, totalAmount);
            finalAmount    = totalAmount.subtract(discountAmount);
            voucherID      = voucher.getPromotionID();
        }

        // ── 7. Số người lớn & trẻ em ──────────────────────────────
        String adultsStr = request.getParameter("adults");
        if (adultsStr == null || adultsStr.isBlank()) {
            setErrorAndForward(request, response, room, "Số lượng người lớn là phần bắt buộc!");
            return;
        }
        int adults;
        try {
            adults = Integer.parseInt(adultsStr.trim());
            if (adults <= 0) {
                setErrorAndForward(request, response, room, "Số lượng người lớn phải lớn hơn 0!");
                return;
            }
        } catch (NumberFormatException e) {
            setErrorAndForward(request, response, room, "Số lượng người lớn phải là số!");
            return;
        }

        String childrenStr = request.getParameter("children");
        int children = 0;
        if (childrenStr != null && !childrenStr.isBlank()) {
            try {
                children = Integer.parseInt(childrenStr.trim());
                if (children < 0) {
                    setErrorAndForward(request, response, room, "Số lượng trẻ em không được nhỏ hơn 0!");
                    return;
                }
            } catch (NumberFormatException e) {
                setErrorAndForward(request, response, room, "Số lượng trẻ em phải là số!");
                return;
            }
        }

        // ── 8. Ghi chú ────────────────────────────────────────────
        String note = request.getParameter("note");
        if (note == null) note = "";
        if (note.length() > 500) {
            setErrorAndForward(request, response, room, "Yêu cầu đặc biệt không được vượt quá 500 ký tự!");
            return;
        }

        if (isOthers) {
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
        booking.setVoucherID(voucherID);
        booking.setTotalAmount(totalAmount);
        booking.setDiscountAmount(discountAmount);
        booking.setFinalAmount(finalAmount);
        booking.setStatus("Chờ xác nhận");
        booking.setNote(note);
        booking.setRoomID(roomId);
        booking.setRoomPrice(roomPrice);

        // ── 10. INSERT vào database ────────────────────────────────
        boolean result = bookingService.addBooking(booking);

        if (result) {
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
    // HỦY ĐẶT PHÒNG (Customer tự hủy)
    // ================================================================
    private void cancelBooking(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        User user = getLoginUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idStr        = request.getParameter("id");
        String cancelReason = request.getParameter("cancelReason");

        if (idStr == null || idStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/booking?action=history");
            return;
        }

        try {
            int bookingId = Integer.parseInt(idStr.trim());
            Booking booking = bookingService.getBookingById(bookingId);

            // Kiểm tra booking tồn tại & thuộc về user đang đăng nhập
            if (booking == null || booking.getUserID() != user.getUserID()) {
                request.getSession().setAttribute("errorMsg",
                        "Không tìm thấy đơn đặt phòng!");
                response.sendRedirect(request.getContextPath() + "/booking?action=history");
                return;
            }

            // Chỉ cho hủy khi đang "Chờ xác nhận"
            if (!"Chờ xác nhận".equals(booking.getStatus())) {
                request.getSession().setAttribute("errorMsg",
                        "Chỉ có thể hủy đơn đang ở trạng thái 'Chờ xác nhận'!");
                response.sendRedirect(request.getContextPath() + "/booking?action=history");
                return;
            }

            booking.setStatus("Đã hủy");
            booking.setCancelReason(
                    (cancelReason != null && !cancelReason.isBlank())
                            ? cancelReason.trim()
                            : "Khách hàng tự hủy");
            booking.setCancelDate(new java.sql.Timestamp(System.currentTimeMillis()));

            boolean result = bookingService.updateBooking(booking);

            if (result) {
                request.getSession().setAttribute("successMsg",
                        "Hủy đặt phòng #" + booking.getBookingCode() + " thành công!");
            } else {
                request.getSession().setAttribute("errorMsg",
                        "Hủy đặt phòng thất bại, vui lòng thử lại!");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMsg", "Mã đơn không hợp lệ!");
        }

        response.sendRedirect(request.getContextPath() + "/booking?action=history");
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

    private User getLoginUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute("user");
    }

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