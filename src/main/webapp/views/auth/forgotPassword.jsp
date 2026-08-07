<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Khôi phục mật khẩu - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
</head>
<body class="bg-light">

<div class="login-box">
    <div class="logo">
        <i class="fa-solid fa-key text-warning fa-2x"></i>
        <h3 class="mt-3">Quên mật khẩu?</h3>
        <p class="text-muted small">Nhập email đăng ký của bạn để khôi phục mật khẩu</p>
    </div>

    <c:if test="${error != null}">
        <div class="alert alert-danger animate__animated animate__fadeIn">
            <i class="fa-solid fa-triangle-exclamation me-2"></i> ${error}
        </div>
    </c:if>

    <c:if test="${message != null}">
        <div class="alert alert-success animate__animated animate__fadeIn">
            <i class="fa-solid fa-circle-check me-2"></i> ${message}
        </div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/forgot-password">
        <div class="mb-3">
            <label class="form-label fw-bold">Địa chỉ Email</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-envelope text-muted"></i></span>
                <input type="email" name="email" class="form-control" placeholder="example@gmail.com" required>
            </div>
        </div>

        <button class="btn btn-warning w-100 fw-bold text-dark mt-2 py-2">
            <i class="fa-solid fa-paper-plane me-1"></i> Gửi yêu cầu khôi phục
        </button>
    </form>

    <hr class="my-4">

    <div class="text-center">
        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại Đăng nhập
        </a>
    </div>
</div>

</body>
</html>
