<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
        Kết quả tìm kiếm phòng - Luxury Hotel
    </title>


    <!-- =====================================================
         BOOTSTRAP
    ====================================================== -->

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">


    <!-- =====================================================
         FONT AWESOME
    ====================================================== -->

    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">


    <!-- =====================================================
         CSS CHUNG
    ====================================================== -->

    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/assets/css/style.css">


    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/assets/css/room.css">


    <!-- =====================================================
         CSS RIÊNG SEARCH
    ====================================================== -->

    <style>

        body {
            background: #f8f9fa;
        }


        /* =====================================================
           HERO
        ====================================================== */

        .search-hero {

            background:
                    linear-gradient(
                            rgba(12, 26, 48, 0.88),
                            rgba(12, 26, 48, 0.92)
                    ),
                    url('https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=1200&q=80')
                    no-repeat
                    center;

            background-size: cover;

            color: white;

            padding: 50px 0;

            border-bottom: 4px solid #ffc107;
        }


        /* =====================================================
           FILTER
        ====================================================== */

        .filter-card {

            background: white;

            border-radius: 15px;

            padding: 25px;

            box-shadow:
                    0 5px 20px rgba(0, 0, 0, 0.08);
        }


        .filter-card .form-control,
        .filter-card .form-select {

            min-height: 42px;

            border-radius: 8px;
        }


        .filter-card .form-control:focus,
        .filter-card .form-select:focus {

            border-color: #ffc107;

            box-shadow:
                    0 0 0 0.2rem rgba(255, 193, 7, 0.20);
        }


        /* =====================================================
           ROOM CARD
        ====================================================== */

        .room-card {
            border: none;
            border-radius: 14px;
            overflow: hidden;
            transition: transform .25s ease, box-shadow .25s ease;
            height: 100%;
            background: #fff;
        }

        .room-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 15px 30px rgba(0,0,0,.14) !important;
        }

        .room-image-wrapper {
            position: relative;
            overflow: hidden;
        }

        .room-card img {
            width: 100%;
            height: 215px;
            object-fit: cover;
            transition: transform .4s ease;
        }

        .room-card:hover img {
            transform: scale(1.05);
        }

        .room-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, rgba(0,0,0,.35), transparent 50%);
            pointer-events: none;
        }

        .room-status {
            position: absolute;
            top: 12px;
            right: 12px;
            padding: 7px 11px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            background: rgba(0,0,0,.72);
            color: #ffc107;
        }

        .room-type {
            position: absolute;
            bottom: 12px;
            left: 12px;
            padding: 6px 11px;
            border-radius: 20px;
            background: rgba(255,255,255,.92);
            color: #002b4d;
            font-size: 12px;
            font-weight: 700;
        }

        .room-name {
            color: #002b4d;
        }

        .price {
            color: #e53935;
            font-weight: 800;
            font-size: 17px;
            white-space: nowrap;
        }


        /* =====================================================
           PRICE
        ====================================================== */

        .price {

            color: #dc3545;

            font-weight: bold;

            font-size: 20px;

            white-space: nowrap;
        }


        /* =====================================================
           PAGINATION
        ====================================================== */

        .room-pagination {

            margin-top: 35px;

            margin-bottom: 10px;
        }


        .room-pagination .page-link {

            width: 42px;

            height: 42px;

            display: flex;

            align-items: center;

            justify-content: center;

            margin: 0 3px;

            border-radius: 8px !important;

            border: 1px solid #dee2e6;

            color: #0d6efd;

            font-weight: 500;

            background: white;

            transition: 0.2s;
        }


        .room-pagination .page-link:hover {

            background: #e9f2ff;

            border-color: #0d6efd;
        }


        .room-pagination .page-item.active .page-link {

            background: #0d6efd;

            border-color: #0d6efd;

            color: white;

            font-weight: bold;
        }


        .room-pagination .page-item.disabled .page-link {

            background: #e9ecef;

            border-color: #dee2e6;

            color: #6c757d;

            cursor: not-allowed;
        }


        /* =====================================================
           BADGE
        ====================================================== */

        .room-spec {

            font-size: 13px;
        }


        /* =====================================================
           RESPONSIVE
        ====================================================== */

        @media (max-width: 768px) {

            .search-hero {

                padding: 35px 0;
            }


            .room-image {

                height: 220px;
            }


            .price {

                font-size: 18px;
            }


            .room-pagination .page-link {

                width: 38px;

                height: 38px;

                margin: 0 2px;
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     HEADER
====================================================== -->

<jsp:include page="../layout/header.jsp"/>


<!-- =====================================================
     HERO
====================================================== -->

<div class="search-hero">

    <div class="container">

        <div class="text-center">

            <h2 class="fw-bold mb-2">

                KẾT QUẢ TÌM KIẾM PHÒNG

            </h2>


            <p class="text-warning mb-0">

                Tìm thấy những lựa chọn phù hợp với yêu cầu của bạn

            </p>

        </div>

    </div>

</div>


<!-- =====================================================
     MAIN
====================================================== -->

<div class="container my-5">


    <!-- =================================================
         FILTER
    ================================================== -->

    <div class="filter-card mb-5">


        <form
                action="${pageContext.request.contextPath}/room"
                method="get">


            <!-- Action -->

            <input
                    type="hidden"
                    name="action"
                    value="search">


            <!-- =================================================
                 QUAN TRỌNG:
                 Khi tìm kiếm mới luôn quay về page = 1
            ================================================== -->

            <input
                    type="hidden"
                    name="page"
                    value="1">


            <div class="row g-3">


                <!-- =================================================
                     KEYWORD
                ================================================== -->

                <div class="col-md-12">

                    <label class="form-label fw-bold">

                        <i class="fa-solid fa-magnifying-glass me-1"></i>

                        Tìm kiếm

                    </label>


                    <input
                            type="text"
                            name="keyword"
                            class="form-control"
                            value="${keyword}"
                            placeholder="Tên phòng, số phòng hoặc loại phòng...">


                    <div class="mt-2">

                        <small class="text-muted">

                            Gợi ý:

                        </small>


                        <!-- STANDARD -->

                        <a
                                href="${pageContext.request.contextPath}/room?action=search&page=1&keyword=Standard"
                                class="badge bg-light text-dark border text-decoration-none">

                            Standard

                        </a>


                        <!-- DELUXE -->

                        <a
                                href="${pageContext.request.contextPath}/room?action=search&page=1&keyword=Deluxe"
                                class="badge bg-light text-dark border text-decoration-none">

                            Deluxe

                        </a>


                        <!-- SUITE -->

                        <a
                                href="${pageContext.request.contextPath}/room?action=search&page=1&keyword=Suite"
                                class="badge bg-light text-dark border text-decoration-none">

                            Suite

                        </a>


                        <!-- FAMILY -->

                        <a
                                href="${pageContext.request.contextPath}/room?action=search&page=1&keyword=Family"
                                class="badge bg-light text-dark border text-decoration-none">

                            Family

                        </a>

                    </div>

                </div>


                <!-- =================================================
                     MIN PRICE
                ================================================== -->

                <div class="col-md-3">

                    <label class="form-label fw-bold">

                        <i class="fa-solid fa-money-bill-wave me-1"></i>

                        Giá từ

                    </label>


                    <input
                            type="number"
                            name="minPrice"
                            value="${minPrice}"
                            class="form-control"
                            min="0"
                            step="100000"
                            placeholder="0">

                </div>


                <!-- =================================================
                     MAX PRICE
                ================================================== -->

                <div class="col-md-3">

                    <label class="form-label fw-bold">

                        <i class="fa-solid fa-money-bill-wave me-1"></i>

                        Giá đến

                    </label>


                    <input
                            type="number"
                            name="maxPrice"
                            value="${maxPrice}"
                            class="form-control"
                            min="0"
                            step="100000"
                            placeholder="24.000.000">

                </div>


                <!-- =================================================
                     PEOPLE
                ================================================== -->

                <div class="col-md-3">

                    <label class="form-label fw-bold">

                        <i class="fa-solid fa-users me-1"></i>

                        Số người

                    </label>


                    <select
                            name="people"
                            class="form-select">


                        <option value="">

                            Tất cả

                        </option>


                        <option
                                value="1"
                                ${people == 1 ? 'selected' : ''}>

                            1 người

                        </option>


                        <option
                                value="2"
                                ${people == 2 ? 'selected' : ''}>

                            2 người

                        </option>


                        <option
                                value="3"
                                ${people == 3 ? 'selected' : ''}>

                            3 người

                        </option>


                        <option
                                value="4"
                                ${people == 4 ? 'selected' : ''}>

                            4 người

                        </option>


                        <option
                                value="5"
                                ${people == 5 ? 'selected' : ''}>

                            5 người

                        </option>


                        <option
                                value="6"
                                ${people == 6 ? 'selected' : ''}>

                            6 người

                        </option>

                    </select>

                </div>


                <!-- =================================================
                     SORT
                ================================================== -->

                <div class="col-md-3">

                    <label class="form-label fw-bold">

                        <i class="fa-solid fa-arrow-down-wide-short me-1"></i>

                        Sắp xếp giá

                    </label>


                    <select
                            name="sortPrice"
                            class="form-select">


                        <option
                                value=""
                                ${empty sortPrice ? 'selected' : ''}>

                            Mặc định

                        </option>


                        <option
                                value="asc"
                                ${sortPrice == 'asc' ? 'selected' : ''}>

                            Giá thấp → cao

                        </option>


                        <option
                                value="desc"
                                ${sortPrice == 'desc' ? 'selected' : ''}>

                            Giá cao → thấp

                        </option>

                    </select>

                </div>


                <!-- =================================================
                     BUTTON
                ================================================== -->

                <div class="col-12">

                    <button
                            type="submit"
                            class="btn btn-warning fw-bold px-4">

                        <i class="fa-solid fa-magnifying-glass me-2"></i>

                        Tìm phòng

                    </button>


                    <a
                            href="${pageContext.request.contextPath}/room"
                            class="btn btn-outline-secondary ms-2">

                        <i class="fa-solid fa-rotate-left me-1"></i>

                        Xóa bộ lọc

                    </a>

                </div>

            </div>

        </form>

    </div>


    <!-- =================================================
         RESULT HEADER
    ================================================== -->

    <div
            class="d-flex justify-content-between align-items-center mb-4">


        <div>

            <h4 class="fw-bold mb-1">

                Danh sách phòng

            </h4>


            <span class="text-muted">

                Tìm thấy

                <strong>

                    ${list.size()}

                </strong>

                phòng phù hợp

            </span>

        </div>


    </div>


    <!-- =================================================
         ROOM LIST
    ================================================== -->

    <div class="row">


        <c:forEach
                items="${list}"
                var="room">


            <div class="col-lg-4 col-md-6 mb-4">


                <div class="card room-card h-100 shadow-sm">


                    <!-- =================================================
                         IMAGE
                    ================================================== -->

                    <div class="room-image-wrapper">

                        <c:choose>
                            <c:when test="${room.roomName.contains('Standard')}">
                                <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=800&q=85" alt="${room.roomName}">
                            </c:when>
                            <c:when test="${room.roomName.contains('Deluxe')}">
                                <img src="https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=85" alt="${room.roomName}">
                            </c:when>
                            <c:when test="${room.roomName.contains('Suite')}">
                                <img src="https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=800&q=85" alt="${room.roomName}">
                            </c:when>
                            <c:when test="${room.roomName.contains('Family')}">
                                <img src="https://images.unsplash.com/photo-1595576508898-0ad5c879a061?auto=format&fit=crop&w=800&q=85" alt="${room.roomName}">
                            </c:when>
                            <c:otherwise>
                                <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=85" alt="${room.roomName}">
                            </c:otherwise>
                        </c:choose>

                        <div class="room-overlay"></div>

                        <!-- STATUS -->
                        <span class="room-status">
                            <i class="fa-solid fa-circle-check me-1"></i>
                            <c:choose>
                                <c:when test="${room.status == 'Còn trống'}">Còn trống</c:when>
                                <c:when test="${room.status == 'Đang ở'}">Đang ở</c:when>
                                <c:otherwise>${room.status}</c:otherwise>
                            </c:choose>
                        </span>

                        <!-- ROOM TYPE -->
                        <c:choose>
                            <c:when test="${room.roomName.contains('Standard')}">
                                <span class="room-type">Standard</span>
                            </c:when>
                            <c:when test="${room.roomName.contains('Deluxe')}">
                                <span class="room-type">Deluxe</span>
                            </c:when>
                            <c:when test="${room.roomName.contains('Suite')}">
                                <span class="room-type">Suite</span>
                            </c:when>
                            <c:when test="${room.roomName.contains('Family')}">
                                <span class="room-type">Family</span>
                            </c:when>
                        </c:choose>

                    </div>


                    <!-- =================================================
                         BODY
                    ================================================== -->

                    <div class="card-body p-4">


                        <!-- ROOM NAME + NUMBER -->

                        <div
                                class="d-flex justify-content-between align-items-start">


                            <h5
                                    class="card-title fw-bold text-primary mb-2">

                                ${room.roomName}

                            </h5>


                            <span
                                    class="badge bg-secondary">


                                P. ${room.roomNumber}


                            </span>

                        </div>


                        <!-- DESCRIPTION -->

                        <p class="text-muted small">


                            <c:choose>

                                <c:when test="${not empty room.description}">

                                    ${room.description}

                                </c:when>

                                <c:otherwise>

                                    Phòng đầy đủ tiện nghi hiện đại.

                                </c:otherwise>

                            </c:choose>


                        </p>


                        <!-- =================================================
                             ROOM SPECS
                        ================================================== -->

                        <div
                                class="d-flex gap-2 flex-wrap mb-3">


                            <!-- ACREAGE -->

                            <span
                                    class="badge bg-light text-dark border room-spec">


                                <i
                                        class="fa-solid fa-expand text-muted me-1">
                                </i>


                                <fmt:formatNumber
                                        value="${room.acreage}"
                                        type="number"
                                        maxFractionDigits="2"
                                        groupingUsed="true"/>

                                m²


                            </span>


                            <!-- BED -->

                            <span
                                    class="badge bg-light text-dark border room-spec">


                                <i
                                        class="fa-solid fa-bed text-muted me-1">
                                </i>


                                ${room.bed}

                                Giường


                            </span>


                            <!-- AREA -->

                            <span
                                    class="badge bg-light text-dark border room-spec">


                                <i
                                        class="fa-solid fa-location-dot text-muted me-1">
                                </i>


                                ${room.area}


                            </span>


                            <!-- FAVORITE COUNT -->

                            <span
                                    class="badge bg-light text-dark border room-spec">


                                <i
                                        class="fa-solid fa-heart text-danger me-1">
                                </i>


                                ${room.favoriteCount} Lượt thích


                            </span>

                        </div>


                        <hr>


                        <!-- =================================================
                             PRICE + BUTTON
                        ================================================== -->

                        <div
                                class="d-flex justify-content-between align-items-center">


                            <!-- PRICE -->

                            <div>

                                <small
                                        class="text-muted d-block">

                                    Giá phòng / đêm

                                </small>


                                <span class="price">


                                    <fmt:formatNumber
                                            value="${room.price}"
                                            type="number"
                                            groupingUsed="true"
                                            maxFractionDigits="0"/>


                                    VNĐ


                                </span>

                            </div>


                            <!-- BUTTONS -->

                            <div class="d-flex align-items-center gap-1">

                                <!-- FAVORITE -->
                                <c:choose>
                                    <c:when test="${not empty favoriteRoomIds && favoriteRoomIds.contains(room.roomID)}">
                                        <a href="${pageContext.request.contextPath}/favorite?action=remove&roomId=${room.roomID}"
                                           class="btn btn-danger btn-sm" title="Bỏ yêu thích">
                                            <i class="fa-solid fa-heart me-1"></i> ♥ Đã thích
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/favorite?action=add&roomId=${room.roomID}"
                                           class="btn btn-outline-danger btn-sm" title="Thêm vào yêu thích">
                                            <i class="fa-regular fa-heart me-1"></i> ♡ Yêu thích
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                                <!-- DETAIL -->

                                <a
                                        href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                                        class="btn btn-outline-primary btn-sm">


                                    <i
                                            class="fa-solid fa-eye me-1">
                                    </i>


                                    Chi tiết


                                </a>


                                <!-- BOOK -->

                                <c:if
                                        test="${room.status == 'Còn trống'}">


                                    <a
                                            href="${pageContext.request.contextPath}/booking?roomId=${room.roomID}"
                                            class="btn btn-success btn-sm">


                                        Đặt ngay


                                    </a>


                                </c:if>


                            </div>

                        </div>

                    </div>

                </div>

            </div>


        </c:forEach>


        <!-- =================================================
             EMPTY
        ================================================== -->

        <c:if test="${empty list}">


            <div class="col-12">


                <div
                        class="text-center bg-white rounded shadow-sm py-5">


                    <i
                            class="fa-solid fa-hotel fa-3x text-warning mb-3">
                    </i>


                    <h4 class="fw-bold">

                        Không tìm thấy phòng

                    </h4>


                    <p class="text-muted">

                        Không có phòng nào phù hợp với điều kiện tìm kiếm.

                    </p>


                    <a
                            href="${pageContext.request.contextPath}/room"
                            class="btn btn-primary">


                        <i
                                class="fa-solid fa-list me-1">
                        </i>


                        Xem tất cả phòng


                    </a>

                </div>

            </div>

        </c:if>


    </div>


    <!-- =====================================================
         PAGINATION

         KHÔNG CÓ:
         "Trang 1 / 5 — Hiển thị 4 phòng"

         CHỈ CÓ:
         < 1 2 3 4 5 >
    ====================================================== -->

    <c:if test="${totalPages > 1}">


        <nav
                aria-label="Phân trang phòng"
                class="room-pagination">


            <ul
                    class="pagination justify-content-center mb-0">


                <!-- =================================================
                     PREVIOUS
                ================================================== -->

                <c:choose>


                    <c:when test="${currentPage > 1}">


                        <li class="page-item">


                            <c:url
                                    var="previousUrl"
                                    value="/room">


                                <c:param
                                        name="action"
                                        value="search"/>


                                <c:param
                                        name="page"
                                        value="${currentPage - 1}"/>


                                <c:if test="${not empty keyword}">

                                    <c:param
                                            name="keyword"
                                            value="${keyword}"/>

                                </c:if>


                                <c:if test="${not empty minPrice}">

                                    <c:param
                                            name="minPrice"
                                            value="${minPrice}"/>

                                </c:if>


                                <c:if test="${not empty maxPrice}">

                                    <c:param
                                            name="maxPrice"
                                            value="${maxPrice}"/>

                                </c:if>


                                <c:if test="${not empty people}">

                                    <c:param
                                            name="people"
                                            value="${people}"/>

                                </c:if>


                                <c:if test="${not empty sortPrice}">

                                    <c:param
                                            name="sortPrice"
                                            value="${sortPrice}"/>

                                </c:if>


                            </c:url>


                            <a
                                    class="page-link"
                                    href="${previousUrl}"
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
                     PAGE NUMBERS
                ================================================== -->

                <c:forEach
                        begin="1"
                        end="${totalPages}"
                        var="pageNumber">


                    <c:url
                            var="pageUrl"
                            value="/room">


                        <c:param
                                name="action"
                                value="search"/>


                        <c:param
                                name="page"
                                value="${pageNumber}"/>


                        <!-- KEYWORD -->

                        <c:if test="${not empty keyword}">

                            <c:param
                                    name="keyword"
                                    value="${keyword}"/>

                        </c:if>


                        <!-- MIN PRICE -->

                        <c:if test="${not empty minPrice}">

                            <c:param
                                    name="minPrice"
                                    value="${minPrice}"/>

                        </c:if>


                        <!-- MAX PRICE -->

                        <c:if test="${not empty maxPrice}">

                            <c:param
                                    name="maxPrice"
                                    value="${maxPrice}"/>

                        </c:if>


                        <!-- PEOPLE -->

                        <c:if test="${not empty people}">

                            <c:param
                                    name="people"
                                    value="${people}"/>

                        </c:if>


                        <!-- SORT -->

                        <c:if test="${not empty sortPrice}">

                            <c:param
                                    name="sortPrice"
                                    value="${sortPrice}"/>

                        </c:if>


                    </c:url>


                    <li
                            class="page-item ${pageNumber == currentPage ? 'active' : ''}">


                        <a
                                class="page-link"
                                href="${pageUrl}">


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


                            <c:url
                                    var="nextUrl"
                                    value="/room">


                                <c:param
                                        name="action"
                                        value="search"/>


                                <c:param
                                        name="page"
                                        value="${currentPage + 1}"/>


                                <!-- KEYWORD -->

                                <c:if test="${not empty keyword}">

                                    <c:param
                                            name="keyword"
                                            value="${keyword}"/>

                                </c:if>


                                <!-- MIN PRICE -->

                                <c:if test="${not empty minPrice}">

                                    <c:param
                                            name="minPrice"
                                            value="${minPrice}"/>

                                </c:if>


                                <!-- MAX PRICE -->

                                <c:if test="${not empty maxPrice}">

                                    <c:param
                                            name="maxPrice"
                                            value="${maxPrice}"/>

                                </c:if>


                                <!-- PEOPLE -->

                                <c:if test="${not empty people}">

                                    <c:param
                                            name="people"
                                            value="${people}"/>

                                </c:if>


                                <!-- SORT -->

                                <c:if test="${not empty sortPrice}">

                                    <c:param
                                            name="sortPrice"
                                            value="${sortPrice}"/>

                                </c:if>


                            </c:url>


                            <a
                                    class="page-link"
                                    href="${nextUrl}"
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


    </c:if>


</div>


<!-- =====================================================
     FOOTER
====================================================== -->

<jsp:include page="../layout/footer.jsp"/>


<!-- =====================================================
     BOOTSTRAP JS
====================================================== -->

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>