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

    <title>Luxury Hotel - Đặt phòng khách sạn</title>


    <!-- =====================================================
         BOOTSTRAP
         ===================================================== -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">


    <!-- =====================================================
         FONT AWESOME
         ===================================================== -->

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">


    <!-- =====================================================
         CSS PROJECT
         ===================================================== -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/home.css">


<style>

/* =========================================================
   GENERAL
   ========================================================= */

html {
    scroll-behavior: smooth;
}

body {
    margin: 0;
    padding: 0;
    background: #f8f9fa;
}


/* =========================================================
   HEADER
   ========================================================= */

/*
   BAN ĐẦU:
   Header trong suốt để hòa với background của Hero.

   KHI SCROLL:
   JavaScript thêm class "scrolled"
   -> Header chuyển sang xanh đen.
*/

.navbar,
.navbar.bg-white,
.navbar.navbar-light,
.navbar.navbar-dark {

    position: fixed !important;

    top: 0;
    left: 0;

    width: 100%;

    z-index: 9999;

    /* QUAN TRỌNG: BAN ĐẦU TRONG SUỐT */
    background: transparent !important;

    border: none !important;

    box-shadow: none !important;

    backdrop-filter: none;

    padding-top: 15px;
    padding-bottom: 15px;

    transition:
        background-color 0.35s ease,
        box-shadow 0.35s ease,
        padding 0.35s ease,
        backdrop-filter 0.35s ease;
}


/* =========================================================
   HEADER KHI SCROLL
   ========================================================= */

.navbar.scrolled,
.navbar.scrolled.bg-white,
.navbar.scrolled.navbar-light,
.navbar.scrolled.navbar-dark {

    background: #002b4d !important;

    box-shadow:
        0 5px 22px rgba(0, 0, 0, 0.28) !important;

    backdrop-filter: blur(12px);

    padding-top: 10px;
    padding-bottom: 10px;
}


/* =========================================================
   LOGO
   ========================================================= */

.navbar .navbar-brand {

    color: #ffffff !important;

    font-size: 22px;

    font-weight: 700;

    transition:
        color 0.25s ease,
        transform 0.25s ease;
}


.navbar .navbar-brand:hover {

    color: #ffc107 !important;

    transform: translateY(-1px);
}


/* Logo icon */

.navbar .navbar-brand i {

    color: #ffc107 !important;

    margin-right: 7px;
}


/* Logo khi scroll */

.navbar.scrolled .navbar-brand {

    color: #ffffff !important;
}


/* =========================================================
   MENU
   ========================================================= */

.navbar .nav-link {

    color: #ffffff !important;

    font-weight: 500;

    border-radius: 7px;

    padding-left: 12px !important;
    padding-right: 12px !important;

    transition:
        color 0.25s ease,
        background-color 0.25s ease;
}


/* Hover */

.navbar .nav-link:hover {

    color: #ffc107 !important;

    background:
        rgba(255, 255, 255, 0.10);
}


/* Active */

.navbar .nav-link.active {

    color: #ffc107 !important;

    font-weight: 700;
}


/* Menu khi scroll */

.navbar.scrolled .nav-link {

    color: #ffffff !important;
}


/* Hover khi scroll */

.navbar.scrolled .nav-link:hover {

    color: #ffc107 !important;

    background:
        rgba(255, 255, 255, 0.08);
}


/* Active khi scroll */

.navbar.scrolled .nav-link.active {

    color: #ffc107 !important;
}


/* =========================================================
   DROPDOWN
   ========================================================= */

.navbar .dropdown-menu {

    background: #ffffff !important;

    border: none !important;

    border-radius: 10px;

    padding: 8px;

    margin-top: 10px;

    box-shadow:
        0 10px 30px rgba(0, 0, 0, 0.20);
}


.navbar .dropdown-item {

    color: #212529 !important;

    border-radius: 7px;

    padding: 9px 14px;

    transition:
        background-color 0.2s ease,
        color 0.2s ease;
}


.navbar .dropdown-item:hover {

    background: #002b4d !important;

    color: #ffc107 !important;
}


/* Dropdown arrow */

.navbar .dropdown-toggle::after {

    color: #ffffff;

    transition:
        color 0.2s ease;
}


.navbar .dropdown-toggle:hover::after {

    color: #ffc107;
}


/* =========================================================
   BUTTON ĐĂNG NHẬP / ĐĂNG KÝ
   ========================================================= */

.navbar .btn {

    border-radius: 8px;

    font-weight: 600;

    transition:
        all 0.25s ease;
}


.navbar .btn-warning {

    background: #ffc107 !important;

    border-color: #ffc107 !important;

    color: #111 !important;
}


.navbar .btn-warning:hover {

    background: #ffca2c !important;

    border-color: #ffca2c !important;

    color: #111 !important;

    transform: translateY(-1px);

    box-shadow:
        0 5px 15px rgba(255, 193, 7, 0.30);
}


/* =========================================================
   MOBILE TOGGLE
   ========================================================= */

.navbar .navbar-toggler {

    border:
        1px solid rgba(255, 255, 255, 0.65) !important;

    padding: 7px 10px;

    border-radius: 7px;

    background:
        rgba(0, 0, 0, 0.10);
}


.navbar .navbar-toggler:focus {

    box-shadow:
        0 0 0 3px rgba(255, 193, 7, 0.25);
}


/* Icon hamburger */

.navbar .navbar-toggler-icon {

    filter:
        brightness(0) invert(1);
}


/* =========================================================
   HERO
   ========================================================= */

.hotel-hero {

    min-height: 620px;

    /*
       Header nằm trên Hero.
       Hero bắt đầu từ vị trí top của trang.
    */

    margin-top: 0;

    background:
        linear-gradient(
            rgba(0, 45, 80, 0.68),
            rgba(0, 35, 65, 0.75)
        ),
        url("https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1800&q=85");

    background-size: cover;

    background-position: center;

    background-repeat: no-repeat;

    color: white;

    position: relative;

    display: flex;

    align-items: center;

    justify-content: center;
}


.hero-content {

    width: 100%;

    text-align: center;

    /*
       Chừa khoảng cho header
    */

    padding: 100px 0 30px;
}


.hero-content h1 {

    font-size: 48px;

    font-weight: 700;

    margin-bottom: 18px;

    text-shadow:
        0 3px 10px rgba(0, 0, 0, 0.35);
}


.hero-content p {

    font-size: 20px;

    margin-bottom: 30px;

    text-shadow:
        0 2px 5px rgba(0, 0, 0, 0.4);
}


.hero-button {

    background: #ffc107;

    color: #111;

    border: none;

    font-weight: 700;

    padding: 14px 30px;

    border-radius: 9px;

    transition:
        all 0.25s ease;
}


.hero-button:hover {

    background: #ffca2c;

    color: #111;

    transform: translateY(-2px);

    box-shadow:
        0 8px 20px rgba(0, 0, 0, 0.25);
}


/* =========================================================
   VOUCHER
   ========================================================= */

.voucher-section {

    background: #f5f7fa;

    padding: 45px 0 35px;
}


.voucher-title {

    font-size: 28px;

    font-weight: 700;

    color: #1f2937;
}


.voucher-subtitle {

    color: #6b7280;

    font-size: 15px;
}


.voucher-list {

    display: grid;

    grid-template-columns: repeat(2, 1fr);

    gap: 20px;
}


.voucher-banner {

    position: relative;

    min-height: 190px;

    border-radius: 18px;

    overflow: hidden;

    color: white;

    display: flex;

    align-items: stretch;

    box-shadow:
        0 8px 25px rgba(0, 0, 0, 0.10);

    transition:
        transform 0.25s ease,
        box-shadow 0.25s ease;
}


.voucher-banner:hover {

    transform: translateY(-5px);

    box-shadow:
        0 15px 35px rgba(0, 0, 0, 0.18);
}


.voucher-welcome {

    background:
        linear-gradient(
            135deg,
            #0879f9 0%,
            #005bea 55%,
            #003dba 100%
        );
}


.voucher-summer {

    background:
        linear-gradient(
            135deg,
            #18b7a0 0%,
            #08a88e 50%,
            #087f6a 100%
        );
}


.voucher-banner::before {

    content: "";

    position: absolute;

    width: 180px;

    height: 180px;

    border-radius: 50%;

    background:
        rgba(255, 255, 255, 0.10);

    right: -50px;

    top: -70px;
}


.voucher-banner::after {

    content: "";

    position: absolute;

    width: 120px;

    height: 120px;

    border-radius: 50%;

    background:
        rgba(255, 255, 255, 0.08);

    right: 80px;

    bottom: -70px;
}


.voucher-left {

    position: relative;

    z-index: 2;

    width: 68%;

    padding: 25px;

    display: flex;

    flex-direction: column;

    justify-content: space-between;
}


.voucher-right {

    position: relative;

    z-index: 2;

    width: 32%;

    display: flex;

    align-items: center;

    justify-content: center;

    border-left:
        2px dashed rgba(255, 255, 255, 0.55);
}


.voucher-banner-title {

    font-size: 18px;

    font-weight: 700;

    margin-bottom: 5px;
}


.voucher-banner-title i {

    color: #ffd43b;
}


.voucher-discount {

    font-size: 34px;

    font-weight: 800;

    line-height: 1.1;

    margin-bottom: 5px;
}


.voucher-description {

    font-size: 13px;

    opacity: 0.92;

    margin-bottom: 0;
}


.voucher-code-box {

    display: flex;

    align-items: center;

    gap: 8px;

    width: fit-content;

    background: white;

    padding: 6px 7px 6px 12px;

    border-radius: 9px;

    box-shadow:
        0 3px 10px rgba(0, 0, 0, 0.10);
}


.voucher-code {

    color: #212529;

    font-size: 15px;

    font-weight: 800;

    letter-spacing: 1px;
}


.copy-voucher-btn {

    border: none;

    background: #ffc107;

    color: #111;

    font-size: 13px;

    font-weight: 700;

    padding: 7px 10px;

    border-radius: 7px;

    cursor: pointer;

    transition:
        all 0.2s ease;
}


.copy-voucher-btn:hover {

    background: #ffca2c;

    transform: scale(1.04);
}


.copy-voucher-btn:disabled {

    opacity: 0.85;

    cursor: default;

    transform: none;
}


.voucher-condition {

    font-size: 11px;

    opacity: 0.85;

    margin-top: 6px;
}


.voucher-icon {

    width: 82px;

    height: 82px;

    border-radius: 50%;

    background:
        rgba(255, 255, 255, 0.95);

    color: #ffc107;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 36px;

    box-shadow:
        0 5px 15px rgba(0, 0, 0, 0.12);
}


/* =========================================================
   ROOM
   ========================================================= */

.room-section {

    padding: 55px 0;
}


.filter-sidebar {

    position: sticky;

    top: 90px;

    border-radius: 12px;
}


.room-card {

    border: none;

    border-radius: 12px;

    overflow: hidden;

    transition:
        all 0.25s ease;

    height: 100%;
}


.room-card:hover {

    transform: translateY(-5px);

    box-shadow:
        0 12px 25px rgba(0, 0, 0, 0.15) !important;
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


/* =========================================================
   PAGINATION
   ========================================================= */

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


/* =========================================================
   SERVICES
   ========================================================= */

.service-card {

    transition:
        all 0.25s ease;
}


.service-card:hover {

    transform: translateY(-5px);

    box-shadow:
        0 10px 25px rgba(0, 0, 0, 0.1) !important;
}


/* =========================================================
   TABLET
   ========================================================= */

@media (max-width: 991px) {

    .hotel-hero {

        min-height: 540px;
    }


    .hero-content h1 {

        font-size: 36px;
    }


    .hero-content p {

        font-size: 17px;
    }


    .filter-sidebar {

        position: static;
    }


    .voucher-list {

        grid-template-columns: 1fr;
    }


    /* =====================================================
       MOBILE / TABLET HEADER
       ===================================================== */

    /*
       Khi chưa scroll:
       Header vẫn trong suốt.

       Khi scroll:
       Header xanh đen.
    */

    .navbar,
    .navbar.bg-white,
    .navbar.navbar-light {

        background: transparent !important;

        box-shadow: none !important;

        padding-top: 10px;

        padding-bottom: 10px;
    }


    .navbar.scrolled,
    .navbar.scrolled.bg-white,
    .navbar.scrolled.navbar-light {

        background: #002b4d !important;

        box-shadow:
            0 5px 22px rgba(0, 0, 0, 0.28) !important;
    }


    /*
       Menu mobile mở ra sẽ có nền xanh đen
       để dễ nhìn chữ.
    */

    .navbar .navbar-collapse {

        background: rgba(0, 43, 77, 0.97) !important;

        margin-top: 10px;

        padding: 10px;

        border-radius: 10px;

        box-shadow:
            0 10px 25px rgba(0, 0, 0, 0.20);
    }


    .navbar .nav-link {

        padding: 10px 12px !important;
    }

}


/* =========================================================
   MOBILE
   ========================================================= */

@media (max-width: 576px) {

    .navbar {

        padding-top: 10px;

        padding-bottom: 10px;
    }


    .hotel-hero {

        min-height: 500px;
    }


    .hero-content {

        padding-top: 80px;
    }


    .hero-content h1 {

        font-size: 29px;
    }


    .hero-content p {

        font-size: 15px;
    }


    .voucher-section {

        padding: 30px 0;
    }


    .voucher-title {

        font-size: 23px;
    }


    .voucher-banner {

        min-height: 180px;
    }


    .voucher-left {

        width: 72%;

        padding: 20px;
    }


    .voucher-right {

        width: 28%;
    }


    .voucher-discount {

        font-size: 27px;
    }


    .voucher-banner-title {

        font-size: 15px;
    }


    .voucher-description {

        font-size: 12px;
    }


    .voucher-code {

        font-size: 12px;
    }


    .copy-voucher-btn {

        font-size: 11px;

        padding: 6px 7px;
    }


    .voucher-icon {

        width: 60px;

        height: 60px;

        font-size: 25px;
    }


    .room-card img {

        height: 200px;
    }

}

</style>

</head>


<body class="bg-light">


<!-- =====================================================
     HEADER
     ===================================================== -->

<jsp:include page="../layout/header.jsp"/>


<!-- =====================================================
     HERO
     ===================================================== -->

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


<!-- =====================================================
     VOUCHER BANNER
     ===================================================== -->

<section class="voucher-section">

    <div class="container">

        <div class="mb-4">

            <h2 class="voucher-title mb-1">

                Ưu đãi dành riêng cho bạn

            </h2>

            <p class="voucher-subtitle mb-0">

                Sao chép mã và sử dụng khi đặt phòng

            </p>

        </div>


        <div class="voucher-list">


            <!-- VOUCHER 1 -->

            <div class="voucher-banner voucher-welcome">

                <div class="voucher-left">

                    <div>

                        <div class="voucher-banner-title">

                            <i class="fa-solid fa-gift me-2"></i>

                            Ưu đãi khách hàng mới

                        </div>

                        <div class="voucher-discount">

                            Giảm 10%

                        </div>

                        <p class="voucher-description">

                            Khuyến mãi khách hàng mới

                        </p>

                        <p class="voucher-description">

                            Đơn hàng từ
                            <strong>500.000 VNĐ</strong>

                        </p>

                    </div>


                    <div>

                        <div class="voucher-code-box">

                            <span class="voucher-code">

                                WELCOME10

                            </span>

                            <button type="button"
                                    class="copy-voucher-btn"
                                    onclick="copyVoucher('WELCOME10', this)">

                                <i class="fa-regular fa-copy me-1"></i>

                                Sao chép

                            </button>

                        </div>

                        <div class="voucher-condition">

                            <i class="fa-solid fa-tag me-1"></i>

                            Tối đa giảm 300.000 VNĐ

                        </div>

                    </div>

                </div>


                <div class="voucher-right">

                    <div class="voucher-icon">

                        <i class="fa-solid fa-ticket"></i>

                    </div>

                </div>

            </div>


            <!-- VOUCHER 2 -->

            <div class="voucher-banner voucher-summer">

                <div class="voucher-left">

                    <div>

                        <div class="voucher-banner-title">

                            <i class="fa-solid fa-sun me-2"></i>

                            Khuyến mãi mùa hè

                        </div>

                        <div class="voucher-discount">

                            Giảm 20%

                        </div>

                        <p class="voucher-description">

                            Khuyến mãi mùa hè

                        </p>

                        <p class="voucher-description">

                            Đơn hàng từ
                            <strong>1.000.000 VNĐ</strong>

                        </p>

                    </div>


                    <div>

                        <div class="voucher-code-box">

                            <span class="voucher-code">

                                SUMMER20

                            </span>

                            <button type="button"
                                    class="copy-voucher-btn"
                                    onclick="copyVoucher('SUMMER20', this)">

                                <i class="fa-regular fa-copy me-1"></i>

                                Sao chép

                            </button>

                        </div>

                        <div class="voucher-condition">

                            <i class="fa-solid fa-tag me-1"></i>

                            Tối đa giảm 500.000 VNĐ

                        </div>

                    </div>

                </div>


                <div class="voucher-right">

                    <div class="voucher-icon">

                        <i class="fa-solid fa-umbrella-beach"></i>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<!-- =====================================================
     ROOM SECTION
     ===================================================== -->

<section class="room-section bg-light"
         id="featured-rooms">

    <div class="container">

        <div class="row g-4">


            <!-- FILTER -->

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


            <!-- ROOM LIST -->

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

                    <c:forEach items="${roomList}"
                               var="room">

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
                                                        maxFractionDigits="0"/>

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


                <!-- PAGINATION -->

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


<!-- =====================================================
     SERVICES
     ===================================================== -->

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

                <div class="p-4 shadow-sm border rounded h-100 service-card">

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

                <div class="p-4 shadow-sm border rounded h-100 service-card">

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

                <div class="p-4 shadow-sm border rounded h-100 service-card">

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

                <div class="p-4 shadow-sm border rounded h-100 service-card">

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


<!-- =====================================================
     FOOTER
     ===================================================== -->

<jsp:include page="../layout/footer.jsp"/>


<!-- =====================================================
     BOOTSTRAP JS
     ===================================================== -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<script>


    /* =====================================================
       HEADER ĐỔI MÀU KHI SCROLL
       ===================================================== */

    window.addEventListener("scroll", function () {

        const navbar = document.querySelector(".navbar");

        if (!navbar) {
            return;
        }


        if (window.scrollY > 50) {

            navbar.classList.add("scrolled");

        } else {

            navbar.classList.remove("scrolled");

        }

    });



    /* =====================================================
       COPY VOUCHER
       ===================================================== */

    function copyVoucher(code, button) {

        if (navigator.clipboard &&
            window.isSecureContext) {

            navigator.clipboard
                .writeText(code)
                .then(function () {

                    showCopied(button);

                })
                .catch(function () {

                    fallbackCopy(code, button);

                });

        } else {

            fallbackCopy(code, button);

        }

    }



    /* =====================================================
       FALLBACK COPY
       ===================================================== */

    function fallbackCopy(code, button) {

        const input =
            document.createElement("input");

        input.value = code;

        input.style.position = "fixed";

        input.style.opacity = "0";

        document.body.appendChild(input);

        input.focus();

        input.select();

        try {

            document.execCommand("copy");

            showCopied(button);

        } catch (error) {

            alert(
                "Không thể sao chép mã. Vui lòng copy: "
                + code
            );

        }

        document.body.removeChild(input);

    }



    /* =====================================================
       HIỂN THỊ ĐÃ COPY
       ===================================================== */

    function showCopied(button) {

        const oldHTML =
            button.innerHTML;


        button.innerHTML =
            '<i class="fa-solid fa-check me-1"></i> Đã copy';


        button.disabled = true;


        setTimeout(function () {

            button.innerHTML =
                oldHTML;

            button.disabled = false;

        }, 1500);

    }


</script>


</body>

</html>