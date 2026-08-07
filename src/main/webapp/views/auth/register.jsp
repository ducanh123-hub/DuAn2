<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Đăng ký</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">

</head>

<body>

<div class="container mt-5">

    <div class="col-md-6 mx-auto">

        <div class="auth-card shadow">

            <div class="card-header bg-success text-white">

                <h3>Đăng ký tài khoản</h3>

            </div>

            <div class="card-body">

                <c:if test="${error!=null}">
                    <div class="alert alert-danger">
                        ${error}
                    </div>
                </c:if>

                <form method="post"
                      action="${pageContext.request.contextPath}/register">

                    <div class="mb-3">

                        <label>Họ và tên</label>

                        <input type="text"
                               class="form-control"
                               name="fullName"
                               required>

                    </div>

                    <div class="mb-3">

                        <label>Email</label>

                        <input type="email"
                               class="form-control"
                               name="email"
                               required>

                    </div>

                    <div class="mb-3">

                        <label>Số điện thoại</label>

                        <input type="text"
                               class="form-control"
                               name="phone"
                               required>

                    </div>

                    <div class="mb-3">

                        <label>Mật khẩu</label>

                        <input type="password"
                               class="form-control"
                               name="password"
                               required>

                    </div>

                    <button class="btn btn-success w-100">

                        Đăng ký

                    </button>

                </form>

                <hr>

                <div class="text-center">

                    Đã có tài khoản?

                    <a href="${pageContext.request.contextPath}/login">

                        Đăng nhập

                    </a>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>