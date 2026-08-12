<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">

    <title>Luxury Hotel - Đặt phòng khách sạn</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/home.css">

    <style>
        .hotel-hero {
            min-height: 560px;
            background:
                linear-gradient(
                    rgba(0, 45, 80, 0.68),
                    rgba(0, 35, 65, 0.75)
                ),
                url("https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1800&q=85");
            background-size: cover;
            background-position: center;
            color: white;
            position: relative;
            display: flex;
            align-items: center;
        }

        .hero-content {
            width: 100%;
            text-align: center;
            padding: 20px 0 30px;
        }

        .hero-content h1 {
            font-size: 44px;
            font-weight: 700;
            margin-bottom: 15px;
            text-shadow: 0 3px 10px rgba(0,0,0,0.35);
        }

        .hero-content p {
            font-size: 19px;
            margin-bottom: 30px;
            text-shadow: 0 2px 5px rgba(0,0,0,0.4);
        }

        .hero-button {
            background: #ffc107;
            color: #111;
            border: none;
            font-weight: 700;
            padding: 13px 28px;
            border-radius: 8px;
            transition: all 0.25s;
        }

        .hero-button:hover {
            background: #ffca2c;
            color: #111;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.25);
        }

        .room-section {
            padding: 55px 0;
        }

        .filter-sidebar {
            position: sticky;
            top: 20px;
            border-radius: 12px;
        }

        .room-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.25s;
            height: 100%;
        }

        .room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.15) !important;
        }

        .room-card img {
            width: 100%;
            height: 210px;
            object-fit: cover;
        }

        .room-price {
            color: #e53935;
            font-weight: 700;
            font-size: 17px;
        }

        .room-name {
            min-height: 30px;
        }

        .room-description {
            min-height: 42px;
        }

        .pagination {
            margin-bottom: 0;
        }

        .pagination .page-link {
            min-width: 40px;
            text-align: center;
        }

        .pagination .page-item.active .page-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
            color: white;
        }

        .pagination .page-item.disabled .page-link {
            pointer-events: none;
        }

        @media (max-width: 991px) {
            .hotel-hero {
                min-height: 480px;
            }

            .hero-content h1 {
                font-size: 32px;
            }

            .hero-content p {
                font-size: 16px;
            }

            .filter-sidebar {
                position: static;
            }
        }

        @media (max-width: 576px) {
            .hotel-hero {
                min-height: 430px;
            }

            .hero-content h1 {
                font-size: 28px;
            }

            .hero-content p {
                font-size: 15px;
            }

            .room-card img {
                height: 200px;
            }
        }
    </style>
</head>

<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<section class="hotel-hero">
    <div class="container hero-content">

        <h1>
            Chào mừng đến với Luxury Hotel
        </h1>

        <p>
            Không gian nghỉ dưỡng sang trọng, dịch vụ chuẩn hoàng gia
        </p>

        <a href="#featured-rooms"
           class="btn hero-button btn-lg">

            <i class="fa-solid fa-compass me-2"></i>

            Khám phá ngay

        </a>

    </div>
</section>

<section class="room-section bg-light"
         id="featured-rooms">

    <div class="container">

        <div class="row g-4">

            <div class="col-lg-3">

                <div class="card filter-sidebar shadow-sm border-0">

                    <div class="card-body p-4">

                        <h5 class="fw-bold text-primary mb-1">

                            <i class="fa-solid fa-filter me-2"></i>

                            Tìm phòng

                        </h5>

                        <p class="small text-muted mb-4">
                            Lọc phòng theo nhu cầu của bạn
                        </p>

                        <form action="${pageContext.request.contextPath}/room"
                              method="get">

                            <input type="hidden"
                                   name="action"
                                   value="search">

                            <input type="hidden"
                                   name="page"
                                   value="1">

                            <div class="mb-3">

                                <label class="form-label fw-bold">

                                    <i class="fa-solid fa-magnifying-glass me-1"></i>

                                    Tìm kiếm

                                </label>

                                <input type="text"
                                       name="keyword"
                                       class="form-control"
                                       placeholder="Tên hoặc số phòng"
                                       value="${param.keyword}">

                            </div>

                            <div class="mb-4">

                                <small class="text-muted">
                                    Gợi ý:
                                </small>

                                <div class="mt-2">

                                    <a href="${pageContext.request.contextPath}/room?action=search&keyword=Standard&page=1"
                                       class="badge bg-light text-dark border text-decoration-none me-1 mb-1">
                                        Standard
                                    </a>

                                    <a href="${pageContext.request.contextPath}/room?action=search&keyword=Deluxe&page=1"
                                       class="badge bg-light text-dark border text-decoration-none me-1 mb-1">
                                        Deluxe
                                    </a>

                                    <a href="${pageContext.request.contextPath}/room?action=search&keyword=Suite&page=1"
                                       class="badge bg-light text-dark border text-decoration-none me-1 mb-1">
                                        Suite
                                    </a>

                                    <a href="${pageContext.request.contextPath}/room?action=search&keyword=Family&page=1"
                                       class="badge bg-light text-dark border text-decoration-none me-1 mb-1">
                                        Family
                                    </a>

                                </div>

                            </div>

                            <div class="mb-3">

                                <label class="form-label fw-bold">

                                    <i class="fa-solid fa-money-bill-wave me-1"></i>

                                    Giá từ

                                </label>

                                <div class="input-group">

                                    <input type="number"
                                           name="minPrice"
                                           class="form-control"
                                           min="0"
                                           placeholder="0"
                                           value="${param.minPrice}">

                                    <span class="input-group-text">
                                        VNĐ
                                    </span>

                                </div>

                            </div>

                            <div class="mb-3">

                                <label class="form-label fw-bold">

                                    <i class="fa-solid fa-money-bill-wave me-1"></i>

                                    Giá đến

                                </label>

                                <div class="input-group">

                                    <input type="number"
                                           name="maxPrice"
                                           class="form-control"
                                           min="0"
                                           placeholder="24.000.000"
                                           value="${param.maxPrice}">

                                    <span class="input-group-text">
                                        VNĐ
                                    </span>

                                </div>

                            </div>

                            <div class="mb-3">

                                <label class="form-label fw-bold">

                                    <i class="fa-solid fa-users me-1"></i>

                                    Số người

                                </label>

                                <select name="people"
                                        class="form-select">

                                    <option value="">
                                        Tất cả
                                    </option>

                                    <option value="1"
                                            ${param.people == '1' ? 'selected' : ''}>
                                        1 người
                                    </option>

                                    <option value="2"
                                            ${param.people == '2' ? 'selected' : ''}>
                                        2 người
                                    </option>

                                    <option value="3"
                                            ${param.people == '3' ? 'selected' : ''}>
                                        3 người
                                    </option>

                                    <option value="4"
                                            ${param.people == '4' ? 'selected' : ''}>
                                        4 người
                                    </option>

                                    <option value="5"
                                            ${param.people == '5' ? 'selected' : ''}>
                                        5 người
                                    </option>

                                    <option value="6"
                                            ${param.people == '6' ? 'selected' : ''}>
                                        6+ người
                                    </option>

                                </select>

                            </div>

                            <div class="mb-4">

                                <label class="form-label fw-bold">

                                    <i class="fa-solid fa-arrow-down-wide-short me-1"></i>

                                    Sắp xếp giá

                                </label>

                                <select name="sortPrice"
                                        class="form-select">

                                    <option value="">
                                        Mặc định
                                    </option>

                                    <option value="asc"
                                            ${param.sortPrice == 'asc' ? 'selected' : ''}>
                                        Giá thấp → cao
                                    </option>

                                    <option value="desc"
                                            ${param.sortPrice == 'desc' ? 'selected' : ''}>
                                        Giá cao → thấp
                                    </option>

                                </select>

                            </div>

                            <button type="submit"
                                    class="btn btn-warning w-100 fw-bold">

                                <i class="fa-solid fa-magnifying-glass me-2"></i>

                                Tìm phòng

                            </button>

                        </form>

                    </div>

                </div>

            </div>

            <div class="col-lg-9">

                <div class="mb-4">

                    <h2 class="fw-bold mb-1">
                        Phòng nổi bật
                    </h2>

                    <p class="text-muted mb-0">
                        Lựa chọn căn phòng phù hợp với bạn
                    </p>

                </div>

                <div class="row">

                    <c:forEach items="${roomList}" var="room">

                        <div class="col-md-6 col-xl-4 mb-4">

                            <div class="card room-card shadow-sm">

                                <div class="position-relative">

                                    <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80"
                                         alt="${room.roomName}"
                                         onerror="this.onerror=null;this.src='https://placehold.co/600x400?text=Luxury+Room';">

                                    <span class="position-absolute top-0 end-0 bg-dark text-warning fw-bold px-3 py-2 m-3 rounded">

                                        ${room.status}

                                    </span>

                                </div>

                                <div class="card-body p-3">

                                    <h5 class="fw-bold text-primary room-name">

                                        ${room.roomName}

                                    </h5>

                                    <p class="text-muted small room-description">

                                        <c:choose>

                                            <c:when test="${not empty room.description}">
                                                ${room.description}
                                            </c:when>

                                            <c:otherwise>
                                                Phòng đầy đủ tiện nghi, không gian thoải mái.
                                            </c:otherwise>

                                        </c:choose>

                                    </p>

                                    <div class="d-flex gap-2 mb-3 flex-wrap">

                                        <span class="badge bg-light text-dark border">

                                            <i class="fa-solid fa-bed me-1"></i>

                                            ${room.bed} giường

                                        </span>

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

                                        <span class="badge bg-light text-dark border">

                                            <i class="fa-solid fa-location-dot me-1"></i>

                                            ${room.area}

                                        </span>

                                    </div>

                                    <div class="border-top pt-3 d-flex justify-content-between align-items-center">

                                        <div>

                                            <small class="text-muted d-block">
                                                Giá phòng / đêm
                                            </small>

                                            <div class="room-price">

                                                <fmt:formatNumber
                                                    value="${room.price}"
                                                    type="number"
                                                    groupingUsed="true"
                                                    minFractionDigits="0"
                                                    maxFractionDigits="0"
                                                    pattern="#,##0"/>

                                                VNĐ

                                            </div>

                                        </div>

                                        <div class="d-flex gap-2">

                                            <a href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                                               class="btn btn-outline-primary btn-sm">

                                                <i class="fa-solid fa-eye me-1"></i>

                                                Chi tiết

                                            </a>

                                            <a href="${pageContext.request.contextPath}/booking?roomId=${room.roomID}"
                                               class="btn btn-success btn-sm">

                                                Đặt ngay

                                            </a>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </c:forEach>

                    <c:if test="${empty roomList}">

                        <div class="col-12">

                            <div class="text-center py-5">

                                <i class="fa-solid fa-hotel fa-3x text-warning mb-3"></i>

                                <h4>
                                    Không tìm thấy phòng
                                </h4>

                                <p class="text-muted">
                                    Hãy thử thay đổi điều kiện tìm kiếm.
                                </p>

                            </div>

                        </div>

                    </c:if>

                </div>

                <c:if test="${totalPages > 1}">

                    <nav aria-label="Phân trang phòng"
                         class="mt-2 mb-4">

                        <ul class="pagination justify-content-center">

                            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">

                                <c:choose>

                                    <c:when test="${currentPage > 1}">

                                        <a class="page-link"
                                           href="${pageContext.request.contextPath}/room?action=search&page=${currentPage - 1}&keyword=${param.keyword}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&people=${param.people}&sortPrice=${param.sortPrice}">

                                            <i class="fa-solid fa-chevron-left"></i>

                                        </a>

                                    </c:when>

                                    <c:otherwise>

                                        <span class="page-link">
                                            <i class="fa-solid fa-chevron-left"></i>
                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </li>

                            <c:forEach begin="1"
                                       end="${totalPages}"
                                       var="pageNumber">

                                <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">

                                    <a class="page-link"
                                       href="${pageContext.request.contextPath}/room?action=search&page=${pageNumber}&keyword=${param.keyword}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&people=${param.people}&sortPrice=${param.sortPrice}">

                                        ${pageNumber}

                                    </a>

                                </li>

                            </c:forEach>

                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">

                                <c:choose>

                                    <c:when test="${currentPage < totalPages}">

                                        <a class="page-link"
                                           href="${pageContext.request.contextPath}/room?action=search&page=${currentPage + 1}&keyword=${param.keyword}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&people=${param.people}&sortPrice=${param.sortPrice}">

                                            <i class="fa-solid fa-chevron-right"></i>

                                        </a>

                                    </c:when>

                                    <c:otherwise>

                                        <span class="page-link">
                                            <i class="fa-solid fa-chevron-right"></i>
                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </li>

                        </ul>

                    </nav>

                </c:if>

            </div>

        </div>

    </div>

</section>

<section class="bg-white py-5 border-top">

    <div class="container">

        <div class="text-center mb-5">

            <h2 class="fw-bold">
                Dịch vụ & Tiện ích
            </h2>

            <p class="text-muted">
                Đem lại trải nghiệm trọn vẹn nhất cho kỳ nghỉ
            </p>

        </div>

        <div class="row text-center g-4">

            <div class="col-md-3">

                <div class="p-4 shadow-sm border rounded h-100">

                    <i class="fa-solid fa-wifi fa-2x text-primary"></i>

                    <h5 class="fw-bold mt-3">
                        Wifi tốc độ cao
                    </h5>

                    <p class="small text-muted">
                        Miễn phí toàn bộ khách sạn
                    </p>

                </div>

            </div>

            <div class="col-md-3">

                <div class="p-4 shadow-sm border rounded h-100">

                    <i class="fa-solid fa-utensils fa-2x text-primary"></i>

                    <h5 class="fw-bold mt-3">
                        Nhà hàng
                    </h5>

                    <p class="small text-muted">
                        Ẩm thực đa dạng Á - Âu
                    </p>

                </div>

            </div>

            <div class="col-md-3">

                <div class="p-4 shadow-sm border rounded h-100">

                    <i class="fa-solid fa-spa fa-2x text-primary"></i>

                    <h5 class="fw-bold mt-3">
                        Spa
                    </h5>

                    <p class="small text-muted">
                        Thư giãn và nghỉ ngơi
                    </p>

                </div>

            </div>

            <div class="col-md-3">

                <div class="p-4 shadow-sm border rounded h-100">

                    <i class="fa-solid fa-clock fa-2x text-primary"></i>

                    <h5 class="fw-bold mt-3">
                        Phục vụ 24/7
                    </h5>

                    <p class="small text-muted">
                        Hỗ trợ khách hàng mọi lúc
                    </p>

                </div>

            </div>

        </div>

    </div>

</section>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>