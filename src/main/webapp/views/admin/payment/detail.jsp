<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết thanh toán - Luxury Hotel</title>
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

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold text-primary mb-1">
                    <i class="fa-solid fa-receipt me-2"></i>Chi tiết giao dịch #${payment.paymentID}
                </h3>
                <a href="${pageContext.request.contextPath}/admin/payment" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                </a>
            </div>

            <div class="card shadow border-0 mb-4">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Thông tin thanh toán</h5>
                </div>
                <div class="card-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="fw-bold text-muted">Mã Đặt Phòng:</label>
                            <div class="fs-5 fw-bold">Booking #${payment.bookingID}</div>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold text-muted">Phương thức thanh toán:</label>
                            <div class="fs-5">${payment.paymentMethod}</div>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold text-muted">Số tiền:</label>
                            <div class="fs-4 text-success fw-bold">
                                <fmt:formatNumber value="${payment.amount}" type="number"/>đ
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold text-muted">Trạng thái:</label>
                            <div>
                                <c:choose>
                                    <c:when test="${payment.paymentStatus == 'Đã thanh toán'}">
                                        <span class="badge bg-success fs-6">Đã thanh toán</span>
                                    </c:when>
                                    <c:when test="${payment.paymentStatus == 'Đã hoàn tiền'}">
                                        <span class="badge bg-danger fs-6">Đã hoàn tiền</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark fs-6">${payment.paymentStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold text-muted">Mã giao dịch:</label>
                            <div class="font-monospace">${payment.transactionCode}</div>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold text-muted">Thời gian:</label>
                            <div>${payment.paymentDate}</div>
                        </div>
                    </div>

                    <hr class="my-4">

                    <!-- Nút thao tác -->
                    <div class="d-flex gap-2">
                        <c:if test="${payment.paymentStatus != 'Đã thanh toán' and payment.paymentStatus != 'Đã hoàn tiền'}">
                            <a href="${pageContext.request.contextPath}/admin/payment?action=confirm&id=${payment.paymentID}"
                               class="btn btn-success">
                                <i class="fa-solid fa-check me-1"></i>Xác nhận thanh toán
                            </a>
                        </c:if>

                        <c:if test="${payment.paymentStatus == 'Đã thanh toán'}">
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#refundModal">
                                <i class="fa-solid fa-undo me-1"></i>Xử lý hoàn tiền
                            </button>
                        </c:if>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Modal hoàn tiền -->
<div class="modal fade" id="refundModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="${pageContext.request.contextPath}/admin/payment">
                <input type="hidden" name="action" value="refund">
                <input type="hidden" name="id" value="${payment.paymentID}">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Xác nhận hoàn tiền</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc muốn hoàn tiền cho giao dịch này?</p>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Lý do hoàn tiền *</label>
                        <textarea name="refundReason" class="form-control" rows="3" required placeholder="Nhập lý do hoàn tiền..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">Hoàn tiền</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
