<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Trang chủ khách hàng - Luxury Hotel</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <!-- CSS chung -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"
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
           DANH SÁCH PHÒNG TRANG HOME
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
        }


        .home-room-image {

            width: 100%;

            height: 100%;

            object-fit: cover;

            display: block;
        }


        /* =====================================================
           TRẠNG THÁI PHÒNG
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


        /* TÊN PHÒNG */

        .home-room-title {

            font-size: 21px;

            font-weight: 700;

            color: #0d6efd;

            margin-bottom: 8px;
        }


        /* MÔ TẢ */

        .home-room-description {

            color: #777;

            font-size: 14px;

            margin-bottom: 14px;

            line-height: 1.5;
        }


        /* =====================================================
           THÔNG TIN PHÒNG
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
           NÚT CHỌN PHÒNG
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

        }

    </style>

</head>


<body class="bg-light">


<!-- =====================================================
     HEADER
     ===================================================== -->

<jsp:include page="../layout/header.jsp"/>


<div class="container mt-5">


    <!-- =================================================
         WELCOME BANNER
         ================================================= -->

    <div class="welcome-hero shadow-sm p-5 text-center text-md-start">

        <div class="row align-items-center position-relative z-index-1">

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

                <a href="${pageContext.request.contextPath}/room"
                   class="btn btn-warning btn-lg text-dark fw-bold px-4 py-3 shadow">

                    <i class="fa-solid fa-calendar-days me-1"></i>

                    Đặt phòng ngay

                </a>

            </div>

        </div>

    </div>


    <!-- =================================================
         PHÒNG NỔI BẬT
         ================================================= -->

    <div class="text-center mb-4">

        <h2 class="fw-bold text-primary">
            Phòng nổi bật
        </h2>

        <p class="text-muted">
            Lựa chọn những căn phòng tốt nhất cho chuyến hành trình của bạn
        </p>

    </div>


    <!-- =================================================
         DANH SÁCH PHÒNG DẠNG NGANG
         ================================================= -->

    <div class="home-room-list">


        <c:forEach items="${roomList}" var="room">


            <!-- ============================
                 CARD PHÒNG
                 ============================ -->

            <div class="home-room-card">


                <!-- =========================
                     ẢNH PHÒNG
                     ========================= -->

                <div class="home-room-image-box">


                    <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=700&q=80"
                         class="home-room-image"
                         alt="${room.roomName}"
                         onerror="this.src='https://placehold.co/700x500?text=Luxury+Room';">


                    <!-- TRẠNG THÁI -->

                    <c:choose>


                        <!-- CÒN TRỐNG -->

                        <c:when test="${room.status == 'Available'}">

                            <span class="home-room-status available">

                                <i class="fa-solid fa-circle-check me-1"></i>

                                Còn trống

                            </span>

                        </c:when>


                        <!-- ĐANG CÓ KHÁCH -->

                        <c:when test="${room.status == 'Occupied'}">

                            <span class="home-room-status occupied">

                                <i class="fa-solid fa-circle-xmark me-1"></i>

                                Đang có khách

                            </span>

                        </c:when>


                        <!-- BẢO TRÌ -->

                        <c:otherwise>

                            <span class="home-room-status maintenance">

                                <i class="fa-solid fa-screwdriver-wrench me-1"></i>

                                Bảo trì

                            </span>

                        </c:otherwise>


                    </c:choose>


                </div>



                <!-- =========================
                     THÔNG TIN PHÒNG
                     ========================= -->

                <div class="home-room-content">


                    <!-- TÊN PHÒNG -->

                    <h4 class="home-room-title">

                        ${room.roomName}

                    </h4>



                    <!-- MÔ TẢ -->

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



                    <!-- =========================
                         THÔNG TIN
                         ========================= -->

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


                    </div>



                    <!-- ĐƯỜNG KẺ -->

                    <div class="home-room-line"></div>



                    <!-- =========================
                         GIÁ + CHỌN PHÒNG
                         ========================= -->

                    <div class="home-room-bottom">


                        <!-- GIÁ -->

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



                        <!-- BUTTON -->

                        <div>


                            <!-- PHÒNG CÒN TRỐNG -->

                            <c:if test="${room.status == 'Available'}">

                                <a href="${pageContext.request.contextPath}/booking?roomId=${room.roomID}"
                                   class="btn home-btn-book">

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

                                    Không khả dụng

                                </button>

                            </c:if>


                        </div>


                    </div>


                </div>


            </div>


        </c:forEach>



        <!-- =================================================
             KHÔNG CÓ PHÒNG
             ================================================= -->

        <c:if test="${empty roomList}">

            <div class="card border-0 shadow-sm text-center py-5">

                <div class="text-muted">

                    <i class="fa-solid fa-hotel fa-3x text-warning mb-3"></i>

                    <h5>
                        Chưa có phòng nào
                    </h5>

                    <p>
                        Hiện tại hệ thống chưa có phòng nào khả dụng.
                    </p>

                </div>

            </div>

        </c:if>


    </div>



    <!-- =================================================
         QUICK NAVIGATION
         ================================================= -->

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

                    <a href="${pageContext.request.contextPath}/booking?action=history"
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

                    <a href="${pageContext.request.contextPath}/user?action=profile"
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

                    <a href="${pageContext.request.contextPath}/contact"
                       class="btn btn-outline-warning btn-sm text-dark fw-bold mt-2">

                        Gửi phản hồi

                    </a>

                </div>

            </div>

        </div>


    </div>



    <!-- =================================================
         SERVICES
         ================================================= -->

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


<!-- Bootstrap JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


</body>

</html>