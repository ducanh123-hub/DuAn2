<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thủ tục Trả phòng & Thanh toán (Check-out) - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="card shadow border-0 max-width-800 mx-auto" style="max-width: 800px;">
        <div class="card-header bg-dark text-white py-3">
            <h4 class="mb-0"><i class="fa-solid fa-bell-concierge me-2 text-warning"></i> Tính tiền & Trả phòng (Check-out)</h4>
        </div>
        <div class="card-body p-4">
            
            <!-- Quick Summary Panel -->
            <div class="row mb-4 bg-light p-3 rounded mx-0">
                <div class="col-sm-6 mb-2 mb-sm-0">
                    <span class="text-muted small d-block">Khách hàng:</span>
                    <strong class="text-dark">${customer.fullName}</strong>
                    <span class="d-block text-muted small">${customer.phone}</span>
                </div>
                <div class="col-sm-6 text-sm-end">
                    <span class="text-muted small d-block">Phòng bàn giao:</span>
                    <strong class="text-dark">P. ${room.roomNumber} - ${room.roomName}</strong>
                    <span class="d-block text-muted small">Thời gian: ${booking.checkInDate} đến ${booking.checkOutDate}</span>
                </div>
            </div>

            <!-- Billing Details Form -->
            <form method="post" action="${pageContext.request.contextPath}/booking">
                <input type="hidden" name="action" value="confirmCheckout">
                <input type="hidden" name="bookingId" value="${booking.bookingID}">

                <div class="row">
                    <!-- Room Charge (Read-only) -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Tiền phòng cơ bản (VNĐ)</label>
                        <input type="text" class="form-control bg-light" id="roomPrice" value="${booking.roomPrice}" readonly>
                    </div>

                    <!-- Additional Service Charge -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Chi phí dịch vụ phát sinh (VNĐ)</label>
                        <input type="number" name="servicePrice" id="servicePrice" class="form-control" value="0" min="0" step="1000" required>
                        <div class="form-text">Điện thoại, Mini-bar, giặt là, ăn uống tại phòng...</div>
                    </div>
                </div>

                <!-- Note / Remarks -->
                <div class="mb-4">
                    <label class="form-label fw-bold">Ghi chú thanh toán</label>
                    <textarea name="note" class="form-control" rows="3" placeholder="Nhập ghi chú chi tiết về dịch vụ sử dụng (nếu có)..."></textarea>
                </div>

                <!-- Final Invoice Total Box -->
                <div class="p-4 rounded mb-4 bg-danger bg-opacity-10 border border-danger border-opacity-20 d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="fw-bold text-danger mb-1">TỔNG TIỀN THANH TOÁN THỰC TẾ:</h5>
                        <p class="text-muted small mb-0">(Bao gồm tiền phòng + chi phí dịch vụ phát sinh)</p>
                    </div>
                    <div>
                        <input type="text" name="totalAmount" id="totalAmount" class="form-control text-end text-danger fw-bold fs-4 bg-transparent border-0 py-0" style="width: 250px;" value="${booking.totalAmount}" readonly>
                    </div>
                </div>

                <div class="d-flex justify-content-between border-top pt-4">
                    <a href="${pageContext.request.contextPath}/booking?action=manage" class="btn btn-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại danh sách
                    </a>
                    <button type="submit" class="btn btn-danger px-4">
                        <i class="fa-solid fa-circle-check me-1"></i> Xác nhận Trả phòng & Thanh toán
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const roomPriceVal = parseFloat("${booking.roomPrice}");
    const servicePriceInput = document.getElementById("servicePrice");
    const totalAmountInput = document.getElementById("totalAmount");

    function calculateTotal() {
        const servicePriceVal = parseFloat(servicePriceInput.value) || 0;
        const totalVal = roomPriceVal + servicePriceVal;
        totalAmountInput.value = totalVal.toFixed(0) + " VNĐ";
    }

    servicePriceInput.addEventListener("input", calculateTotal);
    calculateTotal();
});
</script>

</body>
</html>
