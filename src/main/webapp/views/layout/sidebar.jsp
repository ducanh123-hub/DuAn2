<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card shadow border-0 mb-4">
    <div class="card-header bg-dark text-white py-3">
        <h5 class="mb-0"><i class="fa-solid fa-bars me-2"></i> Danh mục</h5>
    </div>
    <div class="list-group list-group-flush">

        <c:choose>
            <c:when test="${sessionScope.user != null}">

                <%-- ===== QUAN_LY (RoleID = 1) ===== --%>
                <c:if test="${sessionScope.user.roleID == 1}">
                    <div class="bg-warning bg-opacity-10 px-3 py-2 fw-bold text-warning small border-top border-bottom text-uppercase">
                        <i class="fa-solid fa-shield-halved me-1"></i> Quản trị hệ thống
                    </div>
                    <a href="${pageContext.request.contextPath}/admin"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-gauge me-2 text-warning"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/room-category"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-list-ul me-2 text-warning"></i> Quản lý danh mục phòng
                    </a>
                    <a href="${pageContext.request.contextPath}/room?action=admin-list"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-bed me-2 text-warning"></i> Quản lý phòng
                    </a>
                    <a href="${pageContext.request.contextPath}/booking?action=manage"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-calendar-check me-2 text-warning"></i> Quản lý đơn đặt phòng
                    </a>
                    <a href="${pageContext.request.contextPath}/user?action=admin-list"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-users me-2 text-warning"></i> Quản lý người dùng
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/permission"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-key me-2 text-warning"></i> Phân quyền
                    </a>
                    <a href="${pageContext.request.contextPath}/review?action=admin-list"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-comments me-2 text-warning"></i> Quản lý bình luận
                    </a>
                    <a href="${pageContext.request.contextPath}/promotion"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-tags me-2 text-warning"></i> Quản lý khuyến mãi
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/payment"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-credit-card me-2 text-warning"></i> Quản lý thanh toán
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/report?tab=revenue"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-chart-line me-2 text-warning"></i> Thống kê doanh thu
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/report?tab=customer"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-chart-pie me-2 text-warning"></i> Thống kê khách hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/system-log"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-scroll me-2 text-warning"></i> Nhật ký hệ thống
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/contact"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-envelope-open-text me-2 text-warning"></i> Quản lý liên hệ
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/setting"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-gear me-2 text-warning"></i> Cấu hình hệ thống
                    </a>
                    <div class="bg-light px-3 py-2 fw-bold text-muted small border-top border-bottom text-uppercase">
                        Tài khoản
                    </div>
                    <a href="${pageContext.request.contextPath}/user?action=profile"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-user-gear me-2 text-secondary"></i> Thông tin cá nhân
                    </a>
                    <a href="${pageContext.request.contextPath}/user?action=change-password"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-lock me-2 text-secondary"></i> Đổi mật khẩu
                    </a>
                </c:if>

                <%-- ===== NHAN_VIEN (RoleID = 2) ===== --%>
                <c:if test="${sessionScope.user.roleID == 2}">
                    <div class="bg-light px-3 py-2 fw-bold text-muted small border-top border-bottom text-uppercase">
                        Khu vực nhân viên
                    </div>
                    <a href="${pageContext.request.contextPath}/booking?action=manage"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-calendar-check me-2 text-info"></i> Quản lý đặt phòng
                    </a>
                    <a href="${pageContext.request.contextPath}/user?action=profile"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-user-gear me-2 text-secondary"></i> Thông tin cá nhân
                    </a>
                    <a href="${pageContext.request.contextPath}/user?action=change-password"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-lock me-2 text-secondary"></i> Đổi mật khẩu
                    </a>
                </c:if>

                <%-- ===== KHACH_HANG (RoleID = 3) ===== --%>
                <c:if test="${sessionScope.user.roleID == 3}">
                    <div class="bg-light px-3 py-2 fw-bold text-muted small border-top border-bottom text-uppercase">
                        Khu vực khách hàng
                    </div>
                    <a href="${pageContext.request.contextPath}/booking?action=history"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-clock-rotate-left me-2 text-success"></i> Lịch sử đặt phòng
                    </a>
                    <a href="${pageContext.request.contextPath}/user?action=profile"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-user-gear me-2 text-secondary"></i> Thông tin cá nhân
                    </a>
                    <a href="${pageContext.request.contextPath}/user?action=change-password"
                       class="list-group-item list-group-item-action py-3">
                        <i class="fa-solid fa-lock me-2 text-secondary"></i> Đổi mật khẩu
                    </a>
                </c:if>

                <%-- ===== Đăng xuất (tất cả vai trò) ===== --%>
                <a href="${pageContext.request.contextPath}/logout"
                   class="list-group-item list-group-item-action list-group-item-danger py-3 border-top">
                    <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                </a>

            </c:when>
            <c:otherwise>
                <%-- ===== Khách vãng lai ===== --%>
                <a href="${pageContext.request.contextPath}/home"
                   class="list-group-item list-group-item-action py-3">
                    <i class="fa-solid fa-house me-2 text-primary"></i> Trang chủ
                </a>
                <a href="${pageContext.request.contextPath}/room"
                   class="list-group-item list-group-item-action py-3">
                    <i class="fa-solid fa-bed me-2 text-primary"></i> Danh sách phòng
                </a>
                <a href="${pageContext.request.contextPath}/login"
                   class="list-group-item list-group-item-action py-3">
                    <i class="fa-solid fa-right-to-bracket me-2 text-success"></i> Đăng nhập
                </a>
                <a href="${pageContext.request.contextPath}/register"
                   class="list-group-item list-group-item-action py-3">
                    <i class="fa-solid fa-user-plus me-2 text-success"></i> Đăng ký tài khoản
                </a>
            </c:otherwise>
        </c:choose>

    </div>
</div>
