<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin cá nhân - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <!-- Sidebar Navigation -->
        <div class="col-md-4">
            <jsp:include page="../layout/sidebar.jsp"/>
        </div>

        <!-- Profile Form Card -->
        <div class="col-md-8">
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h4 class="mb-0"><i class="fa-solid fa-user-gear me-2"></i> Thông tin cá nhân của bạn</h4>
                </div>
                <div class="card-body p-4">
                    
                    <c:if test="${message != null}">
                        <div class="alert alert-success animate__animated animate__fadeIn">
                            <i class="fa-solid fa-circle-check me-2"></i> ${message}
                        </div>
                    </c:if>
                    <c:if test="${error != null}">
                        <div class="alert alert-danger animate__animated animate__fadeIn">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i> ${error}
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/user?action=updateProfile">
                        <div class="row">
                            <!-- Họ và tên -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Họ và tên</label>
                                <input type="text" name="fullName" class="form-control" value="${profileUser.fullName}" required>
                            </div>
                            
                            <!-- Email (Read-only) -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Email đăng nhập</label>
                                <input type="email" class="form-control bg-light" value="${profileUser.email}" readonly>
                            </div>
                        </div>

                        <div class="row">
                            <!-- Số điện thoại -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Số điện thoại</label>
                                <input type="text" name="phone" class="form-control" value="${profileUser.phone}" required>
                            </div>

                            <!-- Giới tính -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Giới tính</label>
                                <select name="gender" class="form-select">
                                    <option value="Nam" ${profileUser.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                    <option value="Nữ" ${profileUser.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                    <option value="Khác" ${profileUser.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <!-- Ngày sinh -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Ngày sinh</label>
                                <input type="date" name="date" class="form-control" value="${profileUser.date}">
                            </div>

                            <!-- CCCD / Hộ chiếu -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Số CCCD / Hộ chiếu</label>
                                <input type="text" name="cccd" class="form-control" value="${profileUser.cccd}">
                            </div>
                        </div>

                        <!-- Địa chỉ -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Địa chỉ cư trú</label>
                            <input type="text" name="address" class="form-control" value="${profileUser.address}">
                        </div>

                        <!-- Quốc tịch -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Quốc tịch</label>
                            <input type="text" name="nationality" class="form-control" value="${profileUser.nationality}">
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/user?action=change-password" class="btn btn-outline-danger">
                                <i class="fa-solid fa-lock me-1"></i> Đổi mật khẩu
                            </a>
                            <button type="submit" class="btn btn-success px-4">
                                <i class="fa-solid fa-save me-1"></i> Lưu thay đổi
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
