<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bảng điều khiển quản trị - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <!-- Sidebar Navigation -->
        <div class="col-md-3">
            <jsp:include page="../layout/sidebar.jsp"/>
        </div>

        <!-- Dashboard Content -->
        <div class="col-md-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold text-primary mb-1">Hệ thống Quản trị</h2>
                    <p class="text-muted mb-0">Chào mừng quay trở lại, ${sessionScope.user.fullName}!</p>
                </div>
                <div class="text-muted small">
                    <i class="fa-regular fa-clock me-1"></i> Hôm nay: <strong class="text-dark"><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %></strong>
                </div>
            </div>

            <!-- Stats Row -->
            <div class="row g-4 mb-5">
                <!-- Total Rooms -->
                <div class="col-sm-6 col-lg-3">
                    <div class="card border-0 shadow-sm h-100" style="border-left: 5px solid #007bff !important;">
                        <div class="card-body d-flex align-items-center justify-content-between p-4">
                            <div>
                                <span class="text-muted d-block mb-1 small fw-bold text-uppercase">Số lượng phòng</span>
                                <h3 class="fw-bold text-dark mb-0">${totalRooms}</h3>
                            </div>
                            <div class="bg-primary bg-opacity-10 text-primary p-3 rounded-circle fs-3">
                                <i class="fa-solid fa-bed"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Total Bookings -->
                <div class="col-sm-6 col-lg-3">
                    <div class="card border-0 shadow-sm h-100" style="border-left: 5px solid #28a745 !important;">
                        <div class="card-body d-flex align-items-center justify-content-between p-4">
                            <div>
                                <span class="text-muted d-block mb-1 small fw-bold text-uppercase">Đơn đặt phòng</span>
                                <h3 class="fw-bold text-dark mb-0">${totalBookings}</h3>
                            </div>
                            <div class="bg-success bg-opacity-10 text-success p-3 rounded-circle fs-3">
                                <i class="fa-solid fa-calendar-check"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Total Users -->
                <div class="col-sm-6 col-lg-3">
                    <div class="card border-0 shadow-sm h-100" style="border-left: 5px solid #fd7e14 !important;">
                        <div class="card-body d-flex align-items-center justify-content-between p-4">
                            <div>
                                <span class="text-muted d-block mb-1 small fw-bold text-uppercase">Thành viên</span>
                                <h3 class="fw-bold text-dark mb-0">${totalUsers}</h3>
                            </div>
                            <div class="bg-warning bg-opacity-10 text-warning p-3 rounded-circle fs-3">
                                <i class="fa-solid fa-users"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Total Revenue -->
                <div class="col-sm-6 col-lg-3">
                    <div class="card border-0 shadow-sm h-100" style="border-left: 5px solid #dc3545 !important;">
                        <div class="card-body d-flex align-items-center justify-content-between p-4">
                            <div>
                                <span class="text-muted d-block mb-1 small fw-bold text-uppercase">Doanh thu</span>
                                <h4 class="fw-bold text-danger mb-0" style="font-size: 1.15rem;">${totalRevenue}</h4>
                            </div>
                            <div class="bg-danger bg-opacity-10 text-danger p-3 rounded-circle fs-3">
                                <i class="fa-solid fa-money-bill-trend-up"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Action Links -->
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0"><i class="fa-solid fa-bolt me-2"></i> Lối tắt thao tác nhanh</h5>
                </div>
                <div class="card-body p-4">
                    <div class="row g-4 text-center">
                        <div class="col-sm-4">
                            <a href="${pageContext.request.contextPath}/room-category" class="d-block p-4 border rounded bg-light text-decoration-none transition-hover shadow-sm">
                                <i class="fa-solid fa-list-ul fs-2 text-warning mb-3"></i>
                                <h6 class="fw-bold text-dark mb-1">Loại Phòng</h6>
                                <p class="text-muted small mb-0">Quản lý danh mục loại phòng</p>
                            </a>
                        </div>
                        <div class="col-sm-4">
                            <a href="${pageContext.request.contextPath}/room" class="d-block p-4 border rounded bg-light text-decoration-none transition-hover shadow-sm">
                                <i class="fa-solid fa-bed fs-2 text-primary mb-3"></i>
                                <h6 class="fw-bold text-dark mb-1">Phòng khách sạn</h6>
                                <p class="text-muted small mb-0">Xem và sửa đổi trạng thái phòng</p>
                            </a>
                        </div>
                        <div class="col-sm-4">
                            <a href="${pageContext.request.contextPath}/booking?action=manage" class="d-block p-4 border rounded bg-light text-decoration-none transition-hover shadow-sm">
                                <i class="fa-solid fa-calendar-days fs-2 text-success mb-3"></i>
                                <h6 class="fw-bold text-dark mb-1">Đơn đặt phòng</h6>
                                <p class="text-muted small mb-0">Check-in, Check-out & Thanh toán</p>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
