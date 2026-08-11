<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Luxury Hotel - Đặt phòng khách sạn</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <!-- CSS chung -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <!-- CSS trang Home -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/home.css">

    <style>

        /* =====================================================
           HERO - BACKGROUND KIỂU TRAVELOKA
        ===================================================== */

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


        /* =====================================================
           HERO CONTENT
        ===================================================== */

        .hero-content {

            width: 100%;

            text-align: center;

            padding-top: 20px;
            padding-bottom: 30px;
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


        /* =====================================================
           NÚT KHÁM PHÁ
        ===================================================== */

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


        /* =====================================================
           GỢI Ý
        ===================================================== */

        .search-suggestions {

            margin-top: 28px;

            text-align: center;
        }


        .search-suggestions span {

            font-size: 14px;

            margin-right: 8px;

            color: white;
        }


        .suggestion {

            display: inline-block;

            padding: 6px 14px;

            margin: 4px;

            border-radius: 20px;

            background: rgba(255,255,255,0.18);

            color: white;

            text-decoration: none;

            border: 1px solid rgba(255,255,255,0.35);

            transition: all 0.2s;
        }


        .suggestion:hover {

            background: white;

            color: #0879d1;

            transform: translateY(-2px);
        }


        /* =====================================================
           PHẦN PHÒNG
        ===================================================== */

        .room-section {

            padding: 55px 0;
        }


        /* Bộ lọc bên trái */

        .filter-sidebar {

            position: sticky;

            top: 20px;

            border-radius: 12px;
        }


        /* Card phòng */

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


        /* Giá phòng */

        .room-price {

            color: #e53935;

            font-weight: 700;

            font-size: 17px;
        }


        /* =====================================================
           RESPONSIVE
        ===================================================== */

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


            .suggestion {

                padding: 5px 10px;

                font-size: 13px;
            }
        }

    </style>

</head>


<body class="bg-light">


<!-- =========================================================
     HEADER
========================================================= -->

<jsp:include page="../layout/header.jsp"/>


<!-- =========================================================
     HERO BACKGROUND
========================================================= -->

<section class="hotel-hero">

    <div class="container hero-content">

        <!-- TIÊU ĐỀ -->

        <h1>
            Chào mừng đến với Luxury Hotel
        </h1>


        <p>
            Không gian nghỉ dưỡng sang trọng, dịch vụ chuẩn hoàng gia
        </p>


        <!-- NÚT KHÁM PHÁ -->

        <a href="#featured-rooms"
           class="btn hero-button btn-lg">

            <i class="fa-solid fa-compass me-2"></i>

            Khám phá ngay

        </a>

    </div>

</section>


<!-- =========================================================
     PHẦN LỌC + DANH SÁCH PHÒNG
========================================================= -->

<section class="room-section bg-light"
         id="featured-rooms">

    <div class="container">

        <div class="row g-4">


            <!-- =================================================
                 BỘ LỌC BÊN TRÁI
            ================================================= -->

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


                            <!-- =============================
                                 TỪ KHÓA
                            ============================== -->

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


                            <!-- =============================
                                 GỢI Ý
                            ============================== -->

                            <div class="mb-4">

                                <small class="text-muted">
                                    Gợi ý:
                                </small>


                                <div class="mt-2">

                                    <a href="${pageContext.request.contextPath}/room?action=search&keyword=Standard"
                                       class="badge bg-light text-dark border text-decoration-none me-1 mb-1">

                                        Standard

                                    </a>


                                    <a href="${pageContext.request.contextPath}/room?action=search&keyword=Deluxe"
                                       class="badge bg-light text-dark border text-decoration-none me-1 mb-1">

                                        Deluxe

                                    </a>


                                    <a href="${pageContext.request.contextPath}/room?action=search&keyword=Suite"
                                       class="badge bg-light text-dark border text-decoration-none me-1 mb-1">

                                        Suite

                                    </a>


                                    <a href="${pageContext.request.contextPath}/room?action=search&keyword=Family"
                                       class="badge bg-light text-dark border text-decoration-none me-1 mb-1">

                                        Family

                                    </a>

                                </div>

                            </div>


                            <!-- =============================
                                 GIÁ TỪ
                            ============================== -->

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


                            <!-- =============================
                                 GIÁ ĐẾN
                            ============================== -->

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


                            <!-- =============================
                                 SỐ NGƯỜI
                            ============================== -->

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


                            <!-- =============================
                                 SẮP XẾP GIÁ
                            ============================== -->

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


                            <!-- BUTTON -->

                            <button type="submit"
                                    class="btn btn-warning w-100 fw-bold">

                                <i class="fa-solid fa-magnifying-glass me-2"></i>

                                Tìm phòng

                            </button>

                        </form>

                    </div>

                </div>

            </div>


            <!-- =================================================
                 DANH SÁCH PHÒNG
            ================================================= -->

            <div class="col-lg-9">


                <!-- TIÊU ĐỀ -->

                <div class="mb-4">

                    <h2 class="fw-bold mb-1">

                        Phòng nổi bật

                    </h2>


                    <p class="text-muted mb-0">

                        Lựa chọn căn phòng phù hợp với bạn

                    </p>

                </div>


                <!-- =================================================
                     ROOM LIST
                ================================================= -->

                <div class="row">


                    <c:forEach items="${roomList}" var="room">


                        <div class="col-md-6 col-xl-4 mb-4">


                            <div class="card room-card shadow-sm">


                                <!-- =========================
                                     ẢNH PHÒNG
                                ========================== -->

                                <div class="position-relative">


                                    <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80"
                                         alt="${room.roomName}"
                                         onerror="this.src='https://placehold.co/600x400?text=Luxury+Room';">


                                    <!-- TRẠNG THÁI -->

                                    <span class="position-absolute top-0 end-0 bg-dark text-warning fw-bold px-3 py-2 m-3 rounded">

                                        ${room.status}

                                    </span>

                                </div>


                                <!-- =========================
                                     THÔNG TIN PHÒNG
                                ========================== -->

                                <div class="card-body p-3">


                                    <h5 class="fw-bold text-primary">

                                        ${room.roomName}

                                    </h5>


                                    <p class="text-muted small">

                                        ${room.description != null
                                            ? room.description
                                            : 'Phòng đầy đủ tiện nghi, không gian thoải mái.'}

                                    </p>


                                    <!-- THÔNG SỐ -->

                                    <div class="d-flex gap-2 mb-3 flex-wrap">


                                        <span class="badge bg-light text-dark border">

                                            <i class="fa-solid fa-bed me-1"></i>

                                            ${room.bed} giường

                                        </span>


                                        <span class="badge bg-light text-dark border">

                                            <i class="fa-solid fa-expand me-1"></i>

                                            ${room.acreage} m²

                                        </span>


                                        <span class="badge bg-light text-dark border">

                                            <i class="fa-solid fa-location-dot me-1"></i>

                                            ${room.area}

                                        </span>

                                    </div>


                                    <!-- GIÁ + CHI TIẾT -->

                                    <div class="border-top pt-3 d-flex justify-content-between align-items-center">


                                        <div>

                                            <small class="text-muted d-block">

                                                Giá / đêm

                                            </small>


                                            <!--
                                                GIÁ ĐÃ ĐƯỢC FORMAT

                                                500000.00
                                                ↓
                                                500.000 VNĐ

                                                800000.00
                                                ↓
                                                800.000 VNĐ

                                                1200000.00
                                                ↓
                                                1.200.000 VNĐ
                                            -->

                                            <div class="room-price">

                                                <fmt:formatNumber
                                                        value="${room.price}"
                                                        type="number"
                                                        groupingUsed="true"
                                                        maxFractionDigits="0"/> VNĐ

                                            </div>

                                        </div>


                                        <a href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                                           class="btn btn-primary btn-sm">

                                            <i class="fa-solid fa-eye me-1"></i>

                                            Chi tiết

                                        </a>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </c:forEach>


                    <!-- =========================
                         KHÔNG CÓ PHÒNG
                    ========================== -->

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

            </div>

        </div>

    </div>

</section>


<!-- =========================================================
     DỊCH VỤ & TIỆN ÍCH
========================================================= -->

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


            <!-- WIFI -->

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


            <!-- NHÀ HÀNG -->

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


            <!-- SPA -->

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


            <!-- 24/7 -->

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


<!-- =========================================================
     FOOTER
========================================================= -->

<jsp:include page="../layout/footer.jsp"/>


<!-- Bootstrap JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>