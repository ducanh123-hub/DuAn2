<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Quản lý Đặt phòng - Luxury Hotel</title>

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

    <div class="row">

        <!-- SIDEBAR -->

        <div class="col-md-3 mb-4">

            <jsp:include page="../layout/sidebar.jsp"/>

        </div>


        <!-- CONTENT -->

        <div class="col-md-9">

            <div class="card shadow border-0">

                <!-- HEADER -->

                <div
                    class="card-header bg-dark text-white py-3 d-flex justify-content-between align-items-center">

                    <h4 class="mb-0">

                        <i class="fa-solid fa-calendar-check me-2"></i>

                        Danh sách đơn đặt phòng

                    </h4>

                    <span class="badge bg-secondary">

                        ${bookingList.size()} đơn

                    </span>

                </div>


                <div class="card-body p-4">


                    <!-- THÔNG BÁO -->

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


                    <!-- BẢNG ĐẶT PHÒNG -->

                    <div class="table-responsive">

                        <table
                            class="table table-bordered table-striped table-hover align-middle">

                            <thead class="table-dark">

                                <tr class="text-center">

                                    <th>Mã đơn</th>

                                    <th>Khách hàng</th>

                                    <th>Phòng</th>

                                    <th>Ngày ở</th>

                                    <th>Số khách</th>

                                    <th>Tổng tiền</th>

                                    <th>Trạng thái</th>

                                    <th>Hành động</th>

                                </tr>

                            </thead>


                            <tbody>

                                <c:forEach
                                    items="${bookingList}"
                                    var="b">

                                    <tr>

                                        <!-- MÃ ĐƠN -->

                                        <td class="text-center">

                                            <strong class="text-success">

                                                ${b.bookingCode}

                                            </strong>

                                        </td>


                                        <!-- KHÁCH HÀNG -->

                                        <td>

                                            <c:forEach
                                                items="${userList}"
                                                var="u">

                                                <c:if test="${u.userID == b.userID}">

                                                    <strong>

                                                        ${u.fullName}

                                                    </strong>

                                                    <span
                                                        class="d-block text-muted small">

                                                        ${u.phone}

                                                    </span>

                                                    <span
                                                        class="d-block text-muted small">

                                                        ${u.email}

                                                    </span>

                                                </c:if>

                                            </c:forEach>

                                        </td>


                                        <!-- PHÒNG -->

                                        <td>

                                            <c:forEach
                                                items="${roomList}"
                                                var="r">

                                                <c:if test="${r.roomID == b.roomID}">

                                                    <strong>

                                                        P. ${r.roomNumber}

                                                    </strong>

                                                    <span
                                                        class="d-block text-muted small">

                                                        ${r.roomName}

                                                    </span>

                                                </c:if>

                                            </c:forEach>

                                        </td>


                                        <!-- NGÀY Ở -->

                                        <td class="text-center small">

                                            <span
                                                class="d-block text-success">

                                                <i class="fa-solid fa-calendar-plus me-1"></i>

                                                ${b.checkInDate}

                                            </span>

                                            <span
                                                class="d-block text-danger mt-1">

                                                <i class="fa-solid fa-calendar-minus me-1"></i>

                                                ${b.checkOutDate}

                                            </span>

                                        </td>


                                        <!-- SỐ KHÁCH -->

                                        <td class="text-center">

                                            <span class="badge bg-info text-dark">

                                                <i class="fa-solid fa-users me-1"></i>

                                                ${b.guestCount}

                                            </span>

                                        </td>


                                        <!-- TỔNG TIỀN -->

                                        <td class="text-end">

                                            <strong class="text-danger">

                                                ${b.totalAmount} VNĐ

                                            </strong>

                                        </td>


                                        <!-- TRẠNG THÁI -->

                                        <td class="text-center">

                                            <c:choose>

                                                <c:when
                                                    test="${b.status == 'Chờ xác nhận'}">

                                                    <span
                                                        class="badge bg-warning text-dark">

                                                        <i
                                                            class="fa-solid fa-clock me-1">
                                                        </i>

                                                        Chờ xác nhận

                                                    </span>

                                                </c:when>


                                                <c:when
                                                    test="${b.status == 'Đã xác nhận'}">

                                                    <span
                                                        class="badge bg-success">

                                                        <i
                                                            class="fa-solid fa-circle-check me-1">
                                                        </i>

                                                        Đã xác nhận

                                                    </span>

                                                </c:when>


                                                <c:when
                                                    test="${b.status == 'Đã trả phòng'}">

                                                    <span
                                                        class="badge bg-secondary">

                                                        <i
                                                            class="fa-solid fa-door-open me-1">
                                                        </i>

                                                        Đã trả phòng

                                                    </span>

                                                </c:when>


                                                <c:otherwise>

                                                    <span
                                                        class="badge bg-secondary">

                                                        ${b.status}

                                                    </span>

                                                </c:otherwise>

                                            </c:choose>

                                        </td>


                                        <!-- HÀNH ĐỘNG -->

                                        <td class="text-center">

                                            <div
                                                class="d-flex flex-column gap-1">


                                                <!-- CHỜ XÁC NHẬN -->

                                                <c:if
                                                    test="${b.status == 'Chờ xác nhận'}">

                                                    <a
                                                        href="${pageContext.request.contextPath}/booking?action=checkin&id=${b.bookingID}"
                                                        class="btn btn-sm btn-success">

                                                        <i
                                                            class="fa-solid fa-check me-1">
                                                        </i>

                                                        Xác nhận

                                                    </a>

                                                </c:if>


                                                <!-- ĐÃ XÁC NHẬN -->

                                                <c:if
                                                    test="${b.status == 'Đã xác nhận'}">

                                                    <a
                                                        href="${pageContext.request.contextPath}/booking?action=checkout&id=${b.bookingID}"
                                                        class="btn btn-sm btn-danger">

                                                        <i
                                                            class="fa-solid fa-right-from-bracket me-1">
                                                        </i>

                                                        Check-out

                                                    </a>

                                                </c:if>


                                                <!-- ĐÃ TRẢ PHÒNG -->

                                                <c:if
                                                    test="${b.status == 'Đã trả phòng'}">

                                                    <a
                                                        href="${pageContext.request.contextPath}/booking?action=invoice&id=${b.bookingID}"
                                                        class="btn btn-sm btn-outline-primary">

                                                        <i
                                                            class="fa-solid fa-file-invoice me-1">
                                                        </i>

                                                        Hóa đơn

                                                    </a>

                                                </c:if>


                                            </div>

                                        </td>

                                    </tr>

                                </c:forEach>


                                <!-- KHÔNG CÓ ĐƠN -->

                                <c:if test="${empty bookingList}">

                                    <tr>

                                        <td
                                            colspan="8"
                                            class="text-center text-muted py-5">

                                            <i
                                                class="fa-solid fa-calendar-xmark d-block mb-3"
                                                style="font-size: 40px;">
                                            </i>

                                            <h5>

                                                Không có đơn đặt phòng

                                            </h5>

                                            <p class="mb-0">

                                                Hiện tại chưa có đơn đặt phòng nào.

                                            </p>

                                        </td>

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


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>