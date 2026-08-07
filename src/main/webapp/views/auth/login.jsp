<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Đăng nhập - Luxury Hotel</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">

</head>

<body>

<div class="login-box">

    <div class="logo">

        <i class="fa-solid fa-hotel"></i>

        <h3 class="mt-3">
            Luxury Hotel
        </h3>

    </div>

    <c:if test="${error != null}">
        <div class="alert alert-danger">
            ${error}
        </div>
    </c:if>

    <form method="post"
          action="${pageContext.request.contextPath}/login">

        <div class="mb-3">

            <label class="form-label">Email</label>

            <input type="email"
                   name="email"
                   class="form-control"
                   required>

        </div>

        <div class="mb-3">

            <label class="form-label">Mật khẩu</label>

            <input type="password"
                   name="password"
                   class="form-control"
                   required>

        </div>

        <button class="btn btn-primary w-100">

            <i class="fa-solid fa-right-to-bracket"></i>

            Đăng nhập

        </button>

    </form>

    <hr>

    <div class="text-center">

        Chưa có tài khoản?

        <a href="${pageContext.request.contextPath}/register">

            Đăng ký ngay

        </a>

    </div>

</div>

</body>

</html>