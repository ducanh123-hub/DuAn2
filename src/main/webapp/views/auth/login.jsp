<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Đăng nhập - Luxury Hotel</title>

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

        body {
            min-height: 100vh;

            background-image:
                linear-gradient(
                    rgba(13, 27, 53, 0.65),
                    rgba(13, 27, 53, 0.65)
                ),
                url("https://ticotravel.com.vn/wp-content/uploads/2023/06/Thiet-ke-chua-co-ten-1.jpg");

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 30px;

            font-family: 'Plus Jakarta Sans', sans-serif;
        }


        /* =========================
           KHUNG LOGIN
           ========================= */

        .login-container {

            width: 1100px;
            max-width: 100%;

            min-height: 650px;

            display: flex;

            background: white;

            border-radius: 20px;

            overflow: hidden;

            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.4);
        }


        /* =========================
           BÊN TRÁI - VIDEO
           ========================= */

        .video-section {

            width: 55%;

            position: relative;

            background: #000;

            overflow: hidden;
        }

        .video-section iframe {

            position: absolute;

            width: 100%;
            height: 100%;

            top: 0;
            left: 0;

            border: none;
        }


        /* Lớp chữ trên video */

        .video-overlay {

            position: absolute;

            left: 0;
            bottom: 0;

            width: 100%;

            padding: 40px;

            color: white;

            background: linear-gradient(
                transparent,
                rgba(0, 0, 0, 0.85)
            );

            z-index: 2;
        }

        .video-overlay h2 {

            font-size: 30px;

            font-weight: 700;
        }

        .video-overlay p {

            margin-top: 10px;

            opacity: 0.9;

            font-size: 15px;
        }


        /* =========================
           BÊN PHẢI - LOGIN
           ========================= */

        .login-section {

            width: 45%;

            display: flex;
align-items: center;

            justify-content: center;

            padding: 50px;

            background: rgba(255, 255, 255, 0.97);
        }

        .login-box {

            width: 100%;

            max-width: 400px;

            padding: 0;
        }


        /* =========================
           LOGO
           ========================= */

        .logo {

            text-align: center;

            margin-bottom: 30px;
        }

        .logo i {

            font-size: 55px;

            color: #d4af37;

            filter:
                drop-shadow(
                    0 2px 5px
                    rgba(212, 175, 55, 0.3)
                );
        }

        .logo h3 {

            margin-top: 15px;

            font-weight: 800;

            color: #10213d;

            letter-spacing: 1px;
        }


        /* =========================
           INPUT
           ========================= */

        .form-label {

            font-weight: 600;

            color: #24344d;

            margin-bottom: 6px;
        }

        .form-control {

            height: 50px;

            border-radius: 8px;

            border: 1px solid #d6dce5;

            padding: 12px 16px;

            transition: all 0.3s ease;
        }

        .form-control:focus {

            border-color: #d4af37;

            box-shadow:
                0 0 0 3px
                rgba(212, 175, 55, 0.2);
        }


        /* =========================
           NÚT ĐĂNG NHẬP
           ========================= */

        .login-btn {

            width: 100%;

            height: 50px;

            border: none;

            border-radius: 8px;

            background:
                linear-gradient(
                    135deg,
                    #0c1a30,
                    #162a4a
                );

            color: white;

            font-weight: 700;

            font-size: 16px;

            transition: all 0.3s ease;
        }

        .login-btn:hover {

            background:
                linear-gradient(
                    135deg,
                    #162a4a,
                    #213f6f
                );

            box-shadow:
                0 4px 15px
                rgba(22, 42, 74, 0.4);

            transform: translateY(-1px);
        }


        /* =========================
           ĐĂNG KÝ
           ========================= */

        .register-link {

            text-align: center;

            margin-top: 20px;

            color: #555;
        }

        .register-link a {

            color: #d4af37;

            text-decoration: none;

            font-weight: 600;
        }

        .register-link a:hover {

            color: #c5a028;

            text-decoration: underline;
        }


        hr {

            border-color: #e2e8f0;

            opacity: 0.8;
        }


        /* =========================
           MOBILE
           ========================= */
@media (max-width: 768px) {

            body {

                padding: 15px;
            }

            .login-container {

                flex-direction: column;

                min-height: auto;
            }

            .video-section {

                width: 100%;

                height: 300px;
            }

            .login-section {

                width: 100%;

                padding: 35px 25px;
            }

            .video-overlay {

                padding: 20px;
            }

            .video-overlay h2 {

                font-size: 22px;
            }
        }

    </style>

</head>

<body>

<div class="login-container">

    <!-- =========================
         VIDEO BÊN TRÁI
         ========================= -->

    <div class="video-section">

        <iframe
            src="https://www.youtube.com/embed/cdKx1Zv3YKs?autoplay=1&mute=1&controls=0&loop=1&playlist=cdKx1Zv3YKs&rel=0"
            title="Luxury Hotel"
            allow="autoplay; encrypted-media"
            allowfullscreen>
        </iframe>

        <div class="video-overlay">

            <h2>Welcome to Luxury Hotel</h2>

            <p>
                Trải nghiệm không gian nghỉ dưỡng sang trọng
                và đẳng cấp.
            </p>

        </div>

    </div>


    <!-- =========================
         LOGIN BÊN PHẢI
         ========================= -->

    <div class="login-section">

        <div class="login-box">

            <div class="logo">

                <i class="fa-solid fa-hotel"></i>

                <h3>LUXURY HOTEL</h3>

            </div>


            <!-- Thông báo lỗi -->

            <c:if test="${error != null}">

                <div class="alert alert-danger">

                    ${error}

                </div>

            </c:if>


            <!-- FORM LOGIN -->

            <form method="post"
                  action="${pageContext.request.contextPath}/login">

                <div class="mb-3">

                    <label class="form-label">
                        Email
                    </label>

                    <input
                            type="email"
                            name="email"
                            class="form-control"
                            required>

                </div>


                <div class="mb-3">

                    <label class="form-label">
                        Mật khẩu
                    </label>

                    <input
                            type="password"
                            name="password"
                            class="form-control"
                            required>

                </div>


                <button
                        type="submit"
                        class="login-btn">

                    <i class="fa-solid fa-right-to-bracket"></i>

                    ĐĂNG NHẬP

                </button>

            </form>


            <hr>
<div class="register-link">

                Chưa có tài khoản?

                <a href="${pageContext.request.contextPath}/register">
                    Đăng ký ngay
                </a>

            </div>

        </div>

    </div>

</div>

</body>

</html>