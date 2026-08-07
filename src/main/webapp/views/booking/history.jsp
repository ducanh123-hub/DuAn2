<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đặt phòng - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="card shadow border-0">
        <div class="card-header bg-dark text-white py-3">
            <h4 class="mb-0"><i class="fa-solid fa-clock-rotate-left me-2"></i> Lịch sử đặt phòng của bạn</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover align-middle">
                    <thead class="table-dark">
                        <tr class="text-center">
                            <th>Mã đơn</th>
                            <th>Mã phòng</th>
                            <th>Ngày nhận phòng</th>
                            <th>Ngày trả phòng</th>
                            <th>Tổng thanh toán (VNĐ)</th>
                            <th>Trạng thái đặt</th>
                            <th>Trạng thái thanh toán</th>
                            <th>Thời gian đặt</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookingList}" var="b">
                            <tr>
                                <td class="text-center fw-bold text-success">${b.bookingCode}</td>
                                <td class="text-center">${b.roomID}</td>
                                <td class="text-center">${b.checkInDate}</td>
                                <td class="text-center">${b.checkOutDate}</td>
                                <td class="text-end text-danger fw-bold">${b.totalAmount}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${b.bookingStatus == 'Pending'}">
                                            <span class="badge bg-warning text-dark">Chờ duyệt</span>
                                        </c:when>
                                        <c:when test="${b.bookingStatus == 'Confirmed'}">
                                            <span class="badge bg-success">Đã xác nhận</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${b.bookingStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <span class="badge ${b.paymentStatus == 'Paid' ? 'bg-success' : 'bg-danger'}">
                                        ${b.paymentStatus == 'Paid' ? 'Đã thanh toán' : 'Chưa thanh toán'}
                                    </span>
                                </td>
                                <td class="text-center">${b.createdAt}</td>
                                <td class="text-center">
                                    <c:if test="${b.paymentStatus == 'Paid' || b.bookingStatus == 'CheckedOut'}">
                                        <a href="${pageContext.request.contextPath}/booking?action=invoice&id=${b.bookingID}" class="btn btn-sm btn-outline-primary py-1 px-2">
                                            <i class="fa-solid fa-file-invoice"></i> Hóa đơn
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bookingList}">
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">Bạn chưa thực hiện đơn đặt phòng nào.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
            <div class="text-start mt-4">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                    <i class="fa-solid fa-hotel me-1"></i> Quay lại Trang chủ đặt phòng
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

</body>
</html>