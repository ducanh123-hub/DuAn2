<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn thanh toán - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        @media print {
            .no-print {
                display: none !important;
            }
            body {
                background-color: #fff !important;
            }
            .card {
                box-shadow: none !important;
                border: none !important;
            }
        }
    </style>
</head>
<body class="bg-light">

<div class="no-print">
    <jsp:include page="../layout/header.jsp"/>
</div>

<div class="container my-5">
    <div class="card shadow border-0 max-width-800 mx-auto" style="max-width: 800px; background: #fff;">
        <div class="card-body p-5">
            <!-- Invoice Header -->
            <div class="row align-items-center mb-4 pb-4 border-bottom">
                <div class="col-sm-6 text-start">
                    <h2 class="text-primary fw-bold mb-0">
                        <i class="fa-solid fa-hotel me-2 text-warning"></i>LUXURY HOTEL
                    </h2>
                    <p class="text-muted mb-0 small">Dịch vụ nghỉ dưỡng chuẩn hoàng gia</p>
                </div>
                <div class="col-sm-6 text-sm-end mt-3 mt-sm-0">
                    <h4 class="text-secondary fw-bold">HÓA ĐƠN THANH TOÁN</h4>
                    <span class="text-muted">Mã đơn: </span>
                    <span class="fw-bold text-success">#${booking.bookingCode}</span>
                </div>
            </div>

            <!-- Hotel & Client Info -->
            <div class="row mb-4">
                <div class="col-sm-6 mb-3 mb-sm-0">
                    <h6 class="fw-bold text-muted text-uppercase mb-2">Đơn vị cung cấp</h6>
                    <p class="mb-1 fw-bold">Luxury Hotel Group</p>
                    <p class="mb-1 text-muted small"><i class="fa-solid fa-location-dot me-1"></i> Khu Du Lịch Bãi Cháy, Hạ Long, Quảng Ninh</p>
                    <p class="mb-1 text-muted small"><i class="fa-solid fa-phone me-1"></i> Hotline: 1900 6868</p>
                    <p class="mb-0 text-muted small"><i class="fa-solid fa-envelope me-1"></i> contact@luxuryhotel.com</p>
                </div>
                <div class="col-sm-6 text-sm-end">
                    <h6 class="fw-bold text-muted text-uppercase mb-2">Khách hàng</h6>
                    <p class="mb-1 fw-bold">${customer.fullName}</p>
                    <p class="mb-1 text-muted small"><i class="fa-solid fa-passport me-1"></i> CCCD/Passport: ${customer.cccd != null ? customer.cccd : 'N/A'}</p>
                    <p class="mb-1 text-muted small"><i class="fa-solid fa-phone me-1"></i> SĐT: ${customer.phone}</p>
                    <p class="mb-0 text-muted small"><i class="fa-solid fa-envelope me-1"></i> Email: ${customer.email}</p>
                </div>
            </div>

            <!-- Booking Specifics -->
            <div class="bg-light p-3 rounded mb-4">
                <div class="row text-center text-sm-start">
                    <div class="col-sm-3 mb-2 mb-sm-0">
                        <span class="text-muted d-block small">Ngày nhận phòng</span>
                        <strong class="text-dark">${booking.checkInDate}</strong>
                    </div>
                    <div class="col-sm-3 mb-2 mb-sm-0">
                        <span class="text-muted d-block small">Ngày trả phòng</span>
                        <strong class="text-dark">${booking.checkOutDate}</strong>
                    </div>
                    <div class="col-sm-3 mb-2 mb-sm-0">
                        <span class="text-muted d-block small">Trạng thái phòng</span>
                        <strong class="badge bg-success">Đã trả phòng</strong>
                    </div>
                    <div class="col-sm-3 text-sm-end">
                        <span class="text-muted d-block small">Trạng thái hóa đơn</span>
                        <strong class="badge ${booking.paymentStatus == 'Paid' ? 'bg-success' : 'bg-danger'}">
                            ${booking.paymentStatus == 'Paid' ? 'Đã thanh toán' : 'Chưa thanh toán'}
                        </strong>
                    </div>
                </div>
            </div>

            <!-- Billing Details Table -->
            <div class="table-responsive mb-4">
                <table class="table table-bordered mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Mô tả khoản thu</th>
                            <th class="text-center" style="width: 15%">Số đêm</th>
                            <th class="text-end" style="width: 25%">Đơn giá/Đêm (VNĐ)</th>
                            <th class="text-end" style="width: 25%">Thành tiền (VNĐ)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div><strong>Tiền thuê phòng: ${room.roomName}</strong></div>
                                <small class="text-muted">Số phòng: ${room.roomNumber} | Vị trí: ${room.area}</small>
                            </td>
                            <td class="text-center">
                                <c:set var="timeDiff" value="${booking.checkOutDate.time - booking.checkInDate.time}" />
                                <c:set var="nights" value="${timeDiff / (1000 * 60 * 60 * 24)}" />
                                <fmt:formatNumber value="${nights}" maxFractionDigits="0" />
                            </td>
                            <td class="text-end">
                                ${room.price}
                            </td>
                            <td class="text-end">
                                ${booking.roomPrice}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-end fw-bold">Chi phí dịch vụ phát sinh</td>
                            <td class="text-end">${booking.servicePrice != null ? booking.servicePrice : '0'}</td>
                        </tr>
                        <tr>
                            <td colspan="3" class="text-end fw-bold">Khuyến mãi / Giảm giá</td>
                            <td class="text-end text-success">-${booking.discountAmount != null ? booking.discountAmount : '0'}</td>
                        </tr>
                        <tr class="table-active">
                            <td colspan="3" class="text-end fw-bold fs-5 text-danger">Tổng cộng tiền thanh toán</td>
                            <td class="text-end fw-bold fs-5 text-danger">${booking.totalAmount} VNĐ</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Note section -->
            <c:if test="${not empty booking.note}">
                <div class="mb-4">
                    <h6 class="fw-bold"><i class="fa-solid fa-comment-dots text-muted me-1"></i> Ghi chú bổ sung:</h6>
                    <p class="text-muted italic bg-light p-3 rounded">${booking.note}</p>
                </div>
            </c:if>

            <!-- Signature Section -->
            <div class="row mt-5 pt-4 text-center">
                <div class="col-6">
                    <p class="mb-5 text-muted small">Chữ ký Khách hàng</p>
                    <div class="mt-4"><hr class="w-50 mx-auto"></div>
                    <strong class="text-dark">${customer.fullName}</strong>
                </div>
                <div class="col-6">
                    <p class="mb-5 text-muted small">Đại diện khách sạn</p>
                    <div class="mt-4"><hr class="w-50 mx-auto"></div>
                    <strong class="text-dark">Luxury Hotel Cashier</strong>
                </div>
            </div>
        </div>
        
        <!-- Action Buttons -->
        <div class="card-footer bg-light p-4 d-flex justify-content-between no-print">
            <button onclick="window.history.back();" class="btn btn-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
            </button>
            <div>
                <button onclick="window.print();" class="btn btn-primary">
                    <i class="fa-solid fa-print me-1"></i> In hóa đơn
                </button>
            </div>
        </div>
    </div>
</div>

<div class="no-print">
    <jsp:include page="../layout/footer.jsp"/>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
