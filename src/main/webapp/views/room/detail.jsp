<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Chi tiết phòng</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/room.css">

</head>

<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">

    <div class="card shadow border-0">

        <div class="card-header bg-dark text-white">

            <h3 class="mb-0">
                <i class="fa-solid fa-circle-info me-2"></i>
                Chi tiết phòng
            </h3>

        </div>

        <div class="card-body">

            <div class="row">

                <div class="col-md-4 text-center">

                    <img src="${pageContext.request.contextPath}/images/no-image.png"
                         class="img-fluid rounded shadow-sm"
                         alt="Room"
                         onerror="this.src='https://placehold.co/600x400?text=No+Image';">

                </div>

                <div class="col-md-8">

                    <table class="table table-bordered table-striped">

                        <tr>
                            <th width="200">Mã phòng</th>
                            <td>${room.roomID}</td>
                        </tr>

                        <tr>
                            <th>Số phòng</th>
                            <td>${room.roomNumber}</td>
                        </tr>

                        <tr>
                            <th>Tên phòng</th>
                            <td>${room.roomName}</td>
                        </tr>

                        <tr>
                            <th>Loại phòng</th>
                            <td>${room.categoryID}</td>
                        </tr>

                        <!-- GIÁ PHÒNG -->
                        <tr>
                            <th>Giá</th>
                            <td class="text-danger fw-bold">
                                <fmt:formatNumber
                                        value="${room.price}"
                                        type="number"
                                        groupingUsed="true"
                                        maxFractionDigits="0"/> VNĐ
                            </td>
                        </tr>

                        <tr>
                            <th>Diện tích</th>
                            <td>${room.acreage} m²</td>
                        </tr>

                        <tr>
                            <th>Số giường</th>
                            <td>${room.bed}</td>
                        </tr>

                        <tr>
                            <th>Khu vực</th>
                            <td>${room.area}</td>
                        </tr>

                        <tr>
                            <th>Trạng thái</th>
                            <td>
                                <span class="badge ${room.status == 'Available' ? 'bg-success' : 'bg-warning'}">
                                    ${room.status}
                                </span>
                            </td>
                        </tr>

                        <tr>
                            <th>Mô tả</th>
                            <td>${room.description}</td>
                        </tr>

                        <tr>
                            <th>Ngày tạo</th>
                            <td>${room.createdAt}</td>
                        </tr>

                        <tr>
                            <th>Cập nhật</th>
                            <td>${room.updatedAt}</td>
                        </tr>

                    </table>

                    <div class="mt-4">

                        <a href="${pageContext.request.contextPath}/room"
                           class="btn btn-secondary me-2">

                            <i class="fa-solid fa-arrow-left me-1"></i>
                            Quay lại

                        </a>

                        <a href="${pageContext.request.contextPath}/booking?roomId=${room.roomID}"
                           class="btn btn-success me-2">

                            <i class="fa-solid fa-calendar-check me-1"></i>
                            Đặt phòng ngay

                        </a>

                        <c:if test="${sessionScope.user != null && sessionScope.user.roleID == 1}">

                            <a href="${pageContext.request.contextPath}/room?action=edit&id=${room.roomID}"
                               class="btn btn-warning">

                                <i class="fa-solid fa-pen-to-square me-1"></i>
                                Chỉnh sửa

                            </a>

                        </c:if>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

<jsp:include page="../layout/footer.jsp"/>

</body>

</html>