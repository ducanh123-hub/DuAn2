<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu - Luxury Hotel</title>
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

        <!-- Change Password Card -->
        <div class="col-md-8">
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h4 class="mb-0"><i class="fa-solid fa-key me-2"></i> Đổi mật khẩu tài khoản</h4>
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

                    <form method="post" action="${pageContext.request.contextPath}/user?action=updatePassword">
                        <!-- Mật khẩu cũ -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mật khẩu hiện tại</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-lock text-muted"></i></span>
                                <input type="password" name="oldPassword" class="form-control" placeholder="Nhập mật khẩu hiện tại..." required>
                            </div>
                        </div>

                        <!-- Mật khẩu mới -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mật khẩu mới</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-key text-muted"></i></span>
                                <input type="password" name="newPassword" class="form-control" placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)..." required>
                            </div>
                        </div>

                        <!-- Xác nhận mật khẩu mới -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Xác nhận mật khẩu mới</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-check-double text-muted"></i></span>
                                <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới..." required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/user?action=profile" class="btn btn-outline-secondary">
                                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại Hồ sơ
                            </a>
                            <button type="submit" class="btn btn-warning px-4 text-dark fw-bold">
                                <i class="fa-solid fa-circle-check me-1"></i> Xác nhận Đổi
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
