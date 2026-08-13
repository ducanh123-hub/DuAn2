<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Đăng ký - Luxury Hotel</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        /* =========================
           TRANG
           ========================= */

        body {

            width: 100%;
            min-height: 100vh;

            overflow: hidden;

            font-family: 'Plus Jakarta Sans', sans-serif;

            background: #000;
        }


        /* =========================
           VIDEO BACKGROUND
           ========================= */

        .video-background {

            position: fixed;

            inset: 0;

            width: 100%;
            height: 100%;

            overflow: hidden;

            z-index: -2;

            background: #000;
        }

        .video-background iframe {

            position: absolute;

            top: 50%;
            left: 50%;

            width: 100vw;
            height: 100vh;

            min-width: 177.77vh;
            min-height: 56.25vw;

            transform: translate(-50%, -50%);

            border: none;

            pointer-events: none;
        }


        /* =========================
           LỚP PHỦ TỐI
           ========================= */

        .video-overlay {

            position: fixed;

            inset: 0;

            background:
                    linear-gradient(
                            rgba(5, 15, 35, 0.55),
                            rgba(5, 15, 35, 0.72)
                    );

            z-index: -1;
        }


        /* =========================
           KHUNG TRANG
           ========================= */

        .page-container {

            width: 100%;
            min-height: 100vh;

            display: flex;

            justify-content: center;

            align-items: center;

            padding: 25px;

            overflow-y: auto;
        }


        /* =========================
           FORM ĐĂNG KÝ
           ========================= */

        .register-box {

            width: 430px;

            max-width: 100%;

            padding: 35px;

            background: rgba(255, 255, 255, 0.94);

            backdrop-filter: blur(12px);

            -webkit-backdrop-filter: blur(12px);

            border-radius: 18px;

            box-shadow:
                    0 20px 60px rgba(0, 0, 0, 0.45);

            border: 1px solid rgba(255,255,255,0.5);
        }


        /* =========================
LOGO
           ========================= */

        .logo {

            text-align: center;

            margin-bottom: 25px;
        }

        .logo i {

            font-size: 50px;

            color: #d4af37;

            margin-bottom: 10px;
        }

        .logo h3 {

            color: #0c1a30;

            font-size: 25px;

            font-weight: 800;

            text-transform: uppercase;

            margin: 0;
        }

        .logo p {

            color: #64748b;

            font-size: 13px;

            margin-top: 7px;

            margin-bottom: 0;
        }


        /* =========================
           LABEL
           ========================= */

        .form-label {

            color: #0c1a30;

            font-weight: 600;

            margin-bottom: 6px;
        }


        /* =========================
           INPUT
           ========================= */

        .form-control {

            height: 47px;

            border-radius: 8px;

            border: 1px solid #d6dce5;

            padding: 10px 14px;

            background: rgba(255,255,255,0.9);
        }

        .form-control:focus {

            border-color: #d4af37;

            box-shadow:
                    0 0 0 3px rgba(212,175,55,0.15);
        }


        /* =========================
           BUTTON
           ========================= */

        .register-btn {

            width: 100%;

            height: 48px;

            border: none;

            border-radius: 8px;

            background:
                    linear-gradient(
                            135deg,
                            #0c1a30,
                            #172d54
                    );

            color: white;

            font-weight: 700;

            text-transform: uppercase;

            transition: 0.3s;
        }

        .register-btn:hover {

            background: #d4af37;

            color: #0c1a30;

            transform: translateY(-2px);

            box-shadow:
                    0 6px 20px rgba(212,175,55,0.35);
        }


        /* =========================
           LOGIN LINK
           ========================= */

        .login-link {

            text-align: center;

            color: #64748b;

            font-size: 14px;

            margin-top: 18px;
        }

        .login-link a {

            color: #d4af37;

            font-weight: 700;

            text-decoration: none;
        }

        .login-link a:hover {

            text-decoration: underline;
        }


        /* =========================
           MOBILE
           ========================= */

        @media (max-width: 576px) {

            body {

                overflow-y: auto;
            }

            .page-container {

                padding: 15px;
            }

            .register-box {

                padding: 25px 20px;

                border-radius: 14px;
            }

            .logo h3 {
font-size: 22px;
            }

        }

    </style>

</head>


<body>


<!-- =====================================
     VIDEO BACKGROUND
     ===================================== -->

<div class="video-background">

    <iframe
            src="https://www.youtube.com/embed/SaQYFU_z1_s?autoplay=1&mute=1&controls=0&loop=1&playlist=SaQYFU_z1_s&rel=0"
            title="Luxury Hotel"
            allow="autoplay; encrypted-media">
    </iframe>

</div>


<!-- LỚP PHỦ TỐI -->

<div class="video-overlay"></div>


<!-- =====================================
     FORM
     ===================================== -->

<div class="page-container">

    <div class="register-box">


        <!-- LOGO -->

        <div class="logo">

            <i class="fa-solid fa-hotel"></i>

            <h3>
                Đăng ký tài khoản
            </h3>

            <p>
                Trải nghiệm dịch vụ Luxury Hotel
            </p>

        </div>


        <!-- THÔNG BÁO LỖI -->

        <c:if test="${error != null}">

            <div class="alert alert-danger">

                ${error}

            </div>

        </c:if>


        <!-- FORM -->

        <form method="post"
              action="${pageContext.request.contextPath}/register">


            <!-- HỌ TÊN -->

            <div class="mb-3">

                <label class="form-label">
                    Họ và tên
                </label>

                <input
                        type="text"
                        class="form-control"
                        name="fullName"
                        required>

            </div>


            <!-- EMAIL -->

            <div class="mb-3">

                <label class="form-label">
                    Email
                </label>

                <input
                        type="email"
                        class="form-control"
                        name="email"
                        required>

            </div>


            <!-- SỐ ĐIỆN THOẠI -->

            <div class="mb-3">

                <label class="form-label">
                    Số điện thoại
                </label>

                <input
                        type="text"
                        class="form-control"
                        name="phone"
                        required>

            </div>


            <!-- MẬT KHẨU -->

            <div class="mb-3">

                <label class="form-label">
                    Mật khẩu
                </label>

                <input
                        type="password"
                        class="form-control"
                        name="password"
                        required>

            </div>

            <div class="mb-3">
                <label class="form-label">Xác nhận mật khẩu</label>
                <input type="password" name="confirmPassword" class="form-control" required>
            </div>


            <!-- BUTTON -->

            <button
                    type="submit"
                    class="register-btn">

                <i class="fa-solid fa-user-plus"></i>

                Đăng ký

            </button>
</form>


        <hr>


        <!-- LOGIN -->

        <div class="login-link">

            Đã có tài khoản?

            <a href="${pageContext.request.contextPath}/login">

                Đăng nhập

            </a>

        </div>


    </div>

</div>

const confirmPassword = document.querySelector("input[name='confirmPassword']").value;

if (password !== confirmPassword) {
    e.preventDefault();
    showError("Mật khẩu xác nhận không khớp.");
    return;
}
</body>

</html>
