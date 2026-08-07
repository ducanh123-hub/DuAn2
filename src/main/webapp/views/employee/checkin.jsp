<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận nhận phòng (Check-in) - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="card shadow border-0 max-width-700 mx-auto" style="max-width: 700px;">
        <div class="card-header bg-dark text-white py-3">
            <h4 class="mb-0"><i class="fa-solid fa-key me-2 text-warning"></i> Xác nhận thủ tục nhận phòng (Check-in)</h4>
        </div>
        <div class="card-body p-4">
            
            <div class="alert alert-info">
                <i class="fa-solid fa-triangle-exclamation me-2"></i> Vui lòng kiểm tra kỹ giấy tờ tùy thân của khách hàng trước khi xác nhận bàn giao chìa khóa phòng.
            </div>

            <!-- Client Info Section -->
            <h5 class="fw-bold text-primary mb-3 border-bottom pb-2">Thông tin khách hàng</h5>
            <div class="row mb-4">
                <div class="col-sm-6 mb-2">
                    <span class="text-muted small d-block">Họ và tên:</span>
                    <strong>${customer.fullName}</strong>
                </div>
                <div class="col-sm-6 mb-2">
                    <span class="text-muted small d-block">Số điện thoại:</span>
                    <strong>${customer.phone}</strong>
                </div>
                <div class="col-sm-6 mb-2">
                    <span class="text-muted small d-block">Email:</span>
                    <strong>${customer.email}</strong>
                </div>
                <div class="col-sm-6 mb-2">
                    <span class="text-muted small d-block">Số CCCD / Hộ chiếu:</span>
                    <strong>${customer.cccd != null && !customer.cccd.isEmpty() ? customer.cccd : 'Chưa cập nhật'}</strong>
                </div>
            </div>

            <!-- Booking Info Section -->
            <h5 class="fw-bold text-primary mb-3 border-bottom pb-2">Thông tin đặt phòng</h5>
            <div class="row mb-4">
                <div class="col-sm-6 mb-2">
                    <span class="text-muted small d-block">Mã đơn:</span>
                    <strong class="text-success">${booking.bookingCode}</strong>
                </div>
                <div class="col-sm-6 mb-2">
                    <span class="text-muted small d-block">Tên phòng:</span>
                    <strong>P. ${room.roomNumber} - ${room.roomName}</strong>
                </div>
                <div class="col-sm-6 mb-2">
                    <span class="text-muted small d-block">Thời gian lưu trú:</span>
                    <strong>Từ ${booking.checkInDate} đến ${booking.checkOutDate}</strong>
                </div>
                <div class="col-sm-6 mb-2">
                    <span class="text-muted small d-block">Tổng thanh toán phòng dự kiến:</span>
                    <strong class="text-danger">${booking.totalAmount} VNĐ</strong>
                </div>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/booking">
                <input type="hidden" name="action" value="confirmCheckin">
                <input type="hidden" name="bookingId" value="${booking.bookingID}">

                <div class="d-flex justify-content-between mt-5 border-top pt-4">
                    <a href="${pageContext.request.contextPath}/booking?action=manage" class="btn btn-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại danh sách
                    </a>
                    <button type="submit" class="btn btn-success px-4">
                        <i class="fa-solid fa-circle-check me-1"></i> Xác nhận Nhận phòng
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
