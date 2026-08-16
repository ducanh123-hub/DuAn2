<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Chi tiết phòng - Luxury Hotel</title>

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
            href="${pageContext.request.contextPath}/assets/css/room.css">

    <style>

        /* =====================================================
           ROOM GALLERY
        ===================================================== */

        .room-gallery {
            width: 100%;
        }

        .room-gallery-main {
            width: 100%;
            height: 430px;
            background: #f1f1f1;
            border-radius: 12px;
            overflow: hidden;
        }

        .room-gallery-main .carousel-item {
            height: 430px;
        }

        .room-gallery-main img {
            width: 100%;
            height: 430px;
            object-fit: cover;
        }

        .room-gallery .carousel-control-prev,
        .room-gallery .carousel-control-next {
            width: 12%;
        }

        .room-gallery .carousel-control-prev-icon,
        .room-gallery .carousel-control-next-icon {
            background-color: rgba(0, 0, 0, 0.65);
            border-radius: 50%;
            padding: 22px;
            background-size: 45%;
        }

        /* =====================================================
           THUMBNAILS
        ===================================================== */

        .room-thumbnails {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 8px;
            margin-top: 10px;
        }

        .room-thumbnail {
            width: 100%;
            height: 70px;
            object-fit: cover;
            border-radius: 7px;
            cursor: pointer;
            border: 3px solid transparent;
            transition: all 0.2s ease;
        }

        .room-thumbnail:hover {
            transform: translateY(-2px);
            border-color: #ffc107;
        }

        /* =====================================================
           GIÁ PHÒNG

           Màu đỏ
           Không in đậm
           Không bị ảnh hưởng bởi font-weight từ CSS khác
        ===================================================== */

        .room-detail-price {
            color: #e53935 !important;
            font-size: 24px;
            font-weight: 400 !important;
            line-height: 1.5;
        }

        /* =====================================================
           TIÊU ĐỀ
        ===================================================== */

        .room-detail-title {
            color: #0d6efd;
            font-weight: 700;
        }

        /* =====================================================
           BẢNG THÔNG TIN
        ===================================================== */

        .room-info-table th {
            width: 180px;
            background: #f8f9fa;
        }

        /* =====================================================
           MOBILE
        ===================================================== */

        @media (max-width: 768px) {

            .room-gallery-main {
                height: 300px;
            }

            .room-gallery-main .carousel-item {
                height: 300px;
            }

            .room-gallery-main img {
                height: 300px;
            }

            .room-thumbnails {
                grid-template-columns: repeat(3, 1fr);
            }

            .room-thumbnail {
                height: 65px;
            }

            .room-detail-price {
                font-size: 21px;
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
     MAIN
===================================================== -->

<div class="container mt-5 mb-5">

    <div class="card shadow border-0">


        <!-- =================================================
             HEADER CARD
        ================================================== -->

        <div class="card-header bg-dark text-white">

            <h3 class="mb-0">

                <i class="fa-solid fa-circle-info me-2"></i>

                Chi tiết phòng

            </h3>

        </div>


        <!-- =================================================
             CARD BODY
        ================================================== -->

        <div class="card-body p-4">

            <div class="row g-4">


                <!-- =================================================
                     LEFT - GALLERY
                ================================================== -->

                <div class="col-md-5">

                    <div class="room-gallery">


                        <!-- MAIN CAROUSEL -->

                        <div
                                id="roomGallery"
                                class="carousel slide room-gallery-main"
                                data-bs-ride="carousel">


                            <div class="carousel-inner">


                                <!-- IMAGE 1 -->

                                <div class="carousel-item active">

                                    <img
                                            src="https://du-lich.chudu24.com/f/m/2302/28/khach-san-the-empyrean-nha-trang-eastin-grand-nha-trang-cu-38.jpg"
                                            alt="${room.roomName}"
                                            onerror="this.onerror=null; this.src='https://placehold.co/800x600?text=Room+1';">

                                </div>


                                <!-- IMAGE 2 -->

                                <div class="carousel-item">

                                    <img
                                            src="https://cdnturint.touristica.com.tr/otel-resimleri/v1.00/reges-a-luxury-collection-resort-spa/900x600/reges-a-luxury-collection-resort-oda-aegean_136694.jpg"
                                            alt="${room.roomName}"
                                            onerror="this.onerror=null; this.src='https://placehold.co/800x600?text=Room+2';">

                                </div>


                                <!-- IMAGE 3 -->

                                <div class="carousel-item">

                                    <img
                                            src="https://res.klook.com/image/upload/fl_lossy.progressive%2Cq_85/c_fill%2Cw_1000/v1660125874/blog/o6doqv8vwrhsjb1tyokx.jpg"
                                            alt="${room.roomName}"
                                            onerror="this.onerror=null; this.src='https://placehold.co/800x600?text=Room+3';">

                                </div>


                                <!-- IMAGE 4 -->

                                <div class="carousel-item">

                                    <img
                                            src="https://www.ticati.com/img/hotel/19454583s.jpg"
                                            alt="${room.roomName}"
                                            onerror="this.onerror=null; this.src='https://placehold.co/800x600?text=Room+4';">

                                </div>


                                <!-- IMAGE 5 -->

                                <div class="carousel-item">

                                    <img
                                            src="https://contenu.nyc3.digitaloceanspaces.com/journalist/def51bb4-28fd-4a97-bbb4-f24722e648b4/thumbnail.jpeg"
                                            alt="${room.roomName}"
                                            onerror="this.onerror=null; this.src='https://placehold.co/800x600?text=Room+5';">

                                </div>


                                <!-- IMAGE 6 -->

                                <div class="carousel-item">

                                    <img
                                            src="https://cdn.mos.cms.futurecdn.net/NKxs7o4onnCjzmbnY83QJQ.jpg"
                                            alt="${room.roomName}"
                                            onerror="this.onerror=null; this.src='https://placehold.co/800x600?text=Room+6';">

                                </div>


                            </div>


                            <!-- PREVIOUS -->

                            <button
                                    class="carousel-control-prev"
                                    type="button"
                                    data-bs-target="#roomGallery"
                                    data-bs-slide="prev">

                                <span class="carousel-control-prev-icon"></span>

                                <span class="visually-hidden">
                                    Ảnh trước
                                </span>

                            </button>


                            <!-- NEXT -->

                            <button
                                    class="carousel-control-next"
                                    type="button"
                                    data-bs-target="#roomGallery"
                                    data-bs-slide="next">

                                <span class="carousel-control-next-icon"></span>

                                <span class="visually-hidden">
                                    Ảnh tiếp
                                </span>

                            </button>


                        </div>


                        <!-- =================================================
                             THUMBNAILS
                        ================================================== -->

                        <div class="room-thumbnails">


                            <img
                                    src="https://du-lich.chudu24.com/f/m/2302/28/khach-san-the-empyrean-nha-trang-eastin-grand-nha-trang-cu-38.jpg"
                                    class="room-thumbnail"
                                    data-bs-target="#roomGallery"
                                    data-bs-slide-to="0"
                                    alt="Ảnh 1">


                            <img
                                    src="https://cdnturint.touristica.com.tr/otel-resimleri/v1.00/reges-a-luxury-collection-resort-spa/900x600/reges-a-luxury-collection-resort-oda-aegean_136694.jpg"
                                    class="room-thumbnail"
                                    data-bs-target="#roomGallery"
                                    data-bs-slide-to="1"
                                    alt="Ảnh 2">


                            <img
                                    src="https://res.klook.com/image/upload/fl_lossy.progressive%2Cq_85/c_fill%2Cw_1000/v1660125874/blog/o6doqv8vwrhsjb1tyokx.jpg"
                                    class="room-thumbnail"
                                    data-bs-target="#roomGallery"
                                    data-bs-slide-to="2"
                                    alt="Ảnh 3">


                            <img
                                    src="https://www.ticati.com/img/hotel/19454583s.jpg"
                                    class="room-thumbnail"
                                    data-bs-target="#roomGallery"
                                    data-bs-slide-to="3"
                                    alt="Ảnh 4">


                            <img
                                    src="https://contenu.nyc3.digitaloceanspaces.com/journalist/def51bb4-28fd-4a97-bbb4-f24722e648b4/thumbnail.jpeg"
                                    class="room-thumbnail"
                                    data-bs-target="#roomGallery"
                                    data-bs-slide-to="4"
                                    alt="Ảnh 5">


                            <img
                                    src="https://cdn.mos.cms.futurecdn.net/NKxs7o4onnCjzmbnY83QJQ.jpg"
                                    class="room-thumbnail"
                                    data-bs-target="#roomGallery"
                                    data-bs-slide-to="5"
                                    alt="Ảnh 6">


                        </div>


                    </div>

                </div>


                <!-- =================================================
                     RIGHT - ROOM INFORMATION
                ================================================== -->

                <div class="col-md-7">


                    <!-- ROOM NAME -->

                    <h2 class="room-detail-title mb-3">

                        ${room.roomName}

                    </h2>


                    <!-- =================================================
                         INFORMATION TABLE
                    ================================================== -->

                    <table class="table table-bordered table-striped room-info-table">


                        <!-- ROOM NUMBER -->

                        <tr>

                            <th>
                                Số phòng
                            </th>

                            <td>
                                ${room.roomNumber}
                            </td>

                        </tr>


                        <!-- ROOM NAME -->

                        <tr>

                            <th>
                                Tên phòng
                            </th>

                            <td>
                                ${room.roomName}
                            </td>

                        </tr>


                        <!-- CATEGORY -->

                        <tr>

                            <th>
                                Loại phòng
                            </th>

                            <td>
                                ${room.categoryID}
                            </td>

                        </tr>


                        <!-- =================================================
                             PRICE

                             ĐÃ SỬA:
                             1.500.000 VNĐ
                             Không có .00
                             Màu đỏ
                             Không in đậm
                        ================================================== -->

                        <tr>

                            <th>
                                Giá / đêm
                            </th>

                            <td class="room-detail-price">

                                <fmt:formatNumber
                                        value="${room.price}"
                                        type="number"
                                        maxFractionDigits="0"
                                        groupingUsed="true"/>

                                VNĐ

                            </td>

                        </tr>


                        <!-- ACREAGE -->

                        <tr>

                            <th>
                                Diện tích
                            </th>

                            <td>
                                ${room.acreage} m²
                            </td>

                        </tr>


                        <!-- BED -->

                        <tr>

                            <th>
                                Số giường
                            </th>

                            <td>
                                ${room.bed}
                            </td>

                        </tr>


                        <!-- AREA -->

                        <tr>

                            <th>
                                Khu vực
                            </th>

                            <td>
                                ${room.area}
                            </td>

                        </tr>


                        <!-- FAVORITE COUNT -->

                        <tr>

                            <th>
                                Lượt yêu thích
                            </th>

                            <td>
                                <i class="fa-solid fa-heart text-danger me-1"></i>
                                <strong>${room.favoriteCount}</strong> lượt yêu thích
                            </td>

                        </tr>


                        <!-- STATUS -->

                        <tr>

                            <th>
                                Trạng thái
                            </th>

                            <td>

                                <span
                                        class="badge
                                        ${room.status == 'Còn trống'
                                            ? 'bg-success'
                                            : 'bg-warning text-dark'}">

                                    ${room.status}

                                </span>

                            </td>

                        </tr>


                        <!-- DESCRIPTION -->

                        <tr>

                            <th>
                                Mô tả
                            </th>

                            <td>
                                <c:choose>
                                    <c:when test="${room.roomName.contains('Family')}">
                                        Phòng Family rộng rãi, thiết kế hiện đại, phù hợp cho gia đình hoặc nhóm bạn. Không gian thoáng mát, đầy đủ tiện nghi, mang đến trải nghiệm nghỉ dưỡng thoải mái.
                                    </c:when>
                                    <c:when test="${room.roomName.contains('Deluxe')}">
                                        Phòng Deluxe được thiết kế sang trọng và tinh tế, mang đến không gian nghỉ ngơi thoải mái cho các cặp đôi hoặc khách công tác.
                                    </c:when>
                                    <c:when test="${room.roomName.contains('Standard')}">
                                        Phòng Standard có thiết kế đơn giản, tiện nghi và ấm cúng, phù hợp cho khách hàng tìm kiếm không gian nghỉ ngơi thoải mái với mức giá hợp lý.
                                    </c:when>
                                    <c:when test="${room.roomName.contains('Suite')}">
                                        Phòng Suite sở hữu không gian rộng rãi và sang trọng, được trang bị đầy đủ tiện nghi, phù hợp cho những kỳ nghỉ cao cấp và thư giãn.
                                    </c:when>
                                    <c:otherwise>
                                        <c:out value="${not empty room.description ? room.description : 'Phòng được thiết kế hiện đại, đầy đủ tiện nghi, mang lại không gian nghỉ dưỡng thoải mái và tuyệt vời cho quý khách.'}"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                        </tr>


                    </table>


                    <!-- =================================================
                         TIỆN ÍCH CHÍNH (MAIN AMENITIES)
                    ================================================== -->

                    <div class="mt-4 pt-3 border-top">

                        <h5 class="fw-bold text-primary mb-3">
                            <i class="fa-solid fa-square-check me-2"></i>Tiện ích chính
                        </h5>

                        <div class="row g-3">

                            <!-- CỘT TRÁI -->
                            <div class="col-6">

                                <div class="d-flex align-items-center mb-2">
                                    <i class="fa-solid fa-snowflake text-primary fs-5 me-3" style="width: 24px; text-align: center;"></i>
                                    <span class="fw-semibold text-dark">Máy lạnh</span>
                                </div>

                                <div class="d-flex align-items-center mb-2">
                                    <i class="fa-solid fa-utensils text-primary fs-5 me-3" style="width: 24px; text-align: center;"></i>
                                    <span class="fw-semibold text-dark">Nhà hàng</span>
                                </div>

                                <div class="d-flex align-items-center mb-2">
                                    <i class="fa-solid fa-person-swimming text-primary fs-5 me-3" style="width: 24px; text-align: center;"></i>
                                    <span class="fw-semibold text-dark">Hồ bơi</span>
                                </div>

                                <div class="d-flex align-items-center mb-2">
                                    <i class="fa-solid fa-clock text-primary fs-5 me-3" style="width: 24px; text-align: center;"></i>
                                    <span class="fw-semibold text-dark">Lễ tân 24h</span>
                                </div>

                            </div>

                            <!-- CỘT PHẢI -->
                            <div class="col-6">

                                <div class="d-flex align-items-center mb-2">
                                    <i class="fa-solid fa-square-parking text-primary fs-5 me-3" style="width: 24px; text-align: center;"></i>
                                    <span class="fw-semibold text-dark">Chỗ đậu xe</span>
                                </div>

                                <div class="d-flex align-items-center mb-2">
                                    <i class="fa-solid fa-elevator text-primary fs-5 me-3" style="width: 24px; text-align: center;"></i>
                                    <span class="fw-semibold text-dark">Thang máy</span>
                                </div>

                                <div class="d-flex align-items-center mb-2">
                                    <i class="fa-solid fa-wifi text-primary fs-5 me-3" style="width: 24px; text-align: center;"></i>
                                    <span class="fw-semibold text-dark">WiFi</span>
                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- =================================================
                         BUTTONS
                    ================================================== -->

                    <div class="mt-4">


                        <!-- BACK -->

                        <a
                                href="${pageContext.request.contextPath}/room"
                                class="btn btn-secondary me-2">

                            <i class="fa-solid fa-arrow-left me-1"></i>

                            Quay lại

                        </a>


                        <!-- BOOK -->

                        <a
                                href="${pageContext.request.contextPath}/booking?roomId=${room.roomID}"
                                class="btn btn-success me-2">

                            <i class="fa-solid fa-calendar-check me-1"></i>

                            Đặt phòng ngay

                        </a>


                        <!-- FAVORITE BUTTON -->

                        <c:choose>
                            <c:when test="${isFavorite}">
                                <a href="${pageContext.request.contextPath}/favorite?action=remove&roomId=${room.roomID}"
                                   class="btn btn-danger me-2">
                                    <i class="fa-solid fa-heart me-1"></i> ♥ Đã yêu thích
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/favorite?action=add&roomId=${room.roomID}"
                                   class="btn btn-outline-danger me-2">
                                    <i class="fa-regular fa-heart me-1"></i> ♡ Yêu thích
                                </a>
                            </c:otherwise>
                        </c:choose>


                        <!-- EDIT - ADMIN -->

                        <c:if
                                test="${sessionScope.user != null && sessionScope.user.roleID == 1}">

                            <a
                                    href="${pageContext.request.contextPath}/room?action=edit&id=${room.roomID}"
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


<!-- =====================================================
     FOOTER
===================================================== -->

<jsp:include page="../layout/footer.jsp"/>


<!-- =====================================================
     BOOTSTRAP JS
===================================================== -->

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>