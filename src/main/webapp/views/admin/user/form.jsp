<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${not empty editUser}">Chỉnh sửa người dùng</c:when>
            <c:otherwise>Thêm người dùng</c:otherwise>
        </c:choose>
    </title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/admin.css">

    <style>
        .user-form-card{max-width:1000px;margin:auto}
        .form-label{font-weight:600}
    </style>
</head>

<body class="bg-light">

<jsp:include page="../../layout/header.jsp"/>

<div class="container-fluid mt-4">
    <div class="row">

        <div class="col-md-3">
            <jsp:include page="../../layout/sidebar.jsp"/>
        </div>

        <div class="col-md-9">
            <div class="user-form-card">

                <div class="mb-4">
                    <h3 class="fw-bold text-primary mb-1">
                        <c:choose>
                            <c:when test="${not empty editUser}">
                                Chỉnh sửa người dùng
                            </c:when>
                            <c:otherwise>
                                Thêm người dùng
                            </c:otherwise>
                        </c:choose>
                    </h3>

                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/user?action=dashboard">
                                    Dashboard
                                </a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/user?action=list">
                                    Quản lý người dùng
                                </a>
                            </li>
                            <li class="breadcrumb-item active">
                                <c:choose>
                                    <c:when test="${not empty editUser}">
                                        Chỉnh sửa
                                    </c:when>
                                    <c:otherwise>
                                        Thêm mới
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </ol>
                    </nav>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        ${error}
                    </div>
                </c:if>

                <div class="card shadow border-0">
                    <div class="card-header bg-dark text-white py-3">
                        <h5 class="mb-0">
                            <c:choose>
                                <c:when test="${not empty editUser}">
                                    Thông tin người dùng
                                </c:when>
                                <c:otherwise>
                                    Thông tin tài khoản mới
                                </c:otherwise>
                            </c:choose>
                        </h5>
                    </div>

                    <div class="card-body p-4">

                        <form action="${pageContext.request.contextPath}/user"
                              method="post">

                            <c:choose>

                                <c:when test="${not empty editUser}">
                                    <input type="hidden"
                                           name="action"
                                           value="updateUser">

                                    <input type="hidden"
                                           name="userID"
                                           value="${editUser.userID}">
                                </c:when>

                                <c:otherwise>
                                    <input type="hidden"
                                           name="action"
                                           value="createUser">
                                </c:otherwise>

                            </c:choose>

                            <div class="row g-3">

                                <div class="col-md-6">
                                    <label class="form-label">
                                        Họ tên <span class="text-danger">*</span>
                                    </label>

                                    <input type="text"
                                           name="fullName"
                                           class="form-control"
                                           value="${not empty editUser ? editUser.fullName : user.fullName}"
                                           required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">
                                        Email <span class="text-danger">*</span>
                                    </label>

                                    <input type="email"
                                           name="email"
                                           class="form-control"
                                           value="${not empty editUser ? editUser.email : user.email}"
                                           <c:if test="${not empty editUser}">readonly</c:if>
                                           required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">
                                        Số điện thoại
                                    </label>

                                    <input type="text"
                                           name="phone"
                                           class="form-control"
                                           value="${not empty editUser ? editUser.phone : user.phone}">
                                </div>

                                <c:if test="${empty editUser}">
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            Mật khẩu <span class="text-danger">*</span>
                                        </label>

                                        <input type="password"
                                               name="password"
                                               class="form-control"
                                               minlength="6"
                                               required>
                                    </div>
                                </c:if>

                                <div class="col-md-6">
                                    <label class="form-label">
                                        Vai trò <span class="text-danger">*</span>
                                    </label>

                                    <select name="roleID"
                                            class="form-select"
                                            required>

                                        <option value="3"
                                            ${not empty editUser && editUser.roleID == 3 ? 'selected' : ''}>
                                            Khách hàng
                                        </option>

                                        <option value="2"
                                            ${not empty editUser && editUser.roleID == 2 ? 'selected' : ''}>
                                            Nhân viên
                                        </option>

                                        <c:if test="${not empty editUser && editUser.roleID == 1}">
                                            <option value="1" selected>
                                                Quản lý
                                            </option>
                                        </c:if>

                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">
                                        Giới tính
                                    </label>

                                    <select name="gender"
                                            class="form-select">

                                        <option value="">-- Chọn --</option>

                                        <option value="Nam"
                                            ${not empty editUser && editUser.gender == 'Nam' ? 'selected' : ''}>
                                            Nam
                                        </option>

                                        <option value="Nữ"
                                            ${not empty editUser && editUser.gender == 'Nữ' ? 'selected' : ''}>
                                            Nữ
                                        </option>

                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">
                                        Ngày sinh
                                    </label>

                                    <input type="date"
                                           name="date"
                                           class="form-control"
                                           value="${not empty editUser ? editUser.date : user.date}">
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">
                                        CCCD
                                    </label>

                                    <input type="text"
                                           name="cccd"
                                           class="form-control"
                                           value="${not empty editUser ? editUser.cccd : user.cccd}">
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">
                                        Quốc tịch
                                    </label>

                                    <input type="text"
                                           name="nationality"
                                           class="form-control"
                                           value="${not empty editUser ? editUser.nationality : user.nationality}">
                                </div>

                                <div class="col-12">
                                    <label class="form-label">
                                        Địa chỉ
                                    </label>

                                    <input type="text"
                                           name="address"
                                           class="form-control"
                                           value="${not empty editUser ? editUser.address : user.address}">
                                </div>

                                <c:if test="${not empty editUser}">
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            Trạng thái
                                        </label>

                                        <select name="status"
                                                class="form-select">

                                            <option value="Active"
                                                ${editUser.status == 'Active' ? 'selected' : ''}>
                                                Hoạt động
                                            </option>

                                            <option value="Locked"
                                                ${editUser.status == 'Locked' ? 'selected' : ''}>
                                                Đã khóa
                                            </option>

                                            <option value="Pending"
                                                ${editUser.status == 'Pending' ? 'selected' : ''}>
                                                Chờ xác minh
                                            </option>

                                        </select>
                                    </div>
                                </c:if>

                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4">

                                <a href="${pageContext.request.contextPath}/user?action=list"
                                   class="btn btn-secondary">
                                    Hủy
                                </a>

                                <button type="submit"
                                        class="btn btn-primary">

                                    <c:choose>
                                        <c:when test="${not empty editUser}">
                                            Lưu thay đổi
                                        </c:when>
                                        <c:otherwise>
                                            Thêm người dùng
                                        </c:otherwise>
                                    </c:choose>

                                </button>

                            </div>

                        </form>

                    </div>
                </div>

            </div>
        </div>

    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>