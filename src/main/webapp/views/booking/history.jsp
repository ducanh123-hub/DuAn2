<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Lịch sử đặt phòng - Luxury Hotel</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5 mb-5">

    <div class="card shadow border-0">

        <div class="card-header bg-dark text-white py-3">
            <h4 class="mb-0">
                <i class="fa-solid fa-clock-rotate-left me-2"></i>
                Lịch sử đặt phòng của bạn
            </h4>
        </div>

        <div class="card-body">

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check me-2"></i>
                    ${success}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i>
                    ${error}
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty bookingList}">

                    <div class="table-responsive">

                        <table class="table table-bordered table-striped table-hover align-middle">

                            <thead class="table-dark">

                                <tr class="text-center">
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

                                <c:forEach items="${bookingList}" var="b">

                                    <tr>

                                        <td class="text-center fw-bold text-success">
                                            ${b.bookingCode}
                                        </td>

                                        <td class="text-center">
                                            ${b.roomID}
                                        </td>

                                        <td class="text-center">
                                            ${b.checkInDate}
                                        </td>

                                        <td class="text-center">
                                            ${b.checkOutDate}
                                        </td>

                                        <td class="text-end text-danger fw-bold">
                                            ${b.totalAmount} VNĐ
                                        </td>

                                        <td class="text-center">

                                            <c:choose>
                                                <c:when test="${b.status == 'Chờ xác nhận'}">
                                                    <span class="badge bg-warning text-dark">
                                                        <i class="fa-solid fa-clock me-1"></i>
                                                        Chờ xác nhận
                                                    </span>
                                                </c:when>

                                                <c:when test="${b.status == 'Đã xác nhận'}">
                                                    <span class="badge bg-success">
                                                        <i class="fa-solid fa-circle-check me-1"></i>
                                                        Đã xác nhận
                                                    </span>
                                                </c:when>

                                                <c:when test="${b.status == 'Đã trả phòng'}">
                                                    <span class="badge bg-secondary">
                                                        <i class="fa-solid fa-door-open me-1"></i>
                                                        Đã trả phòng
                                                    </span>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="badge bg-secondary">
                                                        ${b.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>

                                        </td>

                                        <td class="text-center">
                                            ${b.createdAt}
                                        </td>

                                        <td class="text-center">

                                            <c:choose>
                                                <c:when test="${b.status == 'Đã trả phòng'}">

                                                    <a
                                                        href="${pageContext.request.contextPath}/booking?action=invoice&id=${b.bookingID}"
                                                        class="btn btn-sm btn-outline-primary">

                                                        <i class="fa-solid fa-file-invoice me-1"></i>
                                                        Hóa đơn

                                                    </a>

                                                </c:when>

                                                <c:otherwise>

                                                    <span class="text-muted small">
                                                        Chưa có hóa đơn
                                                    </span>

                                                </c:otherwise>
                                            </c:choose>

                                        </td>

                                    </tr>

                                </c:forEach>

                            </tbody>

                        </table>

                    </div>

                </c:when>

                <c:otherwise>

                    <div class="text-center text-muted py-5">

                        <i
                            class="fa-solid fa-calendar-xmark mb-3"
                            style="font-size: 45px;">
                        </i>

                        <h5 class="fw-bold">
                            Chưa có đơn đặt phòng
                        </h5>

                        <p>
                            Bạn chưa thực hiện đơn đặt phòng nào.
                        </p>

                        <a
                            href="${pageContext.request.contextPath}/home"
                            class="btn btn-primary">

                            <i class="fa-solid fa-hotel me-1"></i>
                            Đặt phòng ngay

                        </a>

                    </div>

                </c:otherwise>
            </c:choose>

            <div class="text-start mt-4">

                <a
                    href="${pageContext.request.contextPath}/home"
                    class="btn btn-primary">

                    <i class="fa-solid fa-house me-1"></i>
                    Quay lại Trang chủ

                </a>

            </div>

        </div>

    </div>

</div>

<jsp:include page="../layout/footer.jsp"/>

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>