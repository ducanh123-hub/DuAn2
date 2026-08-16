<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Trang chủ khách hàng - Luxury Hotel</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/style.css">

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/home.css">


    <style>

        /* =====================================================
           WELCOME HERO
        ===================================================== */

        .welcome-hero {

            background: linear-gradient(
                135deg,
                var(--primary-color),
                var(--primary-light)
            );

            color: white;

            padding: 80px 0;

            border-radius: var(--border-radius);

            margin-bottom: 40px;

            position: relative;

            overflow: hidden;
        }


        .welcome-hero::after {

            content: '';

            position: absolute;

            top: -50%;

            right: -20%;

            width: 800px;

            height: 800px;

            background: radial-gradient(
                circle,
                rgba(212,175,55,0.1) 0%,
                rgba(255,255,255,0) 70%
            );

            border-radius: 50%;
        }


        /* =====================================================
           DANH SÁCH PHÒNG
        ===================================================== */

        .home-room-list {

            display: flex;

            flex-direction: column;

            gap: 18px;

            margin-top: 25px;
        }


        /* =====================================================
           CARD PHÒNG
        ===================================================== */

        .home-room-card {

            display: flex;

            width: 100%;

            min-height: 280px;

            background: #ffffff;

            border-radius: 10px;

            overflow: hidden;

            border: 1px solid #eeeeee;

            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.10);

            transition: all 0.25s ease;
        }


        .home-room-card:hover {

            transform: translateY(-2px);

            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.16);
        }


        /* =====================================================
           ẢNH PHÒNG
        ===================================================== */

        .home-room-image-box {

            width: 285px;

            min-width: 285px;

            height: 280px;

            position: relative;

            overflow: hidden;

            background: #eeeeee;
        }


        .home-room-image {

            width: 100%;

            height: 100%;

            object-fit: cover;

            display: block;

            transition: transform 0.4s ease;
        }


        .home-room-card:hover .home-room-image {

            transform: scale(1.03);
        }


        /* =====================================================
           TRẠNG THÁI
        ===================================================== */

        .home-room-status {

            position: absolute;

            top: 15px;

            right: 15px;

            padding: 9px 15px;

            border-radius: 6px;

            font-size: 14px;

            font-weight: 700;

            box-shadow: 0 2px 6px rgba(0,0,0,0.25);

            z-index: 2;
        }


        .home-room-status.available {

            background: #212529;

            color: #ffc107;
        }


        .home-room-status.occupied {

            background: #dc3545;

            color: white;
        }


        .home-room-status.maintenance {

            background: #ffc107;

            color: #212529;
        }


        /* =====================================================
           NỘI DUNG PHÒNG
        ===================================================== */

        .home-room-content {

            flex: 1;

            padding: 20px;

            display: flex;

            flex-direction: column;

            min-width: 0;
        }


        /* =====================================================
           TÊN PHÒNG
        ===================================================== */

        .home-room-title {

            font-size: 21px;

            font-weight: 700;

            color: #0d6efd;

            margin-bottom: 8px;
        }


        /* =====================================================
           MÔ TẢ
        ===================================================== */

        .home-room-description {

            color: #777;

            font-size: 14px;

            margin-bottom: 14px;

            line-height: 1.5;
        }


        /* =====================================================
           THÔNG TIN
        ===================================================== */

        .home-room-info {

            display: flex;

            flex-wrap: wrap;

            gap: 8px;

            margin-bottom: 12px;
        }


        .home-room-info span {

            background: #f5f6f7;

            border: 1px solid #e4e7ea;

            border-radius: 5px;

            padding: 5px 9px;

            font-size: 13px;

            color: #333;

            font-weight: 600;
        }


        .home-room-info i {

            margin-right: 4px;

            color: #343a40;
        }


        /* =====================================================
           ĐƯỜNG KẺ
        ===================================================== */

        .home-room-line {

            height: 1px;

            background: #e5e5e5;

            margin-top: auto;

            margin-bottom: 15px;
        }


        /* =====================================================
           GIÁ + BUTTON
        ===================================================== */

        .home-room-bottom {

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 20px;
        }


        .home-room-price small {

            display: block;

            color: #777;

            font-size: 14px;

            margin-bottom: 3px;
        }


        .home-room-price strong {

            display: block;

            color: #f44336;

            font-size: 19px;

            font-weight: 700;

            white-space: nowrap;
        }


        /* =====================================================
           BUTTON CHỌN PHÒNG
        ===================================================== */

        .home-btn-book {

            background: #0d9bea;

            color: white;

            border: none;

            border-radius: 25px;

            padding: 11px 25px;

            font-weight: 600;

            white-space: nowrap;
        }


        .home-btn-book:hover {

            background: #087fc2;

            color: white;
        }


        /* =====================================================
           PHÂN TRANG
        ===================================================== */

        .home-pagination-wrapper {

            display: flex;

            justify-content: center;

            align-items: center;

            margin-top: 35px;

            margin-bottom: 25px;
        }


        .home-pagination {

            display: flex;

            align-items: center;

            justify-content: center;

            flex-wrap: wrap;

            gap: 6px;
        }


        .home-page-btn {

            min-width: 42px;

            height: 40px;

            padding: 0 13px;

            border: 1px solid #dee2e6;

            background: #ffffff;

            color: #333;

            border-radius: 6px;

            font-weight: 600;

            transition: all 0.2s ease;
        }


        .home-page-btn:hover {

            background: #0d6efd;

            border-color: #0d6efd;

            color: #ffffff;
        }


        .home-page-btn.active {

            background: #0d6efd;

            border-color: #0d6efd;

            color: #ffffff;
        }


        .home-page-btn:disabled {

            background: #f1f1f1;

            color: #999;

            cursor: not-allowed;

            border-color: #ddd;
        }


        /* =====================================================
           THÔNG TIN PHÂN TRANG
        ===================================================== */

        .home-pagination-info {

            text-align: center;

            color: #6c757d;

            font-size: 14px;

            margin-top: 10px;
        }


        /* =====================================================
           KHÔNG CÓ PHÒNG
        ===================================================== */

        .home-no-room {

            display: none;

            padding: 60px 20px;

            text-align: center;

            background: #ffffff;

            border-radius: 10px;

            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }


        .home-no-room i {

            font-size: 55px;

            color: #ffc107;

            margin-bottom: 20px;
        }


        /* =====================================================
           MOBILE
        ===================================================== */

        @media (max-width: 768px) {

            .home-room-card {

                flex-direction: column;
            }


            .home-room-image-box {

                width: 100%;

                min-width: 100%;

                height: 230px;
            }


            .home-room-content {

                padding: 18px;
            }


            .home-room-bottom {

                flex-direction: column;

                align-items: stretch;

                gap: 15px;
            }


            .home-btn-book {

                display: block;

                width: 100%;

                text-align: center;
            }


            .home-pagination {

                gap: 4px;
            }


            .home-page-btn {

                min-width: 38px;

                height: 38px;

                padding: 0 9px;
            }

        }

    </style>

</head>


<body class="bg-light">


<!-- =====================================================
     HEADER
===================================================== -->

<jsp:include page="../layout/header.jsp"/>


<div class="container mt-5 mb-5">


    <!-- =====================================================
         WELCOME
    ===================================================== -->

    <div class="welcome-hero shadow-sm p-5 text-center text-md-start">

        <div class="row align-items-center position-relative">

            <div class="col-md-8">

                <span class="badge bg-warning text-dark mb-3 px-3 py-2 fw-bold text-uppercase">

                    Khách hàng thân thiết

                </span>


                <h1 class="display-5 fw-bold mb-2">

                    Xin chào, ${sessionScope.user.fullName}!

                </h1>


                <p class="fs-5 text-white-50 mb-0">

                    Chào mừng bạn quay trở lại với Luxury Hotel.
                    Hãy khám phá và đặt phòng cho kỳ nghỉ sắp tới của bạn.

                </p>

            </div>


            <div class="col-md-4 text-center text-md-end mt-4 mt-md-0">

                <a
                    href="${pageContext.request.contextPath}/room"
                    class="btn btn-warning btn-lg text-dark fw-bold px-4 py-3 shadow">

                    <i class="fa-solid fa-calendar-days me-1"></i>

                    Đặt phòng ngay

                </a>

            </div>

        </div>

    </div>


    <!-- =====================================================
         TIÊU ĐỀ PHÒNG
    ===================================================== -->

    <div class="text-center mb-4">

        <h2 class="fw-bold text-primary">

            Phòng nổi bật

        </h2>


        <p class="text-muted">

            Lựa chọn những căn phòng tốt nhất cho chuyến hành trình của bạn

        </p>

    </div>


    <!-- =====================================================
         DANH SÁCH PHÒNG
    ===================================================== -->

    <div
        id="homeRoomList"
        class="home-room-list">


        <c:forEach
            items="${roomList}"
            var="room"
            varStatus="roomStatus">


            <div
                class="home-room-card"
                data-status="${room.status}"
                data-room-id="${room.roomID}">


                <!-- =================================================
                     ẢNH PHÒNG
                ================================================= -->

                <div class="home-room-image-box">


                    <c:choose>

                        <c:when test="${roomStatus.index % 6 == 0}">

                            <img
                                src="https://afamilycdn.com/150157425591193600/2021/3/11/1062858034042480538125986431819415599970436o-16154470201552029786375.jpg"
                                class="home-room-image"
                                alt="${room.roomName}"
                                loading="lazy"
                                onerror="this.onerror=null;this.src='https://placehold.co/700x500?text=Luxury+Room';">

                        </c:when>


                        <c:when test="${roomStatus.index % 6 == 1}">

                            <img
                                src="https://afamilycdn.com/150157425591193600/2021/3/11/10553894514379389399271122382919384101112162o-16154411369911131972254.jpg"
                                class="home-room-image"
                                alt="${room.roomName}"
                                loading="lazy"
                                onerror="this.onerror=null;this.src='https://placehold.co/700x500?text=Luxury+Room';">

                        </c:when>


                        <c:when test="${roomStatus.index % 6 == 2}">

                            <img
                                src="https://afamilycdn.com/150157425591193600/2021/3/11/1062555694042506571456714788935087102328241o-16154470202451995436386.jpg"
                                class="home-room-image"
                                alt="${room.roomName}"
                                loading="lazy"
                                onerror="this.onerror=null;this.src='https://placehold.co/700x500?text=Luxury+Room';">

                        </c:when>


                        <c:when test="${roomStatus.index % 6 == 3}">

                            <img
                                src="https://kientructrangkim.com/wp-content/uploads/2014/08/biet-thu-bien-14-e1597921045415.jpg"
                                class="home-room-image"
                                alt="${room.roomName}"
                                loading="lazy"
                                onerror="this.onerror=null;this.src='https://placehold.co/700x500?text=Luxury+Room';">

                        </c:when>


                        <c:when test="${roomStatus.index % 6 == 4}">

                            <img
                                src="https://file4.batdongsan.com.vn/2022/05/25/PHJN6Zw0/20220525111935-fb0b.jpg"
                                class="home-room-image"
                                alt="${room.roomName}"
                                loading="lazy"
                                onerror="this.onerror=null;this.src='https://placehold.co/700x500?text=Luxury+Room';">

                        </c:when>


                        <c:otherwise>

                            <img
                                src="https://cms.lichngaytot.com/medias/original/2019/7/30/5-kieng-ki-phong-thuy-cho-nha-o-gan-bai-bien.jpg"
                                class="home-room-image"
                                alt="${room.roomName}"
                                loading="lazy"
                                onerror="this.onerror=null;this.src='https://placehold.co/700x500?text=Luxury+Room';">

                        </c:otherwise>

                    </c:choose>


                    <!-- =================================================
                         TRẠNG THÁI
                    ================================================= -->

                    <c:choose>

                        <c:when test="${room.status == 'Available'}">

                            <span class="home-room-status available">

                                <i class="fa-solid fa-circle-check me-1"></i>

                                Còn trống

                            </span>

                        </c:when>


                        <c:when test="${room.status == 'Occupied'}">

                            <span class="home-room-status occupied">

                                <i class="fa-solid fa-circle-xmark me-1"></i>

                                Đang có khách

                            </span>

                        </c:when>


                        <c:otherwise>

                            <span class="home-room-status maintenance">

                                <i class="fa-solid fa-screwdriver-wrench me-1"></i>

                                Bảo trì

                            </span>

                        </c:otherwise>

                    </c:choose>


                </div>


                <!-- =================================================
                     THÔNG TIN PHÒNG
                ================================================= -->

                <div class="home-room-content">


                    <h4 class="home-room-title">

                        ${room.roomName}

                    </h4>


                    <p class="home-room-description">

                        <c:choose>

                            <c:when test="${not empty room.description}">

                                ${room.description}

                            </c:when>

                            <c:otherwise>

                                Phòng tiêu chuẩn, đầy đủ tiện nghi cơ bản,
                                không gian thoải mái và hiện đại.

                            </c:otherwise>

                        </c:choose>

                    </p>


                    <div class="home-room-info">


                        <span>

                            <i class="fa-solid fa-bed"></i>

                            ${room.bed} giường

                        </span>


                        <span>

                            <i class="fa-solid fa-ruler-combined"></i>

                            ${room.acreage} m²

                        </span>


                        <span>

                            <i class="fa-solid fa-location-dot"></i>

                            ${room.area}

                        </span>


                        <span>

                            <i class="fa-solid fa-heart text-danger me-1"></i>

                            ${room.favoriteCount} lượt yêu thích

                        </span>


                    </div>


                    <div class="home-room-line"></div>


                    <!-- =================================================
                         GIÁ
                    ================================================= -->

                    <div class="home-room-bottom">


                        <div class="home-room-price">

                            <small>

                                Giá / đêm

                            </small>


                            <strong>

                                <fmt:formatNumber
                                    value="${room.price}"
                                    type="number"
                                    groupingUsed="true"
                                    minFractionDigits="0"
                                    maxFractionDigits="0"/>

                                VNĐ

                            </strong>

                        </div>


                        <!-- =================================================
                             NÚT CHỌN PHÒNG
                        ================================================= -->

                        <div class="d-flex align-items-center flex-wrap gap-2">

                            <a href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                               class="btn btn-outline-primary">
                                <i class="fa-solid fa-eye me-1"></i> Chi tiết
                            </a>

                            <c:choose>
                                <c:when test="${not empty favoriteRoomIds && favoriteRoomIds.contains(room.roomID)}">
                                    <a href="${pageContext.request.contextPath}/favorite?action=remove&roomId=${room.roomID}"
                                       class="btn btn-danger" title="Bỏ yêu thích">
                                        <i class="fa-solid fa-heart me-1"></i> ♥ Đã yêu thích
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/favorite?action=add&roomId=${room.roomID}"
                                       class="btn btn-outline-danger" title="Thêm vào yêu thích">
                                        <i class="fa-regular fa-heart me-1"></i> ♡ Yêu thích
                                    </a>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${room.status == 'Available'}">

                                <a
                                    href="${pageContext.request.contextPath}/booking?roomId=${room.roomID}"
                                    class="btn home-btn-book">

                                    <i class="fa-solid fa-calendar-check me-1"></i>

                                    Chọn phòng

                                </a>

                            </c:if>

                            <c:if test="${room.status != 'Available'}">

                                <button
                                    type="button"
                                    class="btn btn-secondary"
                                    disabled>

                                    <i class="fa-solid fa-lock me-1"></i>

                                    Không khả dụng

                                </button>

                            </c:if>

                        </div>


                    </div>

                </div>

            </div>


        </c:forEach>


    </div>


    <!-- =====================================================
         KHÔNG CÓ PHÒNG KHẢ DỤNG
    ===================================================== -->

    <div
        id="noAvailableRoom"
        class="home-no-room">

        <i class="fa-solid fa-hotel"></i>

        <h5 class="fw-bold">

            Hiện chưa có phòng trống

        </h5>

        <p class="text-muted mb-0">

            Tất cả các phòng hiện tại đều đã được đặt
            hoặc đang bảo trì.

        </p>

    </div>


    <!-- =====================================================
         PHÂN TRANG
    ===================================================== -->

    <div
        id="paginationWrapper"
        class="home-pagination-wrapper">

        <div
            id="pagination"
            class="home-pagination">

        </div>

    </div>


    <div
        id="paginationInfo"
        class="home-pagination-info">

    </div>


    <!-- =====================================================
         QUICK NAVIGATION
    ===================================================== -->

    <div class="row g-4 mb-5 mt-5">


        <!-- LỊCH SỬ -->

        <div class="col-md-4">

            <div class="card shadow-sm border-0 h-100 text-center p-4">

                <div class="card-body">

                    <i class="fa-solid fa-clock-rotate-left text-success fs-1 mb-3"></i>

                    <h5 class="fw-bold text-dark">

                        Lịch sử đặt phòng

                    </h5>

                    <p class="text-muted small">

                        Xem danh sách các phòng bạn đã đặt,
                        hóa đơn và trạng thái lưu trú.

                    </p>

                    <a
                        href="${pageContext.request.contextPath}/booking?action=history"
                        class="btn btn-outline-success btn-sm mt-2">

                        Truy cập lịch sử

                    </a>

                </div>

            </div>

        </div>


        <!-- HỒ SƠ -->

        <div class="col-md-4">

            <div class="card shadow-sm border-0 h-100 text-center p-4">

                <div class="card-body">

                    <i class="fa-solid fa-user-gear text-primary fs-1 mb-3"></i>

                    <h5 class="fw-bold text-dark">

                        Hồ sơ cá nhân

                    </h5>

                    <p class="text-muted small">

                        Cập nhật thông tin liên hệ,
                        số điện thoại, quốc tịch hoặc đổi mật khẩu.

                    </p>

                    <a
                        href="${pageContext.request.contextPath}/user?action=profile"
                        class="btn btn-outline-primary btn-sm mt-2">

                        Xem thông tin

                    </a>

                </div>

            </div>

        </div>


        <!-- HỖ TRỢ -->

        <div class="col-md-4">

            <div class="card shadow-sm border-0 h-100 text-center p-4">

                <div class="card-body">

                    <i class="fa-solid fa-envelope-open-text text-warning fs-1 mb-3"></i>

                    <h5 class="fw-bold text-dark">

                        Hỗ trợ & Liên hệ

                    </h5>

                    <p class="text-muted small">

                        Gửi câu hỏi hoặc đóng góp ý kiến
                        về dịch vụ khách sạn trực tiếp cho chúng tôi.

                    </p>

                    <a
                        href="${pageContext.request.contextPath}/contact"
                        class="btn btn-outline-warning btn-sm text-dark fw-bold mt-2">

                        Gửi phản hồi

                    </a>

                </div>

            </div>

        </div>


    </div>


    <!-- =====================================================
         SERVICES
    ===================================================== -->

    <div class="text-center mb-5">

        <h3 class="fw-bold text-primary">

            Các Dịch Vụ & Tiện Ích Đẳng Cấp

        </h3>

        <p class="text-muted">

            Chúng tôi cam kết đem lại trải nghiệm trọn vẹn
            và hoàn hảo nhất cho kỳ nghỉ của bạn

        </p>

    </div>


    <div class="row g-4 mb-5 text-center">


        <!-- WIFI -->

        <div class="col-6 col-lg-3">

            <div class="p-4 border rounded bg-white shadow-sm">

                <i class="fa-solid fa-wifi fs-2 text-warning mb-3"></i>

                <h6 class="fw-bold mb-1">

                    Wifi Tốc Độ Cao

                </h6>

                <p class="text-muted small mb-0">

                    Phủ sóng toàn bộ phòng nghỉ

                </p>

            </div>

        </div>


        <!-- NHÀ HÀNG -->

        <div class="col-6 col-lg-3">

            <div class="p-4 border rounded bg-white shadow-sm">

                <i class="fa-solid fa-utensils fs-2 text-warning mb-3"></i>

                <h6 class="fw-bold mb-1">

                    Nhà Hàng 5 Sao

                </h6>

                <p class="text-muted small mb-0">

                    Ẩm thực đa dạng Á - Âu

                </p>

            </div>

        </div>


        <!-- SPA -->

        <div class="col-6 col-lg-3">

            <div class="p-4 border rounded bg-white shadow-sm">

                <i class="fa-solid fa-spa fs-2 text-warning mb-3"></i>

                <h6 class="fw-bold mb-1">

                    Spa & Trị Liệu

                </h6>

                <p class="text-muted small mb-0">

                    Thư giãn và chăm sóc sức khỏe

                </p>

            </div>

        </div>


        <!-- HỖ TRỢ -->

        <div class="col-6 col-lg-3">

            <div class="p-4 border rounded bg-white shadow-sm">

                <i class="fa-solid fa-clock-rotate-left fs-2 text-warning mb-3"></i>

                <h6 class="fw-bold mb-1">

                    Hỗ Trợ 24/7

                </h6>

                <p class="text-muted small mb-0">

                    Phục vụ mọi yêu cầu

                </p>

            </div>

        </div>


    </div>


</div>


<!-- =====================================================
     FOOTER
===================================================== -->

<jsp:include page="../layout/footer.jsp"/>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


<script>

document.addEventListener("DOMContentLoaded", function () {

    /*
     * =========================================================
     * CẤU HÌNH PHÂN TRANG
     * =========================================================
     *
     * Mỗi trang hiển thị 7 phòng.
     *
     * 7 phòng x 5 trang = 35 phòng.
     *
     * Nếu có hơn 35 phòng thì tự động tạo trang 6, 7...
     */

    const ROOMS_PER_PAGE = 7;


    /*
     * =========================================================
     * LẤY DANH SÁCH CARD PHÒNG
     * =========================================================
     */

    const allRoomCards =
        Array.from(
            document.querySelectorAll(".home-room-card")
        );


    /*
     * =========================================================
     * CHỈ GIỮ PHÒNG AVAILABLE
     *
     * Occupied / Maintenance sẽ không hiển thị.
     * =========================================================
     */

    const availableRooms =
        allRoomCards.filter(function (card) {

            const status =
                card.getAttribute("data-status");

            return status === "Available";

        });


    /*
     * =========================================================
     * CÁC ELEMENT PHÂN TRANG
     * =========================================================
     */

    const pagination =
        document.getElementById("pagination");


    const paginationWrapper =
        document.getElementById("paginationWrapper");


    const paginationInfo =
        document.getElementById("paginationInfo");


    const noAvailableRoom =
        document.getElementById("noAvailableRoom");


    /*
     * =========================================================
     * TÍNH SỐ TRANG
     * =========================================================
     */

    const totalRooms =
        availableRooms.length;


    const totalPages =
        Math.ceil(
            totalRooms / ROOMS_PER_PAGE
        );


    /*
     * =========================================================
     * TRANG HIỆN TẠI
     * =========================================================
     */

    let currentPage = 1;


    /*
     * =========================================================
     * HÀM HIỂN THỊ PHÒNG
     * =========================================================
     */

    function showPage(page) {

        currentPage = page;


        /*
         * -----------------------------------------------------
         * ẨN TOÀN BỘ PHÒNG
         * -----------------------------------------------------
         */

        allRoomCards.forEach(function (card) {

            card.style.display = "none";

        });


        /*
         * -----------------------------------------------------
         * TÍNH VỊ TRÍ BẮT ĐẦU / KẾT THÚC
         * -----------------------------------------------------
         */

        const start =
            (page - 1) * ROOMS_PER_PAGE;


        const end =
            Math.min(
                start + ROOMS_PER_PAGE,
                totalRooms
            );


        /*
         * -----------------------------------------------------
         * HIỂN THỊ 7 PHÒNG CỦA TRANG
         * -----------------------------------------------------
         */

        for (
            let i = start;
            i < end;
            i++
        ) {

            availableRooms[i].style.display =
                "flex";

        }


        /*
         * -----------------------------------------------------
         * CẬP NHẬT PHÂN TRANG
         * -----------------------------------------------------
         */

        renderPagination();


        /*
         * -----------------------------------------------------
         * CẬP NHẬT TEXT
         * -----------------------------------------------------
         */

        if (totalRooms > 0) {

            paginationInfo.textContent =
                "Hiển thị "
                + (start + 1)
                + " - "
                + end
                + " trong tổng số "
                + totalRooms
                + " phòng trống";

        } else {

            paginationInfo.textContent = "";

        }


        /*
         * -----------------------------------------------------
         * CUỘN LÊN PHẦN PHÒNG
         * -----------------------------------------------------
         */

        const roomList =
            document.getElementById(
                "homeRoomList"
            );


        if (page !== 1) {

            roomList.scrollIntoView({
                behavior: "smooth",
                block: "start"
            });

        }

    }


    /*
     * =========================================================
     * TẠO NÚT PHÂN TRANG
     * =========================================================
     */

    function renderPagination() {

        pagination.innerHTML = "";


        /*
         * Nếu không có phòng
         * thì ẩn pagination
         */

        if (totalPages <= 1) {

            paginationWrapper.style.display =
                totalRooms > 0
                    ? "none"
                    : "none";

            return;

        }


        paginationWrapper.style.display =
            "flex";


        /*
         * =====================================================
         * NÚT TRANG TRƯỚC
         * =====================================================
         */

        const previousButton =
            document.createElement("button");


        previousButton.type =
            "button";


        previousButton.className =
            "home-page-btn";


        previousButton.innerHTML =
            '<i class="fa-solid fa-chevron-left"></i>';


        previousButton.disabled =
            currentPage === 1;


        previousButton.addEventListener(
            "click",
            function () {

                if (currentPage > 1) {

                    showPage(
                        currentPage - 1
                    );

                }

            }
        );


        pagination.appendChild(
            previousButton
        );


        /*
         * =====================================================
         * CÁC SỐ TRANG
         * =====================================================
         */

        for (
            let page = 1;
            page <= totalPages;
            page++
        ) {

            const pageButton =
                document.createElement("button");


            pageButton.type =
                "button";


            pageButton.className =
                "home-page-btn";


            pageButton.textContent =
                page;


            if (page === currentPage) {

                pageButton.classList.add(
                    "active"
                );

            }


            pageButton.addEventListener(
                "click",
                function () {

                    showPage(page);

                }
            );


            pagination.appendChild(
                pageButton
            );

        }


        /*
         * =====================================================
         * NÚT TRANG SAU
         * =====================================================
         */

        const nextButton =
            document.createElement("button");


        nextButton.type =
            "button";


        nextButton.className =
            "home-page-btn";


        nextButton.innerHTML =
            '<i class="fa-solid fa-chevron-right"></i>';


        nextButton.disabled =
            currentPage === totalPages;


        nextButton.addEventListener(
            "click",
            function () {

                if (
                    currentPage <
                    totalPages
                ) {

                    showPage(
                        currentPage + 1
                    );

                }

            }
        );


        pagination.appendChild(
            nextButton
        );

    }


    /*
     * =========================================================
     * KHÔNG CÓ PHÒNG TRỐNG
     * =========================================================
     */

    if (totalRooms === 0) {

        noAvailableRoom.style.display =
            "block";


        paginationWrapper.style.display =
            "none";


        paginationInfo.style.display =
            "none";


        return;

    }


    /*
     * =========================================================
     * KHỞI TẠO TRANG 1
     * ========================================================= */

    showPage(1);

});

</script>


</body>

</html>