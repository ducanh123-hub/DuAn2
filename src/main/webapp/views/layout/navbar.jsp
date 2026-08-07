<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg bg-dark navbar-dark">

    <div class="container">

        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/home">
            <i class="fa-solid fa-hotel me-1 text-warning"></i> Luxury Hotel
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        Trang chủ
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/room">
                        Phòng
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/views/home/about.jsp">
                        Giới thiệu
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">
                        Liên hệ
                    </a>
                </li>

                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <!-- Logged In Dropdown Options -->
                        <li class="nav-item dropdown ms-lg-3">
                            <a class="nav-link dropdown-toggle text-white fw-bold" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa-solid fa-circle-user me-1 text-warning"></i>
                                ${sessionScope.user.fullName}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0" aria-labelledby="userDropdown" style="min-width: 200px;">
                                <li>
                                    <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/user?action=profile">
                                        <i class="fa-solid fa-user-gear me-2 text-muted"></i> Thông tin cá nhân
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/user?action=change-password">
                                        <i class="fa-solid fa-key me-2 text-muted"></i> Đổi mật khẩu
                                    </a>
                                </li>
                                
                                <c:if test="${sessionScope.user.roleID == 1}">
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item py-2 fw-bold text-primary" href="${pageContext.request.contextPath}/user?action=dashboard">
                                            <i class="fa-solid fa-gauge me-2"></i> Bảng điều khiển
                                        </a>
                                    </li>
                                </c:if>
                                
                                <c:if test="${sessionScope.user.roleID == 1 || sessionScope.user.roleID == 2}">
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/booking?action=manage">
                                            <i class="fa-solid fa-calendar-check me-2 text-muted"></i> Quản lý đặt phòng
                                        </a>
                                    </li>
                                </c:if>
                                
                                <c:if test="${sessionScope.user.roleID == 3}">
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/booking?action=history">
                                            <i class="fa-solid fa-clock-rotate-left me-2 text-muted"></i> Lịch sử đặt phòng
                                        </a>
                                    </li>
                                </c:if>
                                
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- Guest Options -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                Đăng ký
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>

            </ul>
        </div>

    </div>

</nav>
