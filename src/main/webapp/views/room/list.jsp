<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách phòng - Luxury Hotel</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body {
            background: #f5f7fa;
        }

        .room-list-container {
            max-width: 1200px;
            margin: 40px auto;
        }

        .room-list-header {
            background: #212529;
            color: white;
            padding: 18px 25px;
            border-radius: 8px 8px 0 0;
        }

        .room-list-header h3 {
            margin: 0;
            font-weight: 600;
        }

        /* CARD PHÒNG */
        .room-card {
            display: flex;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 18px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
            min-height: 250px;
            transition: all 0.2s ease;
        }

        .room-card:hover {
            box-shadow: 0 5px 18px rgba(0, 0, 0, 0.18);
            transform: translateY(-2px);
        }

        /* ẢNH */
        .room-image {
            width: 280px;
            min-width: 280px;
            height: 250px;
            object-fit: cover;
        }

        .room-image-box {
            position: relative;
            width: 280px;
            min-width: 280px;
        }

        /* TRẠNG THÁI */
        .room-status {
            position: absolute;
            top: 12px;
            right: 12px;
            padding: 8px 13px;
            border-radius: 6px;
            font-weight: bold;
            font-size: 14px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.25);
        }

        .status-available {
            background: #198754;
            color: white;
        }

        .status-occupied {
            background: #dc3545;
            color: white;
        }

        .status-maintenance {
            background: #ffc107;
            color: #212529;
        }

        /* NỘI DUNG */
        .room-content {
            flex: 1;
            padding: 20px;
            display: flex;
            flex-direction: column;
        }

        .room-name {
            font-size: 21px;
            font-weight: 700;
            color: #212529;
            margin-bottom: 8px;
        }

        .room-number {
            color: #0d6efd;
            font-weight: 600;
        }

        .room-description {
            color: #6c757d;
            margin-bottom: 15px;
            line-height: 1.5;
        }

        .room-info {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 15px;
        }

        .room-info-item {
            background: #f1f3f5;
            padding: 5px 9px;
            border-radius: 4px;
            font-size: 13px;
            color: #343a40;
        }

        .room-info-item i {
            margin-right: 4px;
            color: #0d6efd;
        }

        /* KHU VỰC GIÁ */
        .room-bottom {
            margin-top: auto;
            border-top: 1px solid #e9ecef;
            padding-top: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }

        .price-label {
            color: #6c757d;
            font-size: 13px;
            display: block;
        }

        .room-price {
            color: #ff5722;
            font-size: 22px;
            font-weight: 700;
            white-space: nowrap;
        }

        .price-unit {
            color: #6c757d;
            font-size: 12px;
            display: block;
            text-align: right;
        }

        /* NÚT */
        .btn-book {
            background: #0d9bea;
            border: none;
            color: white;
            font-weight: 600;
            border-radius: 25px;
            padding: 11px 22px;
            white-space: nowrap;
        }

        .btn-book:hover {
            background: #087fc2;
            color: white;
        }

        .btn-detail {
            border-radius: 20px;
            padding: 8px 16px;
        }

        .admin-actions {
            margin-top: 12px;
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {

            .room-card {
                flex-direction: column;
            }

            .room-image-box {
                width: 100%;
                min-width: 100%;
            }

            .room-image {
                width: 100%;
                min-width: 100%;
                height: 230px;
            }

            .room-bottom {
                flex-direction: column;
                align-items: stretch;
            }

            .price-unit {
                text-align: left;
            }

            .btn-book {
                width: 100%;
            }
        }
    </style>
</head>

<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container room-list-container">

    <!-- HEADER -->
    <div class="room-list-header d-flex justify-content-between align-items-center">

        <h3>
            <i class="fa-solid fa-bed me-2"></i>
            Danh sách phòng
        </h3>

        <!-- ADMIN: THÊM PHÒNG -->
        <c:if test="${sessionScope.user != null && sessionScope.user.roleID == 1}">
            <a href="${pageContext.request.contextPath}/room?action=add"
               class="btn btn-success">

                <i class="fa-solid fa-plus me-1"></i>
                Thêm phòng
            </a>
        </c:if>

    </div>


    <div class="bg-transparent pt-3">

        <!-- DANH SÁCH PHÒNG -->
        <c:forEach items="${list}" var="room">

            <div class="room-card">

                <!-- ==================== ẢNH ==================== -->
                <div class="room-image-box">

                    <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=700&q=80"
                         class="room-image"
                         alt="${room.roomName}"
                         onerror="this.src='https://placehold.co/700x500?text=Luxury+Room';">

                    <!-- TRẠNG THÁI -->
                    <c:choose>

                        <c:when test="${room.status == 'Available'}">

                            <span class="room-status status-available">
                                <i class="fa-solid fa-circle-check me-1"></i>
                                Còn trống
                            </span>

                        </c:when>

                        <c:when test="${room.status == 'Occupied'}">

                            <span class="room-status status-occupied">
                                <i class="fa-solid fa-circle-xmark me-1"></i>
                                Đang có khách
                            </span>

                        </c:when>

                        <c:otherwise>

                            <span class="room-status status-maintenance">
                                <i class="fa-solid fa-screwdriver-wrench me-1"></i>
                                Bảo trì
                            </span>

                        </c:otherwise>

                    </c:choose>

                </div>


                <!-- ==================== THÔNG TIN PHÒNG ==================== -->
                <div class="room-content">

                    <!-- TÊN PHÒNG -->
                    <div class="room-name">

                        ${room.roomName}

                        <span class="room-number">
                            - Phòng ${room.roomNumber}
                        </span>

                    </div>


                    <!-- MÔ TẢ -->
                    <div class="room-description">

                        <c:choose>

                            <c:when test="${not empty room.description}">
                                ${room.description}
                            </c:when>

                            <c:otherwise>
                                Phòng nghỉ sang trọng, đầy đủ tiện nghi,
                                không gian thoải mái và hiện đại.
                            </c:otherwise>

                        </c:choose>

                    </div>


                    <!-- THÔNG TIN -->
                    <div class="room-info">

                        <span class="room-info-item">
                            <i class="fa-solid fa-bed"></i>
                            ${room.bed} giường
                        </span>

                        <span class="room-info-item">
                            <i class="fa-solid fa-ruler-combined"></i>
                            ${room.acreage} m²
                        </span>

                        <span class="room-info-item">
                            <i class="fa-solid fa-location-dot"></i>
                            ${room.area}
                        </span>

                        <span class="room-info-item">
                            <i class="fa-solid fa-layer-group"></i>
                            Loại ${room.categoryID}
                        </span>

                    </div>


                    <!-- ==================== GIÁ + NÚT ==================== -->
                    <div class="room-bottom">

                        <div>

                            <span class="price-label">
                                Giá trung bình
                            </span>

                            <span class="room-price">

                                <fmt:formatNumber
                                        value="${room.price}"
                                        type="number"
                                        groupingUsed="true"
                                        maxFractionDigits="0"/>

                                VNĐ

                            </span>

                            <span class="price-unit">
                                phòng/đêm
                            </span>

                        </div>


                        <div>

                            <!-- NÚT CHỌN PHÒNG KHI CÒN TRỐNG -->
                            <c:if test="${room.status == 'Available'}">

                                <a href="${pageContext.request.contextPath}/booking?roomId=${room.roomID}"
                                   class="btn btn-book">

                                    <i class="fa-solid fa-calendar-check me-1"></i>
                                    Chọn phòng

                                </a>

                            </c:if>


                            <!-- PHÒNG KHÔNG CÒN TRỐNG -->
                            <c:if test="${room.status != 'Available'}">

                                <button type="button"
                                        class="btn btn-secondary"
                                        disabled>

                                    <i class="fa-solid fa-lock me-1"></i>
                                    Không thể đặt

                                </button>

                            </c:if>


                            <!-- ADMIN -->
                            <c:if test="${sessionScope.user != null && sessionScope.user.roleID == 1}">

                                <div class="admin-actions">

                                    <!-- CHI TIẾT -->
                                    <a href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                                       class="btn btn-info btn-sm text-white btn-detail">

                                        <i class="fa-solid fa-eye"></i>
                                        Chi tiết

                                    </a>


                                    <!-- SỬA -->
                                    <a href="${pageContext.request.contextPath}/room?action=edit&id=${room.roomID}"
                                       class="btn btn-warning btn-sm btn-detail">

                                        <i class="fa-solid fa-pen-to-square"></i>
                                        Sửa

                                    </a>


                                    <!-- XÓA -->
                                    <a href="${pageContext.request.contextPath}/room?action=delete&id=${room.roomID}"
                                       class="btn btn-danger btn-sm btn-detail"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa phòng này?')">

                                        <i class="fa-solid fa-trash"></i>
                                        Xóa

                                    </a>

                                </div>

                            </c:if>

                        </div>

                    </div>

                </div>

            </div>

        </c:forEach>


        <!-- KHÔNG CÓ PHÒNG -->
        <c:if test="${empty list}">

            <div class="card shadow-sm border-0 text-center py-5">

                <div class="text-muted">

                    <i class="fa-solid fa-hotel fa-3x mb-3 text-warning"></i>

                    <h5>Chưa có phòng nào</h5>

                    <p class="mb-0">
                        Hiện tại hệ thống chưa có phòng nào trong danh sách.
                    </p>

                </div>

            </div>

        </c:if>

    </div>

</div>


<jsp:include page="../layout/footer.jsp"/>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>