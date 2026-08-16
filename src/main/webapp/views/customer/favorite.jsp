<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phòng yêu thích - Luxury Hotel</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/room.css">

    <style>
        .fav-hero {
            background: linear-gradient(135deg, #1a2a3a 0%, #0d1b2a 100%);
            color: #ffffff;
            padding: 40px 0;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }

        .fav-card {
            background: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #e9ecef;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }

        .fav-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
        }

        .fav-img-wrapper {
            height: 220px;
            position: relative;
            overflow: hidden;
            background-color: #f8f9fa;
        }

        .fav-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .fav-card:hover .fav-img-wrapper img {
            transform: scale(1.05);
        }

        .fav-badge-status {
            position: absolute;
            top: 12px;
            right: 12px;
            z-index: 2;
        }

        .fav-price {
            color: #e53935;
            font-size: 1.25rem;
            font-weight: 700;
        }

        .fav-empty {
            background: #ffffff;
            border-radius: 16px;
            padding: 60px 20px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .fav-empty i {
            font-size: 64px;
            color: #ff6b6b;
            margin-bottom: 20px;
        }
    </style>
</head>

<body class="bg-light">

<!-- HEADER -->
<jsp:include page="../layout/header.jsp"/>

<div class="container mt-4 mb-5">

    <!-- HERO SECTION -->
    <div class="fav-hero px-4 text-center text-md-start">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="fw-bold mb-2">
                    <i class="fa-solid fa-heart text-danger me-2"></i> Danh Sách Phòng Yêu Thích
                </h2>
                <p class="text-white-50 mb-0">
                    Các phòng nghỉ bạn đã lưu lại để tham khảo hoặc đặt phòng cho kỳ nghỉ lý tưởng.
                </p>
            </div>
            <div class="col-md-4 text-center text-md-end mt-3 mt-md-0">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm">
                    <i class="fa-solid fa-arrow-left me-1"></i> Trở về trang chủ
                </a>
            </div>
        </div>
    </div>

    <!-- ALERT MESSAGES -->
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i>${successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- FAVORITE ROOM LIST -->
    <c:choose>
        <c:when test="${not empty favoriteRooms}">
            <div class="row g-4">
                <c:forEach var="room" items="${favoriteRooms}">
                    <div class="col-lg-4 col-md-6">
                        <div class="card fav-card h-100">
                            <!-- IMAGE & BADGE -->
                            <div class="fav-img-wrapper">
                                <span class="badge fav-badge-status ${room.status == 'Available' || room.status == 'Còn trống' ? 'bg-success' : 'bg-secondary'}">
                                    <i class="fa-solid ${room.status == 'Available' || room.status == 'Còn trống' ? 'fa-circle-check' : 'fa-clock'} me-1"></i>
                                    ${room.status}
                                </span>
                                <img src="https://du-lich.chudu24.com/f/m/2302/28/khach-san-the-empyrean-nha-trang-eastin-grand-nha-trang-cu-38.jpg"
                                     alt="${room.roomName}"
                                     onerror="this.onerror=null; this.src='https://placehold.co/600x400?text=Room+Image';">
                            </div>

                            <!-- CARD BODY -->
                            <div class="card-body d-flex flex-column p-4">
                                <h5 class="card-title fw-bold text-dark mb-2">
                                    ${room.roomName} <small class="text-muted fs-6">(${room.roomNumber})</small>
                                </h5>

                                <div class="fav-price mb-3">
                                    <fmt:formatNumber value="${room.price}" type="number" groupingUsed="true" minFractionDigits="0" maxFractionDigits="0"/> VNĐ <small class="text-muted fs-6 font-monospace">/ đêm</small>
                                </div>

                                <div class="row g-2 text-secondary fs-7 mb-3">
                                    <div class="col-6">
                                        <i class="fa-solid fa-bed me-1 text-warning"></i> ${room.bed} giường
                                    </div>
                                    <div class="col-6">
                                        <i class="fa-solid fa-ruler-combined me-1 text-warning"></i> ${room.acreage} m²
                                    </div>
                                    <c:if test="${not empty room.area}">
                                        <div class="col-12 mt-1">
                                            <i class="fa-solid fa-location-dot me-1 text-warning"></i> ${room.area}
                                        </div>
                                    </c:if>
                                    <div class="col-12 mt-1">
                                        <i class="fa-solid fa-heart me-1 text-danger"></i> ${room.favoriteCount} lượt yêu thích
                                    </div>
                                </div>

                                <c:if test="${not empty room.description}">
                                    <p class="card-text text-muted small mb-3 flex-grow-1" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                        ${room.description}
                                    </p>
                                </c:if>

                                <div class="mt-auto pt-3 border-top d-flex gap-2">
                                    <a href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                                       class="btn btn-outline-primary flex-fill">
                                        <i class="fa-solid fa-eye me-1"></i> Xem chi tiết
                                    </a>
                                    <a href="${pageContext.request.contextPath}/favorite?action=remove&roomId=${room.roomID}"
                                       class="btn btn-outline-danger flex-fill"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa phòng này khỏi danh sách yêu thích?');">
                                        <i class="fa-solid fa-heart-crack me-1"></i> Bỏ yêu thích
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <c:otherwise>
            <!-- EMPTY STATE -->
            <div class="fav-empty my-4">
                <i class="fa-regular fa-heart"></i>
                <h4 class="fw-bold text-dark mb-2">Bạn chưa có phòng yêu thích nào.</h4>
                <p class="text-muted mb-4">Hãy duyệt danh sách phòng và nhấn biểu tượng <strong>♡ Yêu thích</strong> để lưu lại các phòng quan tâm.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-warning px-4 py-2 fw-bold text-dark">
                    <i class="fa-solid fa-hotel me-2"></i> Khám phá danh sách phòng
                </a>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<!-- FOOTER -->
<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
