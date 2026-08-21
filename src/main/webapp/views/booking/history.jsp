<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đặt phòng - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { background-color: #f5f5f5; }

        .page-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 48px 20px 80px;
        }

        .history-card {
            border: none;
            border-radius: 14px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.09);
            overflow: hidden;
        }

        .history-card .card-header {
            background: #1c1c1c;
            padding: 20px 28px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .history-card .card-header h4 {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 700;
            color: #fff;
        }

        .booking-table { margin: 0; }

        .booking-table thead th {
            background: #2d2d2d;
            color: #ccc;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            padding: 13px 18px;
            border: none;
            white-space: nowrap;
        }

        .booking-table tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.12s;
        }

        .booking-table tbody tr:last-child { border-bottom: none; }
        .booking-table tbody tr:hover { background: #fffdf0; }

        .booking-table tbody td {
            padding: 15px 18px;
            vertical-align: middle;
            font-size: 0.88rem;
            color: #333;
        }

        .booking-code {
            font-family: 'Courier New', monospace;
            font-weight: 700;
            font-size: 0.92rem;
            color: #c89b00;
            letter-spacing: 1.5px;
        }

        .amount {
            font-weight: 700;
            color: #c0392b;
            white-space: nowrap;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 5px 11px;
            border-radius: 20px;
            font-size: 0.76rem;
            font-weight: 700;
            white-space: nowrap;
        }

        .status-badge.pending   { background:#fff8e1; color:#b8860b; border:1.5px solid #f5c518; }
        .status-badge.confirmed { background:#e8f4fd; color:#1565c0; border:1.5px solid #42a5f5; }
        .status-badge.checkedout{ background:#f0f0f0; color:#555;    border:1.5px solid #bbb; }
        .status-badge.cancelled { background:#fdecea; color:#c62828; border:1.5px solid #ef9a9a; }
        .status-badge.staying   { background:#e8f5e9; color:#2e7d32; border:1.5px solid #66bb6a; }
        .status-badge.other     { background:#e3f2fd; color:#0d47a1; border:1.5px solid #90caf9; }

        .btn-huy {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            background: #fff;
            color: #dc3545;
            border: 1.5px solid #dc3545;
            border-radius: 7px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.16s;
            white-space: nowrap;
        }

        .btn-huy:hover { background: #dc3545; color: #fff; }

        .ly-do-huy {
            font-size: 0.8rem;
            color: #888;
            cursor: pointer;
            text-decoration: underline dotted;
        }

        .ly-do-huy:hover { color: #dc3545; }

        .dash-text { font-size: 0.82rem; color: #bbb; }

        .empty-state { padding: 70px 20px; text-align: center; }
        .empty-state .empty-icon { font-size: 3.5rem; color: #ddd; margin-bottom: 14px; }
        .empty-state p { color: #999; margin-bottom: 20px; }

        .flash-alert { border-radius: 10px; font-size: 0.88rem; margin-bottom: 20px; }

        .btn-back-home {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 22px;
            padding: 10px 24px;
            background: #f5c518;
            color: #1c1c1c;
            font-weight: 700;
            font-size: 0.88rem;
            border-radius: 8px;
            text-decoration: none;
            transition: background 0.16s;
        }

        .btn-back-home:hover { background: #e6b800; color: #1c1c1c; }

        .modal-content { border: none; border-radius: 14px; overflow: hidden; }

        .modal-header-danger {
            background: linear-gradient(135deg, #b71c1c, #e53935);
            padding: 18px 24px;
        }

        .modal-header-danger .modal-title { color: #fff; font-weight: 700; font-size: 1rem; }
        .modal-header-danger .btn-close { filter: brightness(0) invert(1); opacity: 0.8; }

        .warning-box {
            background: #fff5f5;
            border-left: 4px solid #e53935;
            border-radius: 0 8px 8px 0;
            padding: 13px 16px;
            margin-bottom: 18px;
            font-size: 0.88rem;
            color: #555;
            line-height: 1.6;
        }

        .warning-box strong { color: #c62828; }
        .char-counter { font-size: 0.75rem; color: #bbb; text-align: right; margin-top: 4px; }
    </style>
</head>
<body>

<jsp:include page="../layout/header.jsp"/>

<div class="page-wrapper">

    <%-- Flash messages --%>
    <c:if test="${not empty sessionScope.successMsg}">
        <div class="alert alert-success alert-dismissible fade show flash-alert d-flex align-items-center gap-2">
            <i class="fa-solid fa-circle-check"></i>
            <span>${sessionScope.successMsg}</span>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="successMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show flash-alert d-flex align-items-center gap-2">
            <i class="fa-solid fa-circle-xmark"></i>
            <span>${sessionScope.errorMsg}</span>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="errorMsg" scope="session"/>
    </c:if>

    <div class="card history-card">
        <div class="card-header">
            <i class="fa-solid fa-clock-rotate-left" style="color:#f5c518; font-size:1.1rem;"></i>
            <h4>Lịch sử đặt phòng của bạn</h4>
        </div>

        <div class="card-body p-0">
            <c:choose>

                <c:when test="${empty bookingList}">
                    <div class="empty-state">
                        <div class="empty-icon"><i class="fa-solid fa-calendar-xmark"></i></div>
                        <p>Bạn chưa có đơn đặt phòng nào.</p>
                        <a href="${pageContext.request.contextPath}/room" class="btn btn-warning fw-bold px-4">
                            <i class="fa-solid fa-bed me-2"></i>Đặt phòng ngay
                        </a>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table booking-table">
                            <thead>
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Mã phòng</th>
                                    <th>Ngày nhận phòng</th>
                                    <th>Ngày trả phòng</th>
                                    <th>Tổng thanh toán</th>
                                    <th>Trạng thái đặt phòng</th>
                                    <th>Thời gian đặt</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="b" items="${bookingList}">
                                    <tr>
                                        <td><span class="booking-code">${b.bookingCode}</span></td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty b.roomNumber}">${b.roomNumber}</c:when>
                                                <c:otherwise>${b.roomID}</c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>${b.checkInDate}</td>
                                        <td>${b.checkOutDate}</td>

                                        <td>
                                            <span class="amount">
                                                <fmt:formatNumber value="${b.finalAmount}" type="number"/> VNĐ
                                            </span>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${b.status == 'Chờ xác nhận'}">
                                                    <span class="status-badge pending">
                                                        <i class="fa-solid fa-clock"></i>${b.status}
                                                    </span>
                                                </c:when>
                                                <c:when test="${b.status == 'Đã xác nhận'}">
                                                    <span class="status-badge confirmed">
                                                        <i class="fa-solid fa-circle-check"></i>${b.status}
                                                    </span>
                                                </c:when>
                                                <c:when test="${b.status == 'Đã trả phòng'}">
                                                    <span class="status-badge checkedout">
                                                        <i class="fa-solid fa-door-closed"></i>${b.status}
                                                    </span>
                                                </c:when>
                                                <c:when test="${b.status == 'Đã hủy'}">
                                                    <span class="status-badge cancelled">
                                                        <i class="fa-solid fa-ban"></i>${b.status}
                                                    </span>
                                                </c:when>
                                                <c:when test="${b.status == 'Đang ở'}">
                                                    <span class="status-badge staying">
                                                        <i class="fa-solid fa-house-user"></i>${b.status}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge other">${b.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td style="color:#888; font-size:0.82rem;">${b.createdAt}</td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${b.status == 'Chờ xác nhận'}">
                                                    <button type="button"
                                                            class="btn-huy"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#modalHuyDon"
                                                            data-id="${b.bookingID}"
                                                            data-code="${b.bookingCode}">
                                                        <i class="fa-solid fa-ban"></i>Hủy đơn
                                                    </button>
                                                </c:when>
                                                <c:when test="${b.status == 'Đã hủy'}">
                                                    <c:choose>
                                                        <c:when test="${not empty b.cancelReason}">
                                                            <span class="ly-do-huy"
                                                                  data-bs-toggle="tooltip"
                                                                  data-bs-placement="top"
                                                                  title="${b.cancelReason}">
                                                                <i class="fa-solid fa-circle-info"></i> Lý do hủy
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="dash-text">—</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="dash-text">Chưa có hóa đơn</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>

            </c:choose>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/" class="btn-back-home">
        <i class="fa-solid fa-house"></i>Quay lại Trang chủ
    </a>

</div>


<%-- MODAL XÁC NHẬN HỦY --%>
<div class="modal fade" id="modalHuyDon" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width:480px;">
        <div class="modal-content">

            <div class="modal-header-danger">
                <h5 class="modal-title">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i>Xác nhận hủy đặt phòng
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form method="get" action="${pageContext.request.contextPath}/booking">
                <input type="hidden" name="action" value="cancel">
                <input type="hidden" name="id" id="inputBookingId">

                <div class="modal-body p-4">
                    <div class="warning-box">
                        Bạn đang yêu cầu hủy đơn đặt phòng
                        <strong id="spanBookingCode"></strong>.
                        Hành động này <strong>không thể hoàn tác</strong> sau khi xác nhận.
                    </div>

                    <label for="cancelReason" class="form-label fw-semibold" style="font-size:0.88rem;">
                        Lý do hủy <span class="text-muted fw-normal">(không bắt buộc)</span>
                    </label>
                    <textarea id="cancelReason"
                              name="cancelReason"
                              class="form-control"
                              rows="3"
                              maxlength="300"
                              placeholder="Ví dụ: Thay đổi kế hoạch, bận việc đột xuất..."></textarea>
                    <div class="char-counter"><span id="charCount">0</span>/300 ký tự</div>
                </div>

                <div class="modal-footer border-0 px-4 pb-4 pt-0 gap-2">
                    <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">
                        <i class="fa-solid fa-xmark me-1"></i>Đóng
                    </button>
                    <button type="submit" class="btn btn-danger px-4 fw-bold">
                        <i class="fa-solid fa-ban me-1"></i>Xác nhận hủy
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>


<jsp:include page="../layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('modalHuyDon').addEventListener('show.bs.modal', function (e) {
        const btn = e.relatedTarget;
        document.getElementById('inputBookingId').value      = btn.dataset.id;
        document.getElementById('spanBookingCode').textContent = '#' + btn.dataset.code;
        document.getElementById('cancelReason').value        = '';
        document.getElementById('charCount').textContent     = '0';
    });

    document.getElementById('cancelReason').addEventListener('input', function () {
        document.getElementById('charCount').textContent = this.value.length;
    });

    document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => {
        new bootstrap.Tooltip(el, { trigger: 'hover focus' });
    });
</script>
</body>
</html>
