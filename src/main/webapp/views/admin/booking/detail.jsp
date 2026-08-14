<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn đặt phòng - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body class="bg-light">

<jsp:include page="../../layout/header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-3">
            <jsp:include page="../../layout/sidebar.jsp"/>
        </div>
        <div class="col-md-9">

            <!-- Tiêu đề -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold text-primary mb-1">
                        <i class="fa-solid fa-file-alt me-2"></i>Chi tiết đặt phòng
                    </h3>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/booking?action=manage">Đặt phòng</a>
                            </li>
                            <li class="breadcrumb-item active">Chi tiết #${booking.bookingCode}</li>
                        </ol>
                    </nav>
                </div>
                <a href="${pageContext.request.contextPath}/booking?action=manage"
                   class="btn btn-outline-secondary">
                    <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                </a>
            </div>

            <div class="row g-4">

                <!-- Thông tin đặt phòng -->
                <div class="col-md-8">
                    <div class="card shadow border-0">
                        <div class="card-header bg-dark text-white py-3">
                            <h5 class="mb-0">
                                <i class="fa-solid fa-calendar-check me-2"></i>
                                Đơn đặt phòng #${booking.bookingCode}
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-3">
                                <div class="col-sm-6">
                                    <label class="text-muted small">Mã đặt phòng</label>
                                    <div class="fw-bold">${booking.bookingCode}</div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="text-muted small">Ngày đặt</label>
                                    <div>${booking.bookingDate}</div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="text-muted small">Ngày nhận phòng</label>
                                    <div class="fw-bold text-success">${booking.checkInDate}</div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="text-muted small">Ngày trả phòng</label>
                                    <div class="fw-bold text-danger">${booking.checkOutDate}</div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="text-muted small">Số khách</label>
                                    <div><i class="fa-solid fa-user me-1"></i>${booking.guestCount}</div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="text-muted small">Trạng thái</label>
                                    <div>
                                        <c:choose>
                                            <c:when test="${booking.status == 'Chờ xác nhận'}">
                                                <span class="badge bg-warning text-dark fs-6">${booking.status}</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'Đã xác nhận'}">
                                                <span class="badge bg-primary fs-6">${booking.status}</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'Đang ở'}">
                                                <span class="badge bg-success fs-6">${booking.status}</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'Đã trả phòng'}">
                                                <span class="badge bg-secondary fs-6">${booking.status}</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'Đã hủy'}">
                                                <span class="badge bg-danger fs-6">${booking.status}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-info fs-6">${booking.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="text-muted small">Tổng tiền</label>
                                    <div class="fw-bold">
                                        <fmt:formatNumber value="${booking.totalAmount}" type="number"/>đ
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="text-muted small">Giảm giá</label>
                                    <div class="text-danger">
                                        -<fmt:formatNumber value="${booking.discountAmount}" type="number"/>đ
                                    </div>
                                </div>
                                <div class="col-12">
                                    <label class="text-muted small">Thành tiền</label>
                                    <div class="fw-bold text-success fs-5">
                                        <fmt:formatNumber value="${booking.finalAmount}" type="number"/>đ
                                    </div>
                                </div>
                                <c:if test="${not empty booking.note}">
                                    <div class="col-12">
                                        <label class="text-muted small">Ghi chú</label>
                                        <div class="p-2 bg-light border rounded">${booking.note}</div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty booking.cancelReason}">
                                    <div class="col-12">
                                        <label class="text-muted small text-danger">Lý do hủy</label>
                                        <div class="p-2 bg-danger bg-opacity-10 border border-danger rounded text-danger">
                                            ${booking.cancelReason}
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Panel thao tác nhanh -->
                <div class="col-md-4">
                    <div class="card shadow border-0">
                        <div class="card-header bg-dark text-white py-3">
                            <h5 class="mb-0"><i class="fa-solid fa-cogs me-2"></i>Thao tác</h5>
                        </div>
                        <div class="card-body p-3">
                            <div class="d-grid gap-2">
                                <form method="post"
                                      action="${pageContext.request.contextPath}/booking?action=update-status">
                                    <input type="hidden" name="id" value="${booking.bookingID}">
                                    <div class="mb-2">
                                        <label class="form-label fw-semibold small">Cập nhật trạng thái</label>
                                        <select name="status" class="form-select form-select-sm">
                                            <option value="Chờ xác nhận"
                                                ${booking.status == 'Chờ xác nhận' ? 'selected' : ''}>
                                                Chờ xác nhận
                                            </option>
                                            <option value="Đã xác nhận"
                                                ${booking.status == 'Đã xác nhận' ? 'selected' : ''}>
                                                Đã xác nhận
                                            </option>
                                            <option value="Đang ở"
                                                ${booking.status == 'Đang ở' ? 'selected' : ''}>
                                                Đang ở
                                            </option>
                                            <option value="Đã trả phòng"
                                                ${booking.status == 'Đã trả phòng' ? 'selected' : ''}>
                                                Đã trả phòng
                                            </option>
                                            <option value="Đã hủy"
                                                ${booking.status == 'Đã hủy' ? 'selected' : ''}>
                                                Đã hủy
                                            </option>
                                        </select>
                                    </div>
                                    <div class="mb-2" id="cancelReasonGroup" style="display:none;">
                                        <label class="form-label fw-semibold small">Lý do hủy</label>
                                        <textarea name="cancelReason" class="form-control form-control-sm"
                                                  rows="2"
                                                  placeholder="Nhập lý do hủy...">${booking.cancelReason}</textarea>
                                    </div>
                                    <button type="submit" class="btn btn-warning btn-sm w-100">
                                        <i class="fa-solid fa-save me-1"></i>Lưu trạng thái
                                    </button>
                                </form>

                                <hr class="my-2">

                                <a href="${pageContext.request.contextPath}/booking?action=checkin&id=${booking.bookingID}"
                                   class="btn btn-success btn-sm">
                                    <i class="fa-solid fa-door-open me-1"></i>Xác nhận Check-in
                                </a>
                                <a href="${pageContext.request.contextPath}/booking?action=checkout&id=${booking.bookingID}"
                                   class="btn btn-info btn-sm text-white">
                                    <i class="fa-solid fa-door-closed me-1"></i>Xác nhận Check-out
                                </a>
                                <a href="${pageContext.request.contextPath}/booking?action=invoice&id=${booking.bookingID}"
                                   class="btn btn-outline-primary btn-sm">
                                    <i class="fa-solid fa-file-invoice me-1"></i>Xem hóa đơn
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Hiển thị/ẩn ô lý do hủy
    const statusSelect = document.querySelector('select[name="status"]');
    const cancelGroup = document.getElementById('cancelReasonGroup');

    function toggleCancelReason() {
        cancelGroup.style.display = statusSelect.value === 'Đã hủy' ? 'block' : 'none';
    }
    statusSelect.addEventListener('change', toggleCancelReason);
    toggleCancelReason();
</script>
</body>
</html>
