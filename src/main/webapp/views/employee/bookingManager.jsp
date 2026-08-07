<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Đặt phòng - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <!-- Sidebar Navigation -->
        <div class="col-md-3">
            <jsp:include page="../layout/sidebar.jsp"/>
        </div>

        <!-- Booking Manager Content -->
        <div class="col-md-9">
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3 d-flex justify-content-between align-items-center">
                    <h4 class="mb-0"><i class="fa-solid fa-calendar-check me-2"></i> Danh sách Đơn đặt phòng</h4>
                    <span class="badge bg-secondary">${bookingList.size()} đơn</span>
                </div>
                <div class="card-body p-4">
                    
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped table-hover align-middle">
                            <thead class="table-dark">
                                <tr class="text-center">
                                    <th>Mã đơn</th>
                                    <th>Khách hàng</th>
                                    <th>Phòng</th>
                                    <th>Ngày ở</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Thanh toán</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${bookingList}" var="b">
                                    <tr>
                                        <!-- Mã đơn -->
                                        <td class="text-center fw-bold text-success">${b.bookingCode}</td>
                                        
                                        <!-- Khách hàng -->
                                        <td>
                                            <c:forEach items="${userList}" var="u">
                                                <c:if test="${u.userID == b.userID}">
                                                    <strong>${u.fullName}</strong>
                                                    <span class="d-block text-muted small">${u.phone}</span>
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                        <!-- Phòng -->
                                        <td>
                                            <c:forEach items="${roomList}" var="r">
                                                <c:if test="${r.roomID == b.roomID}">
                                                    <strong>P. ${r.roomNumber}</strong>
                                                    <span class="d-block text-muted small">${r.roomName}</span>
                                                </c:if>
                                            </c:forEach>
                                        </td>

                                        <!-- Ngày ở -->
                                        <td class="text-center small">
                                            <span class="d-block text-success">Từ: ${b.checkInDate}</span>
                                            <span class="d-block text-danger">Đến: ${b.checkOutDate}</span>
                                        </td>

                                        <!-- Tổng tiền -->
                                        <td class="text-end text-danger fw-bold">${b.totalAmount} VNĐ</td>

                                        <!-- Trạng thái -->
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${b.bookingStatus == 'Pending'}">
                                                    <span class="badge bg-warning text-dark">Chờ nhận</span>
                                                </c:when>
                                                <c:when test="${b.bookingStatus == 'Confirmed'}">
                                                    <span class="badge bg-primary">Đang ở</span>
                                                </c:when>
                                                <c:when test="${b.bookingStatus == 'CheckedOut'}">
                                                    <span class="badge bg-success">Đã trả</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${b.bookingStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <!-- Thanh toán -->
                                        <td class="text-center">
                                            <span class="badge ${b.paymentStatus == 'Paid' ? 'bg-success' : 'bg-danger'}">
                                                ${b.paymentStatus == 'Paid' ? 'Đã thanh toán' : 'Chưa thanh toán'}
                                            </span>
                                        </td>

                                        <!-- Hành động -->
                                        <td class="text-center">
                                            <div class="d-flex flex-column gap-1">
                                                <c:choose>
                                                    <c:when test="${b.bookingStatus == 'Pending'}">
                                                        <a href="${pageContext.request.contextPath}/booking?action=checkin&id=${b.bookingID}" class="btn btn-sm btn-success py-1">
                                                            <i class="fa-solid fa-key"></i> Check-in
                                                        </a>
                                                    </c:when>
                                                    <c:when test="${b.bookingStatus == 'Confirmed'}">
                                                        <a href="${pageContext.request.contextPath}/booking?action=checkout&id=${b.bookingID}" class="btn btn-sm btn-danger py-1">
                                                            <i class="fa-solid fa-bell-concierge"></i> Check-out
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/booking?action=invoice&id=${b.bookingID}" class="btn btn-sm btn-outline-info py-1">
                                                            <i class="fa-solid fa-receipt"></i> Hóa đơn
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty bookingList}">
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-4">Không tìm thấy đơn đặt phòng nào.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
