<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Luxury Hotel - Trải nghiệm nghỉ dưỡng đẳng cấp</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<!-- Hero Banner Section -->
<div class="hero-banner">
    <div class="container text-center">
        <h1 class="hero-title animate__animated animate__fadeInDown">
            Chào mừng đến với Luxury Hotel
        </h1>

        <p class="hero-subtitle animate__animated animate__fadeInUp">
            Không gian nghỉ dưỡng sang trọng, dịch vụ chuẩn hoàng gia
        </p>

        <a href="#featured-rooms" class="btn btn-warning btn-lg px-4 py-3 shadow-lg">
            <i class="fa-solid fa-compass me-1"></i> Khám phá ngay
        </a>
    </div>
</div>

<!-- Search Overlay Section -->
<div class="container">
    <div class="search-filter-box">
        <form action="${pageContext.request.contextPath}/room" method="get">
            <input type="hidden" name="action" value="search">

            <div class="row align-items-end">
                <div class="col-md-9 mb-3 mb-md-0">
                    <label class="form-label fw-bold">
                        <i class="fa-solid fa-magnifying-glass me-1"></i>
                        Tìm kiếm phòng
                    </label>

                    <div class="input-group">
                        <input type="text"
                               name="keyword"
                               class="form-control py-3"
                               placeholder="Nhập tên phòng hoặc số phòng cần tìm...">
                    </div>
                </div>

                <div class="col-md-3">
                    <button type="submit"
                            class="btn btn-warning w-100 py-3 text-dark fw-bold">
                        <i class="fa-solid fa-filter me-1"></i>
                        Tìm kiếm
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Main Content Area (Featured Rooms) -->
<div class="container my-5 pt-4" id="featured-rooms">

    <div class="text-center mb-5">
        <h2 class="section-title d-inline-block">
            Phòng nổi bật
        </h2>

        <p class="text-muted mt-2">
            Lựa chọn những căn phòng tốt nhất cho chuyến hành trình của bạn
        </p>
    </div>

    <div class="row">

        <c:forEach items="${roomList}" var="room">

            <div class="col-md-4 mb-4">

                <div class="card card-home h-100 shadow border-0">

                    <div class="position-relative">

                        <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80"
                             class="card-img-top"
                             alt="${room.roomName}"
                             onerror="this.src='https://placehold.co/600x400?text=Luxury+Room';">

                        <span class="position-absolute top-0 end-0 bg-dark text-warning fw-bold px-3 py-2 m-3 rounded shadow">
                            ${room.status}
                        </span>

                    </div>

                    <div class="card-body p-4 d-flex flex-column">

                        <h5 class="card-title fw-bold text-primary mb-2">
                            ${room.roomName}
                        </h5>

                        <p class="card-text text-muted flex-grow-1">
                            ${room.description != null
                                ? room.description
                                : 'Đầy đủ tiện nghi hiện đại, không gian thoáng đãng, mang đến cảm giác thoải mái tối đa.'}
                        </p>

                        <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">

                            <div>

                                <small class="text-muted d-block">
                                    Giá phòng / Đêm
                                </small>

                                <!--
                                    Hiển thị giá dạng:
                                    500000   -> 500.000 VNĐ
                                    800000   -> 800.000 VNĐ
                                    1200000  -> 1.200.000 VNĐ
                                -->
                                <span class="fs-5 text-danger fw-bold">
                                    <fmt:formatNumber
                                            value="${room.price}"
                                            type="number"
                                            groupingUsed="true"
                                            maxFractionDigits="0"/> VNĐ
                                </span>

                            </div>

                            <a href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                               class="btn btn-primary px-3">

                                <i class="fa-solid fa-eye me-1"></i>
                                Chi tiết

                            </a>

                        </div>

                    </div>

                </div>

            </div>

        </c:forEach>

        <c:if test="${empty roomList}">

            <div class="col-12 text-center py-5">

                <div class="text-muted">

                    <i class="fa-solid fa-hotel fa-3x mb-3 text-warning"></i>

                    <p class="fs-5">
                        Chưa có danh sách phòng nào khả dụng.
                    </p>

                </div>

            </div>

        </c:if>

    </div>

</div>

<!-- Hotel Amenities Section -->
<div class="bg-white py-5 border-top border-bottom">

    <div class="container my-4">

        <div class="text-center mb-5">

            <h2 class="section-title d-inline-block">
                Dịch vụ & Tiện ích
            </h2>

            <p class="text-muted mt-2">
                Đem lại trải nghiệm trọn vẹn nhất cho kỳ nghỉ của bạn
            </p>

        </div>

        <div class="row text-center g-4">

            <div class="col-md-3">

                <div class="feature-item p-4 shadow-sm border">

                    <i class="fa-solid fa-wifi feature-icon"></i>

                    <h5 class="fw-bold mt-2">
                        Wifi Tốc độ cao
                    </h5>

                    <p class="text-muted small mb-0">
                        Miễn phí toàn bộ khu vực khách sạn
                    </p>

                </div>

            </div>

            <div class="col-md-3">

                <div class="feature-item p-4 shadow-sm border">

                    <i class="fa-solid fa-utensils feature-icon"></i>

                    <h5 class="fw-bold mt-2">
                        Nhà hàng 5 Sao
                    </h5>

                    <p class="text-muted small mb-0">
                        Ẩm thực đa dạng Á - Âu từ đầu bếp hàng đầu
                    </p>

                </div>

            </div>

            <div class="col-md-3">

                <div class="feature-item p-4 shadow-sm border">

                    <i class="fa-solid fa-spa feature-icon"></i>

                    <h5 class="fw-bold mt-2">
                        Spa & Trị liệu
                    </h5>

                    <p class="text-muted small mb-0">
                        Thư giãn tinh thần và phục hồi sức khỏe
                    </p>

                </div>

            </div>

            <div class="col-md-3">

                <div class="feature-item p-4 shadow-sm border">

                    <i class="fa-solid fa-clock-rotate-left feature-icon"></i>

                    <h5 class="fw-bold mt-2">
                        Phục vụ 24/7
                    </h5>

                    <p class="text-muted small mb-0">
                        Hỗ trợ khách hàng mọi khung giờ trong ngày
                    </p>

                </div>

            </div>

        </div>

    </div>

</div>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>