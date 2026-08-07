<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ khách hàng - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css">
    <style>
        .welcome-hero {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
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
            background: radial-gradient(circle, rgba(212,175,55,0.1) 0%, rgba(255,255,255,0) 70%);
            border-radius: 50%;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <!-- Welcome Banner Hero Section -->
    <div class="welcome-hero shadow-sm p-5 text-center text-md-start">
        <div class="row align-items-center position-relative z-index-1">
            <div class="col-md-8">
                <span class="badge bg-warning text-dark mb-3 px-3 py-2 fw-bold text-uppercase">Khách hàng thân thiết</span>
                <h1 class="display-5 fw-bold mb-2">Xin chào, ${sessionScope.user.fullName}!</h1>
                <p class="fs-5 text-white-50 mb-0">Chào mừng bạn quay trở lại với Luxury Hotel. Hãy khám phá và đặt phòng cho kỳ nghỉ sắp tới của bạn.</p>
            </div>
            <div class="col-md-4 text-center text-md-end mt-4 mt-md-0">
                <a href="${pageContext.request.contextPath}/room" class="btn btn-warning btn-lg text-dark fw-bold px-4 py-3 shadow">
                    <i class="fa-solid fa-calendar-days me-1"></i> Đặt phòng ngay
                </a>
            </div>
        </div>
    </div>

    <!-- Quick Navigation Hub -->
    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100 text-center p-4">
                <div class="card-body">
                    <i class="fa-solid fa-clock-rotate-left text-success fs-1 mb-3"></i>
                    <h5 class="fw-bold text-dark">Lịch sử đặt phòng</h5>
                    <p class="text-muted small">Xem danh sách các phòng bạn đã đặt, hóa đơn và trạng thái lưu trú.</p>
                    <a href="${pageContext.request.contextPath}/booking?action=history" class="btn btn-outline-success btn-sm mt-2">
                        Truy cập lịch sử
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100 text-center p-4">
                <div class="card-body">
                    <i class="fa-solid fa-user-gear text-primary fs-1 mb-3"></i>
                    <h5 class="fw-bold text-dark">Hồ sơ cá nhân</h5>
                    <p class="text-muted small">Cập nhật thông tin liên hệ, số điện thoại, quốc tịch hoặc đổi mật khẩu.</p>
                    <a href="${pageContext.request.contextPath}/user?action=profile" class="btn btn-outline-primary btn-sm mt-2">
                        Xem thông tin
                    </a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100 text-center p-4">
                <div class="card-body">
                    <i class="fa-solid fa-envelope-open-text text-warning fs-1 mb-3"></i>
                    <h5 class="fw-bold text-dark">Hỗ trợ & Liên hệ</h5>
                    <p class="text-muted small">Gửi câu hỏi hoặc đóng góp ý kiến về dịch vụ khách sạn trực tiếp cho chúng tôi.</p>
                    <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline-warning btn-sm text-dark fw-bold mt-2">
                        Gửi phản hồi
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Featured Services / Amenities -->
    <div class="text-center mb-5">
        <h3 class="fw-bold text-primary">Các Dịch Vụ & Tiện Ích Đẳng Cấp</h3>
        <p class="text-muted">Chúng tôi cam kết đem lại trải nghiệm trọn vẹn và hoàn hảo nhất cho kỳ nghỉ của bạn</p>
    </div>

    <div class="row g-4 mb-5 text-center">
        <div class="col-6 col-lg-3">
            <div class="p-4 border rounded bg-white shadow-sm">
                <i class="fa-solid fa-wifi fs-2 text-warning mb-3"></i>
                <h6 class="fw-bold mb-1">Wifi Tốc Độ Cao</h6>
                <p class="text-muted small mb-0">Phủ sóng toàn bộ phòng nghỉ</p>
            </div>
        </div>
        <div class="col-6 col-lg-3">
            <div class="p-4 border rounded bg-white shadow-sm">
                <i class="fa-solid fa-utensils fs-2 text-warning mb-3"></i>
                <h6 class="fw-bold mb-1">Nhà Hàng 5 Sao</h6>
                <p class="text-muted small mb-0">Ẩm thực đa dạng Á - Âu</p>
            </div>
        </div>
        <div class="col-6 col-lg-3">
            <div class="p-4 border rounded bg-white shadow-sm">
                <i class="fa-solid fa-spa fs-2 text-warning mb-3"></i>
                <h6 class="fw-bold mb-1">Spa & Trị Liệu</h6>
                <p class="text-muted small mb-0">Thư giãn và chăm sóc sức khỏe</p>
            </div>
        </div>
        <div class="col-6 col-lg-3">
            <div class="p-4 border rounded bg-white shadow-sm">
                <i class="fa-solid fa-clock-rotate-left fs-2 text-warning mb-3"></i>
                <h6 class="fw-bold mb-1">Hỗ Trợ 24/7</h6>
                <p class="text-muted small mb-0">Phục vụ mọi yêu cầu</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
