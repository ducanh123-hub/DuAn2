<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card shadow border-0 mb-4">
    <div class="card-header bg-dark text-white py-3">
        <h5 class="mb-0"><i class="fa-solid fa-bars me-2"></i> Danh mục quản lý</h5>
    </div>
    <div class="list-group list-group-flush">
        <!-- General Links -->
        <a href="${pageContext.request.contextPath}/home" class="list-group-item list-group-item-action py-3">
            <i class="fa-solid fa-house me-2 text-primary"></i> Trang chủ
        </a>
        <a href="${pageContext.request.contextPath}/room" class="list-group-item list-group-item-action py-3">
            <i class="fa-solid fa-bed me-2 text-primary"></i> Danh sách phòng
        </a>

        <!-- Role-Based Content -->
        <c:choose>
            <c:when test="${sessionScope.user != null}">
                <!-- Shared Profile Link -->
                <a href="${pageContext.request.contextPath}/user?action=profile" class="list-group-item list-group-item-action py-3">
                    <i class="fa-solid fa-user-gear me-2 text-secondary"></i> Thông tin cá nhân
                </a>
                <a href="${pageContext.request.contextPath}/user?action=change-password" class="list-group-item list-group-item-action py-3">
                    <i class="fa-solid fa-key me-2 text-secondary"></i> Đổi mật khẩu
                </a>

                <!-- Admin Panel (Role 1) -->
                <c:if test="${sessionScope.user.roleID == 1}">
                    <div class="bg-light px-3 py-2 fw-bold text-muted small border-top border-bottom text-uppercase">
                        Quản trị hệ thống
                    </div>
                    <a href="${pageContext.request.contextPath}/user?action=dashboard" class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-gauge me-2 text-warning"></i> Bảng điều khiển
                    </a>
                    <a href="${pageContext.request.contextPath}/booking?action=manage" class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-calendar-check me-2 text-warning"></i> Quản lý đặt phòng
                    </a>
                    <a href="${pageContext.request.contextPath}/room-category" class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-list-ul me-2 text-warning"></i> Quản lý loại phòng
                    </a>
                    <a href="${pageContext.request.contextPath}/room" class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-sliders me-2 text-warning"></i> Quản lý phòng
                    </a>
                    <a href="${pageContext.request.contextPath}/user" class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-users me-2 text-warning"></i> Quản lý người dùng
                    </a>
                </c:if>

                <!-- Employee Panel (Role 2) -->
                <c:if test="${sessionScope.user.roleID == 2}">
                    <div class="bg-light px-3 py-2 fw-bold text-muted small border-top border-bottom text-uppercase">
                        Khu vực nhân viên
                    </div>
                    <a href="${pageContext.request.contextPath}/booking?action=manage" class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-calendar-check me-2 text-info"></i> Quản lý đặt phòng
                    </a>
                </c:if>

                <!-- Customer Panel (Role 3) -->
                <c:if test="${sessionScope.user.roleID == 3}">
                    <div class="bg-light px-3 py-2 fw-bold text-muted small border-top border-bottom text-uppercase">
                        Khu vực khách hàng
                    </div>
                    <a href="${pageContext.request.contextPath}/booking?action=history" class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-clock-rotate-left me-2 text-success"></i> Lịch sử đặt phòng
                    </a>
                </c:if>

                <!-- Logout Link -->
                <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action list-group-item-danger py-3 border-top">
                    <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                </a>
            </c:when>
            <c:otherwise>
                <!-- Guest Options -->
                <a href="${pageContext.request.contextPath}/login" class="list-group-item list-group-item-action py-3">
                    <i class="fa-solid fa-right-to-bracket me-2 text-success"></i> Đăng nhập
                </a>
                <a href="${pageContext.request.contextPath}/register" class="list-group-item list-group-item-action py-3">
                    <i class="fa-solid fa-user-plus me-2 text-success"></i> Đăng ký tài khoản
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
