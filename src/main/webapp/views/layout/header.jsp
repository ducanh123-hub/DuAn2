<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* ============================== HEADER ============================== */
    #mainHeader {
        position: fixed;
        top: 0; left: 0;
        width: 100%;
        height: 70px;
        z-index: 9999;
        background-color: rgba(33, 37, 41, 0.96);
        box-shadow: 0 2px 12px rgba(0,0,0,0.2);
        backdrop-filter: blur(8px);
        -webkit-backdrop-filter: blur(8px);
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    /* Trang chủ khi chưa cuộn */
    #mainHeader.home-transparent {
        background-color: transparent;
        box-shadow: none;
        backdrop-filter: none;
        -webkit-backdrop-filter: none;
    }
    #mainHeader.scrolled {
        background-color: rgba(33, 37, 41, 0.96) !important;
        box-shadow: 0 3px 15px rgba(0,0,0,0.25) !important;
        backdrop-filter: blur(8px) !important;
        -webkit-backdrop-filter: blur(8px) !important;
    }

    /* ============================== LOGO ============================== */
    #mainHeader .navbar-brand {
        color: #ffffff !important;
        font-size: 22px;
        font-weight: 700;
        transition: color 0.2s ease;
    }
    #mainHeader .navbar-brand:hover { color: #ffc107 !important; }

    /* ============================== MENU ============================== */
    #mainHeader .nav-link {
        color: #ffffff !important;
        font-size: 16px;
        font-weight: 500;
        padding: 8px 12px;
        transition: color 0.2s ease;
    }
    #mainHeader .nav-link:hover { color: #ffc107 !important; }

    /* ============================== DROPDOWN ============================== */
    #mainHeader .dropdown-menu {
        min-width: 220px;
        margin-top: 8px;
        border: none;
        border-radius: 10px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    }
    #mainHeader .dropdown-item {
        padding: 10px 15px;
        transition: background-color 0.2s ease, color 0.2s ease;
    }
    #mainHeader .dropdown-item:hover { background-color: #f8f9fa; }

    /* ============================== MOBILE ============================== */
    #mainHeader .navbar-toggler { border-color: rgba(255,255,255,0.6); }
    #mainHeader .navbar-toggler:focus { box-shadow: none; }

    @media (max-width: 991px) {
        #mainHeader { height: 65px; }
        #mainHeader .navbar-collapse {
            margin-top: 5px;
            padding: 10px;
            background-color: rgba(33, 37, 41, 0.98);
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }
        #mainHeader .nav-link { padding: 10px 12px; }
    }

    @media (max-width: 576px) {
        #mainHeader { height: 62px; }
        #mainHeader .navbar-brand { font-size: 18px; }
    }

    /* ============================== BODY OFFSET ============================== */
    /* Trang thường: đẩy nội dung xuống dưới header cố định */
    body { padding-top: 82px; }
    /* Trang chủ: hero full screen, không cần padding */
    body.page-home { padding-top: 0; }
</style>

<nav id="mainHeader" class="navbar navbar-expand-lg navbar-dark">
    <div class="container">

        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class="fa-solid fa-hotel me-1 text-warning"></i> Luxury Hotel
        </a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Mở menu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/room">Phòng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/views/home/about.jsp">Giới thiệu</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                </li>

                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <li class="nav-item dropdown ms-lg-3">
                            <a class="nav-link dropdown-toggle fw-bold" href="#"
                               id="userDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa-solid fa-circle-user me-1 text-warning"></i>
                                ${sessionScope.user.fullName}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user?action=profile">
                                        <i class="fa-solid fa-user-gear me-2 text-muted"></i> Thông tin cá nhân
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user?action=change-password">
                                        <i class="fa-solid fa-key me-2 text-muted"></i> Đổi mật khẩu
                                    </a>
                                </li>
                                <c:if test="${sessionScope.user.roleID == 1}">
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item text-primary fw-bold"
                                           href="${pageContext.request.contextPath}/user?action=dashboard">
                                            <i class="fa-solid fa-gauge me-2"></i> Bảng điều khiển
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.user.roleID == 1 || sessionScope.user.roleID == 2}">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/booking?action=manage">
                                            <i class="fa-solid fa-calendar-check me-2 text-muted"></i> Danh Mục
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.user.roleID == 3}">
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/booking?action=history">
                                            <i class="fa-solid fa-clock-rotate-left me-2 text-muted"></i> Lịch sử đặt phòng
                                        </a>
                                    </li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a>
                        </li>
                    </c:otherwise>
                </c:choose>

            </ul>
        </div>
    </div>
</nav>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const header = document.getElementById("mainHeader");
        if (!header) return;

        const path = window.location.pathname;
        const ctx  = "${pageContext.request.contextPath}";

        // Trang chủ khi URL là /contextPath/ hoặc /contextPath/home
        const isHome = path === ctx + "/"
                    || path === ctx + "/home"
                    || path === ctx + "/home/"
                    || path === "/"
                    || path === "/home"
                    || path === "/home/";

        if (isHome) {
            document.body.classList.add("page-home");
        }

        function updateHeader() {
            if (isHome && window.scrollY <= 50) {
                header.classList.add("home-transparent");
                header.classList.remove("scrolled");
            } else {
                header.classList.remove("home-transparent");
                header.classList.add("scrolled");
            }
        }

        updateHeader();
        window.addEventListener("scroll", updateHeader, { passive: true });
    });
</script>
