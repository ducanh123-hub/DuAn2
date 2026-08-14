<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Quản lý - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <jsp:include page="../layout/sidebar.jsp"/>
        </div>

        <!-- Nội dung Dashboard -->
        <div class="col-md-9">

            <!-- Tiêu đề -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold text-primary mb-1">
                        <i class="fa-solid fa-gauge me-2"></i>Bảng điều khiển
                    </h2>
                    <p class="text-muted mb-0">
                        Chào mừng quay trở lại, <strong>${sessionScope.user.fullName}</strong>!
                    </p>
                </div>
                <div class="text-muted small">
                    <i class="fa-regular fa-clock me-1"></i>
                    Hôm nay: <strong class="text-dark">
                        <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %>
                    </strong>
                </div>
            </div>

            <!-- Thống kê nhanh - Hàng 1 -->
            <div class="row g-4 mb-4">
                <!-- Tổng phòng -->
                <div class="col-sm-6 col-lg-3">
                    <div class="card border-0 shadow-sm h-100" style="border-left: 4px solid #0d6efd !important;">
                        <div class="card-body d-flex align-items-center justify-content-between p-4">
                            <div>
                                <span class="text-muted d-block mb-1 small fw-bold text-uppercase">Số phòng</span>
                                <h3 class="fw-bold text-dark mb-0">${totalRooms}</h3>
                            </div>
                            <div class="bg-primary bg-opacity-10 text-primary p-3 rounded-circle fs-3">
                                <i class="fa-solid fa-bed"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 pb-3 px-4">
                            <a href="${pageContext.request.contextPath}/room?action=admin-list"
                               class="text-primary small text-decoration-none">
                                Xem tất cả <i class="fa-solid fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Đơn đặt phòng -->
                <div class="col-sm-6 col-lg-3">
                    <div class="card border-0 shadow-sm h-100" style="border-left: 4px solid #198754 !important;">
                        <div class="card-body d-flex align-items-center justify-content-between p-4">
                            <div>
                                <span class="text-muted d-block mb-1 small fw-bold text-uppercase">Đặt phòng</span>
                                <h3 class="fw-bold text-dark mb-0">${totalBookings}</h3>
                            </div>
                            <div class="bg-success bg-opacity-10 text-success p-3 rounded-circle fs-3">
                                <i class="fa-solid fa-calendar-check"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 pb-3 px-4">
                            <a href="${pageContext.request.contextPath}/booking?action=manage"
                               class="text-success small text-decoration-none">
                                Xem tất cả <i class="fa-solid fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Người dùng -->
                <div class="col-sm-6 col-lg-3">
                    <div class="card border-0 shadow-sm h-100" style="border-left: 4px solid #fd7e14 !important;">
                        <div class="card-body d-flex align-items-center justify-content-between p-4">
                            <div>
                                <span class="text-muted d-block mb-1 small fw-bold text-uppercase">Thành viên</span>
                                <h3 class="fw-bold text-dark mb-0">${totalUsers}</h3>
                            </div>
                            <div class="bg-warning bg-opacity-10 text-warning p-3 rounded-circle fs-3">
                                <i class="fa-solid fa-users"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 pb-3 px-4">
                            <a href="${pageContext.request.contextPath}/user?action=admin-list"
                               class="text-warning small text-decoration-none">
                                Xem tất cả <i class="fa-solid fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Doanh thu -->
                <div class="col-sm-6 col-lg-3">
                    <div class="card border-0 shadow-sm h-100" style="border-left: 4px solid #dc3545 !important;">
                        <div class="card-body d-flex align-items-center justify-content-between p-4">
                            <div>
                                <span class="text-muted d-block mb-1 small fw-bold text-uppercase">Doanh thu</span>
                                <h5 class="fw-bold text-danger mb-0" style="font-size:1rem;">
                                    <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/>đ
                                </h5>
                            </div>
                            <div class="bg-danger bg-opacity-10 text-danger p-3 rounded-circle fs-3">
                                <i class="fa-solid fa-money-bill-trend-up"></i>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-0 pb-3 px-4">
                            <a href="${pageContext.request.contextPath}/admin/report?tab=revenue"
                               class="text-danger small text-decoration-none">
                                Chi tiết <i class="fa-solid fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hàng 2 - Thống kê bổ sung -->
            <div class="row g-4 mb-4">
                <div class="col-sm-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body p-4">
                            <h6 class="fw-bold text-muted mb-1 text-uppercase small">
                                <i class="fa-solid fa-user-plus me-1 text-info"></i>Khách hàng mới tháng này
                            </h6>
                            <h2 class="fw-bold text-info mb-0">${newCustomersThisMonth}</h2>
                            <small class="text-muted">khách hàng mới</small>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-body p-4">
                            <h6 class="fw-bold text-muted mb-1 text-uppercase small">
                                <i class="fa-solid fa-check-circle me-1 text-success"></i>Lượt lưu trú hoàn thành
                            </h6>
                            <h2 class="fw-bold text-success mb-0">${completedBookings}</h2>
                            <small class="text-muted">đơn hoàn thành</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tình trạng phòng -->
            <c:if test="${not empty roomOccupancy}">
                <div class="card shadow border-0 mb-4">
                    <div class="card-header bg-dark text-white py-3">
                        <h5 class="mb-0"><i class="fa-solid fa-hotel me-2"></i>Tình trạng phòng hiện tại</h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="row g-3">
                            <c:forEach var="entry" items="${roomOccupancy}">
                                <div class="col-sm-4 col-md-3 text-center">
                                    <div class="p-3 border rounded bg-light">
                                        <div class="fw-bold fs-4 text-dark">${entry.value}</div>
                                        <div class="text-muted small">${entry.key}</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Lối tắt thao tác nhanh -->
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0"><i class="fa-solid fa-bolt me-2"></i>Lối tắt thao tác nhanh</h5>
                </div>
                <div class="card-body p-4">
                    <div class="row g-3 text-center">
                        <div class="col-sm-4 col-lg-3">
                            <a href="${pageContext.request.contextPath}/room-category"
                               class="d-block p-3 border rounded bg-light text-decoration-none shadow-sm">
                                <i class="fa-solid fa-list-ul fs-2 text-warning mb-2"></i>
                                <div class="fw-bold text-dark small">Danh mục phòng</div>
                            </a>
                        </div>
                        <div class="col-sm-4 col-lg-3">
                            <a href="${pageContext.request.contextPath}/room?action=admin-list"
                               class="d-block p-3 border rounded bg-light text-decoration-none shadow-sm">
                                <i class="fa-solid fa-bed fs-2 text-primary mb-2"></i>
                                <div class="fw-bold text-dark small">Quản lý phòng</div>
                            </a>
                        </div>
                        <div class="col-sm-4 col-lg-3">
                            <a href="${pageContext.request.contextPath}/booking?action=manage"
                               class="d-block p-3 border rounded bg-light text-decoration-none shadow-sm">
                                <i class="fa-solid fa-calendar-days fs-2 text-success mb-2"></i>
                                <div class="fw-bold text-dark small">Đơn đặt phòng</div>
                            </a>
                        </div>
                        <div class="col-sm-4 col-lg-3">
                            <a href="${pageContext.request.contextPath}/user?action=admin-list"
                               class="d-block p-3 border rounded bg-light text-decoration-none shadow-sm">
                                <i class="fa-solid fa-users fs-2 text-info mb-2"></i>
                                <div class="fw-bold text-dark small">Người dùng</div>
                            </a>
                        </div>
                        <div class="col-sm-4 col-lg-3">
                            <a href="${pageContext.request.contextPath}/review?action=admin-list"
                               class="d-block p-3 border rounded bg-light text-decoration-none shadow-sm">
                                <i class="fa-solid fa-comments fs-2 text-secondary mb-2"></i>
                                <div class="fw-bold text-dark small">Bình luận</div>
                            </a>
                        </div>
                        <div class="col-sm-4 col-lg-3">
                            <a href="${pageContext.request.contextPath}/promotion"
                               class="d-block p-3 border rounded bg-light text-decoration-none shadow-sm">
                                <i class="fa-solid fa-tags fs-2 text-danger mb-2"></i>
                                <div class="fw-bold text-dark small">Khuyến mãi</div>
                            </a>
                        </div>
                        <div class="col-sm-4 col-lg-3">
                            <a href="${pageContext.request.contextPath}/admin/payment"
                               class="d-block p-3 border rounded bg-light text-decoration-none shadow-sm">
                                <i class="fa-solid fa-credit-card fs-2 text-warning mb-2"></i>
                                <div class="fw-bold text-dark small">Thanh toán</div>
                            </a>
                        </div>
                        <div class="col-sm-4 col-lg-3">
                            <a href="${pageContext.request.contextPath}/admin/setting"
                               class="d-block p-3 border rounded bg-light text-decoration-none shadow-sm">
                                <i class="fa-solid fa-gear fs-2 text-muted mb-2"></i>
                                <div class="fw-bold text-dark small">Cấu hình</div>
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
