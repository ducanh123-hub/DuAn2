<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Danh sách phòng - Luxury Hotel</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <!-- CSS project -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">


    <style>

        /* =====================================================
           GENERAL
        ===================================================== */

        body {
            margin: 0;
            padding: 0;
            background: #f8f9fa;
            color: #212529;
        }


        /* =====================================================
           PAGE CONTAINER
        ===================================================== */

        .room-list-container {
            max-width: 1200px;
            margin: 110px auto 50px;
        }


        /* =====================================================
           HEADER
        ===================================================== */

        .room-list-header {
            background: #002b4d;
            color: white;

            padding: 20px 25px;

            border-radius: 14px;

            margin-bottom: 25px;

            box-shadow:
                    0 8px 25px rgba(0, 0, 0, .12);
        }


        .room-list-header h3 {
            margin: 0;

            font-weight: 700;
        }


        .room-list-header .btn {
            border-radius: 8px;

            font-weight: 600;
        }


        /* =====================================================
           ROOM GRID
        ===================================================== */

        .room-grid {
            display: grid;

            grid-template-columns:
                    repeat(2, minmax(0, 1fr));

            gap: 24px;
        }


        /* =====================================================
           ROOM CARD
           Đồng bộ với index.jsp
        ===================================================== */

        .room-card {
            border: none;

            border-radius: 14px;

            overflow: hidden;

            transition:
                    transform .25s ease,
                    box-shadow .25s ease;

            background: #fff;

            height: 100%;

            box-shadow:
                    0 4px 15px rgba(0, 0, 0, .08);
        }


        .room-card:hover {

            transform: translateY(-6px);

            box-shadow:
                    0 15px 30px rgba(0, 0, 0, .14);
        }


        /* =====================================================
           IMAGE
        ===================================================== */

        .room-image-wrapper {

            position: relative;

            overflow: hidden;
        }


        .room-image {

            width: 100%;

            height: 250px;

            object-fit: cover;

            display: block;

            transition:
                    transform .4s ease;
        }


        .room-card:hover .room-image {

            transform: scale(1.05);
        }


        /* =====================================================
           IMAGE OVERLAY
        ===================================================== */

        .room-overlay {

            position: absolute;

            inset: 0;

            background:
                    linear-gradient(
                            to top,
                            rgba(0,0,0,.40),
                            transparent 55%
                    );

            pointer-events: none;
        }


        /* =====================================================
           STATUS
        ===================================================== */

        .room-status {

            position: absolute;

            top: 12px;

            right: 12px;

            padding: 7px 12px;

            border-radius: 20px;

            font-size: 12px;

            font-weight: 700;

            background: rgba(0,0,0,.72);

            color: #ffc107;

            z-index: 3;
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


        /* =====================================================
           ROOM TYPE
        ===================================================== */

        .room-type {

            position: absolute;

            bottom: 12px;

            left: 12px;

            padding: 6px 11px;

            border-radius: 20px;

            background:
                    rgba(255,255,255,.92);

            color: #002b4d;

            font-size: 12px;

            font-weight: 700;

            z-index: 3;
        }


        /* =====================================================
           ROOM BODY
        ===================================================== */

        .room-body {

            padding: 20px;
        }


        .room-name {

            min-height: 30px;

            color: #002b4d;

            font-size: 20px;

            font-weight: 800;

            margin-bottom: 8px;
        }


        .room-number {

            color: #0d6efd;

            font-size: 14px;

            font-weight: 600;
        }


        .room-description {

            min-height: 45px;

            display: -webkit-box;

            -webkit-line-clamp: 2;

            -webkit-box-orient: vertical;

            overflow: hidden;

            color: #6c757d;

            font-size: 14px;

            line-height: 1.5;

            margin-bottom: 15px;
        }


        /* =====================================================
           ROOM META
        ===================================================== */

        .room-meta {

            display: flex;

            flex-wrap: wrap;

            gap: 6px;

            margin-bottom: 18px;
        }


        .room-meta .badge {

            font-weight: 500;

            padding: 7px 9px;

            border-radius: 7px;
        }


        .room-meta .badge i {

            color: #0d6efd;
        }


        /* =====================================================
           PRICE
        ===================================================== */

        .room-price-area {

            border-top:
                    1px solid #e9ecef;

            padding-top: 15px;
        }


        .price-label {

            color: #6c757d;

            font-size: 12px;

            display: block;

            margin-bottom: 3px;
        }


        .room-price {

            color: #e53935;

            font-weight: 800;

            font-size: 20px;

            white-space: nowrap;
        }


        /* =====================================================
           BUTTONS
        ===================================================== */

        .room-buttons {

            display: flex;

            gap: 7px;

            flex-wrap: wrap;

            justify-content: flex-end;
        }


        .room-buttons .btn {

            border-radius: 8px;

            font-size: 12px;

            font-weight: 600;
        }


        .room-buttons .btn-book {

            background: #198754;

            border-color: #198754;

            color: white;
        }


        .room-buttons .btn-book:hover {

            background: #157347;

            border-color: #157347;

            color: white;
        }


        /* =====================================================
           ADMIN ACTIONS
        ===================================================== */

        .admin-actions {

            display: flex;

            gap: 6px;

            margin-top: 10px;

            padding-top: 10px;

            border-top:
                    1px dashed #dee2e6;
        }


        .admin-actions .btn {

            border-radius: 7px;

            font-size: 12px;

            font-weight: 600;
        }


        /* =====================================================
           EMPTY
        ===================================================== */

        .empty-room {

            background: white;

            border-radius: 14px;

            padding: 70px 20px;

            text-align: center;

            box-shadow:
                    0 4px 15px rgba(0,0,0,.06);
        }


        .empty-room i {

            color: #ffc107;
        }


        /* =====================================================
           PAGINATION
        ===================================================== */

        .pagination-wrapper {

            display: flex;

            justify-content: center;

            align-items: center;

            margin-top: 35px;

            margin-bottom: 20px;
        }


        .pagination {

            margin: 0;

            gap: 5px;
        }


        .pagination .page-link {

            min-width: 42px;

            height: 42px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 8px !important;

            color: #002b4d;

            background: white;

            border:
                    1px solid #dee2e6;

            font-weight: 600;

            transition: .2s ease;
        }


        .pagination .page-link:hover {

            background: #eef5ff;

            border-color: #002b4d;

            color: #002b4d;
        }


        .pagination .page-item.active .page-link {

            background: #002b4d;

            border-color: #002b4d;

            color: white;
        }


        .pagination .page-item.disabled .page-link {

            background: #e9ecef;

            color: #6c757d;

            border-color: #dee2e6;
        }


        /* =====================================================
           RESPONSIVE
        ===================================================== */

        @media (max-width: 991px) {

            .room-grid {

                grid-template-columns:
                        repeat(2, minmax(0, 1fr));
            }

        }


        @media (max-width: 767px) {

            .room-list-container {

                margin-top: 90px;

                padding-left: 15px;

                padding-right: 15px;
            }


            .room-list-header {

                flex-direction: column;

                align-items: flex-start !important;

                gap: 15px;
            }


            .room-list-header .btn {

                width: 100%;
            }


            .room-grid {

                grid-template-columns:
                        1fr;
            }


            .room-image {

                height: 230px;
            }


            .room-buttons {

                justify-content: flex-start;

                margin-top: 15px;
            }

        }


        @media (max-width: 576px) {

            .room-list-container {

                margin-top: 80px;
            }


            .room-body {

                padding: 16px;
            }


            .room-name {

                font-size: 18px;
            }


            .room-price {

                font-size: 18px;
            }

        }

    </style>

</head>


<body>


<!-- =====================================================
     HEADER
===================================================== -->

<jsp:include page="../layout/header.jsp"/>


<div class="container room-list-container">


    <!-- =====================================================
         PAGE HEADER
    ===================================================== -->

    <div class="room-list-header
                d-flex
                justify-content-between
                align-items-center">

        <h3>

            <i class="fa-solid fa-bed me-2"></i>

            Danh sách phòng

        </h3>


        <!-- ADMIN: THÊM PHÒNG -->

        <c:if test="${sessionScope.user != null &&
                     sessionScope.user.roleID == 1}">

            <a href="${pageContext.request.contextPath}/room?action=add"
               class="btn btn-warning">

                <i class="fa-solid fa-plus me-1"></i>

                Thêm phòng

            </a>

        </c:if>

    </div>


    <!-- =====================================================
         PAGINATION CALCULATION
    ===================================================== -->

    <c:set var="pageSize"
           value="6"/>


    <c:set var="totalRooms"
           value="${list.size()}"/>


    <c:set var="totalPages"
           value="${(totalRooms + pageSize - 1) / pageSize}"/>


    <c:set var="currentPageParam"
           value="${param.page}"/>


    <c:choose>

        <c:when test="${not empty currentPageParam}">

            <c:set var="currentPage"
                       value="${currentPageParam}"/>

        </c:when>

        <c:otherwise>

            <c:set var="currentPage"
                       value="1"/>

        </c:otherwise>

    </c:choose>


    <c:if test="${currentPage < 1}">

        <c:set var="currentPage"
                   value="1"/>

    </c:if>


    <c:if test="${currentPage > totalPages &&
                 totalPages > 0}">

        <c:set var="currentPage"
                   value="${totalPages}"/>

    </c:if>


    <c:set var="startIndex"
           value="${(currentPage - 1) * pageSize}"/>


    <c:set var="endIndex"
           value="${startIndex + pageSize - 1}"/>


    <!-- =====================================================
         ROOM LIST
    ===================================================== -->

    <c:if test="${not empty list}">

        <div class="room-grid">


            <c:forEach items="${list}"
                       var="room"
                       begin="${startIndex}"
                       end="${endIndex}">


                <!-- =================================================
                     ROOM CARD
                ================================================= -->

                <div class="room-card">


                    <!-- =================================================
                         IMAGE
                         LẤY Y HỆT LOGIC TỪ INDEX.JSP
                    ================================================= -->

                    <div class="room-image-wrapper">


                        <c:choose>

                            <c:when test="${room.roomName.contains('Standard')}">

                                <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=800&q=85"
                                     class="room-image"
                                     alt="${room.roomName}"
                                     onerror="this.src='https://placehold.co/800x500?text=Standard+Room';">

                            </c:when>

                            <c:when test="${room.roomName.contains('Deluxe')}">

                                <img src="https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=85"
                                     class="room-image"
                                     alt="${room.roomName}"
                                     onerror="this.src='https://placehold.co/800x500?text=Deluxe+Room';">

                            </c:when>

                            <c:when test="${room.roomName.contains('Suite')}">

                                <img src="https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=800&q=85"
                                     class="room-image"
                                     alt="${room.roomName}"
                                     onerror="this.src='https://placehold.co/800x500?text=Suite+Room';">

                            </c:when>

                            <c:when test="${room.roomName.contains('Family')}">

                                <img src="https://images.unsplash.com/photo-1595576508898-0ad5c879a061?auto=format&fit=crop&w=800&q=85"
                                     class="room-image"
                                     alt="${room.roomName}"
                                     onerror="this.src='https://placehold.co/800x500?text=Family+Room';">

                            </c:when>

                            <c:otherwise>

                                <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=85"
                                     class="room-image"
                                     alt="${room.roomName}"
                                     onerror="this.src='https://placehold.co/800x500?text=Luxury+Room';">

                            </c:otherwise>

                        </c:choose>


                        <!-- OVERLAY -->

                        <div class="room-overlay"></div>


                        <!-- =================================================
                             STATUS
                        ================================================== -->

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

                                    ${room.status}

                                </span>

                            </c:otherwise>


                        </c:choose>


                        <!-- =================================================
                             ROOM TYPE
                        ================================================== -->

                        <c:choose>


                            <c:when test="${room.roomName.contains('Standard')}">

                                <span class="room-type">

                                    Standard

                                </span>

                            </c:when>


                            <c:when test="${room.roomName.contains('Deluxe')}">

                                <span class="room-type">

                                    Deluxe

                                </span>

                            </c:when>


                            <c:when test="${room.roomName.contains('Suite')}">

                                <span class="room-type">

                                    Suite

                                </span>

                            </c:when>


                            <c:when test="${room.roomName.contains('Family')}">

                                <span class="room-type">

                                    Family

                                </span>

                            </c:when>


                        </c:choose>


                    </div>


                    <!-- =================================================
                         ROOM BODY
                    ================================================== -->

                    <div class="room-body">


                        <!-- ROOM NAME -->

                        <div class="room-name">

                            ${room.roomName}

                            <span class="room-number">

                                - Phòng ${room.roomNumber}

                            </span>

                        </div>


                        <!-- DESCRIPTION -->

                        <div class="room-description">


                            <c:choose>


                                <c:when test="${not empty room.description}">

                                    ${room.description}

                                </c:when>


                                <c:otherwise>

                                    Phòng đầy đủ tiện nghi,
                                    không gian thoải mái và hiện đại.

                                </c:otherwise>


                            </c:choose>


                        </div>


                        <!-- =================================================
                             META
                        ================================================== -->

                        <div class="room-meta">


                            <!-- BED -->

                            <span class="badge bg-light text-dark border">

                                <i class="fa-solid fa-bed me-1"></i>

                                ${room.bed} giường

                            </span>


                            <!-- AREA -->

                            <span class="badge bg-light text-dark border">

                                <i class="fa-solid fa-expand me-1"></i>

                                <fmt:formatNumber
                                        value="${room.acreage}"
                                        type="number"
                                        groupingUsed="true"
                                        minFractionDigits="0"
                                        maxFractionDigits="2"/>

                                m²

                            </span>


                            <!-- LOCATION -->

                            <span class="badge bg-light text-dark border">

                                <i class="fa-solid fa-location-dot me-1"></i>

                                ${room.area}

                            </span>


                        </div>


                        <!-- =================================================
                             PRICE
                        ================================================== -->

                        <div class="room-price-area">


                            <div class="d-flex
                                        justify-content-between
                                        align-items-center
                                        flex-wrap
                                        gap-3">


                                <div>

                                    <span class="price-label">

                                        Giá phòng / đêm

                                    </span>


                                    <div class="room-price">

                                        <fmt:formatNumber
                                                value="${room.price}"
                                                type="number"
                                                groupingUsed="true"
                                                minFractionDigits="0"
                                                maxFractionDigits="0"/>

                                        VNĐ

                                    </div>

                                </div>


                                <!-- =================================================
                                     BUTTONS
                                ================================================== -->

                                <div class="room-buttons">


                                    <!-- CHI TIẾT -->

                                    <a href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                                       class="btn btn-outline-primary btn-sm"
                                       title="Xem chi tiết">

                                        <i class="fa-solid fa-eye"></i>

                                    </a>


                                    <!-- ĐẶT PHÒNG -->

                                    <a href="${pageContext.request.contextPath}/booking?roomId=${room.roomID}"
                                       class="btn btn-book btn-sm">

                                        <i class="fa-solid fa-calendar-check me-1"></i>

                                        Đặt

                                    </a>


                                </div>


                            </div>


                            <!-- =================================================
                                 ADMIN ACTIONS
                            ================================================== -->

                            <c:if test="${sessionScope.user != null &&
                                         sessionScope.user.roleID == 1}">


                                <div class="admin-actions">


                                    <!-- SỬA -->

                                    <a href="${pageContext.request.contextPath}/room?action=edit&id=${room.roomID}"
                                       class="btn btn-warning btn-sm">

                                        <i class="fa-solid fa-pen-to-square me-1"></i>

                                        Sửa

                                    </a>


                                    <!-- XÓA -->

                                    <a href="${pageContext.request.contextPath}/room?action=delete&id=${room.roomID}"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa phòng này?')">

                                        <i class="fa-solid fa-trash me-1"></i>

                                        Xóa

                                    </a>


                                </div>


                            </c:if>


                        </div>


                    </div>


                </div>


            </c:forEach>


        </div>

    </c:if>


    <!-- =====================================================
         EMPTY
    ===================================================== -->

    <c:if test="${empty list}">


        <div class="empty-room">


            <i class="fa-solid fa-hotel fa-3x mb-3"></i>


            <h4>

                Chưa có phòng nào

            </h4>


            <p class="text-muted mb-0">

                Hiện tại hệ thống chưa có phòng nào trong danh sách.

            </p>


        </div>


    </c:if>


    <!-- =====================================================
         PAGINATION
    ===================================================== -->

    <c:if test="${totalPages > 1}">


        <div class="pagination-wrapper">


            <nav aria-label="Phân trang danh sách phòng">


                <ul class="pagination">


                    <!-- =================================================
                         PREVIOUS
                    ================================================== -->

                    <c:choose>


                        <c:when test="${currentPage > 1}">

                            <li class="page-item">

                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/room?page=${currentPage - 1}"
                                   aria-label="Trang trước">

                                    <i class="fa-solid fa-chevron-left"></i>

                                </a>

                            </li>

                        </c:when>


                        <c:otherwise>

                            <li class="page-item disabled">

                                <span class="page-link">

                                    <i class="fa-solid fa-chevron-left"></i>

                                </span>

                            </li>

                        </c:otherwise>


                    </c:choose>


                    <!-- =================================================
                         PAGE NUMBER
                    ================================================== -->

                    <c:forEach begin="1"
                               end="${totalPages}"
                               var="pageNumber">


                        <li class="page-item
                                   ${pageNumber == currentPage ? 'active' : ''}">


                            <a class="page-link"
                               href="${pageContext.request.contextPath}/room?page=${pageNumber}">

                                ${pageNumber}

                            </a>


                        </li>


                    </c:forEach>


                    <!-- =================================================
                         NEXT
                    ================================================== -->

                    <c:choose>


                        <c:when test="${currentPage < totalPages}">

                            <li class="page-item">

                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/room?page=${currentPage + 1}"
                                   aria-label="Trang sau">

                                    <i class="fa-solid fa-chevron-right"></i>

                                </a>

                            </li>

                        </c:when>


                        <c:otherwise>

                            <li class="page-item disabled">

                                <span class="page-link">

                                    <i class="fa-solid fa-chevron-right"></i>

                                </span>

                            </li>

                        </c:otherwise>


                    </c:choose>


                </ul>

            </nav>

        </div>


    </c:if>


</div>


<!-- =====================================================
     FOOTER
===================================================== -->

<jsp:include page="../layout/footer.jsp"/>


<!-- Bootstrap JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


</body>

</html>