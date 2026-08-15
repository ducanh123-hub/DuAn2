<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Xác minh tài khoản - Luxury Hotel</title>

    <style>

        * {
            box-sizing: border-box;
        }

        html,
        body {
            width: 100%;
            min-height: 100%;
            margin: 0;
        }

        body {
            min-height: 100vh;

            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            background:
                linear-gradient(
                    rgba(10, 25, 45, 0.72),
                    rgba(10, 25, 45, 0.72)
                ),
                url("${pageContext.request.contextPath}/assets/images/hotel-bg.jpg")
                center center / cover no-repeat fixed;

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 30px 15px;
        }


        /* =========================
           OTP WRAPPER
        ========================= */

        .otp-wrapper {
            width: 100%;
            max-width: 480px;
        }


        /* =========================
           OTP CARD
        ========================= */

        .otp-card {
            width: 100%;

            background: rgba(255, 255, 255, 0.97);

            border-radius: 24px;

            padding: 42px 40px;

            text-align: center;

            box-shadow:
                0 25px 70px rgba(0, 0, 0, 0.35);

            animation: fadeIn 0.5s ease;
        }


        /* =========================
           ICON
        ========================= */

        .otp-icon {
            width: 76px;
            height: 76px;

            margin: 0 auto 20px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background:
                linear-gradient(
                    135deg,
                    #d4af37,
                    #f1d477
                );

            color: #ffffff;

            font-size: 30px;

            box-shadow:
                0 8px 22px rgba(212, 175, 55, 0.35);
        }


        /* =========================
           TITLE
        ========================= */

        .otp-card h2 {
            margin: 0 0 12px;

            color: #14253d;

            font-size: 29px;

            font-weight: 700;

            line-height: 1.3;
        }


        /* =========================
           DESCRIPTION
        ========================= */

        .otp-description {
            margin: 0 0 28px;

            color: #6b7280;

            font-size: 15px;

            line-height: 1.7;
        }

        .otp-description strong {
            color: #14253d;

            font-weight: 700;
        }


        /* =========================
           ERROR MESSAGE
        ========================= */

        .alert {
            width: 100%;

            padding: 13px 15px;

            margin-bottom: 20px;

            border-radius: 10px;

            font-size: 14px;

            line-height: 1.5;

            text-align: left;
        }

        .alert-danger {
            color: #842029;

            background: #f8d7da;

            border: 1px solid #f5c2c7;
        }


        /* =========================
           LABEL
        ========================= */

        .form-label {
            display: block;

            margin-bottom: 10px;

            color: #14253d;

            font-size: 15px;

            font-weight: 600;

            text-align: left;
        }


        /* =========================
           OTP INPUT
        ========================= */

        .otp-input {
            width: 100%;

            height: 64px;

            padding: 0 15px;

            border: 2px solid #d9dee7;

            border-radius: 14px;

            outline: none;

            background: #f8fafc;

            color: #14253d;

            text-align: center;

            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            font-size: 28px;

            font-weight: 700;

            letter-spacing: 10px;

            transition:
                border-color 0.25s ease,
                box-shadow 0.25s ease,
                background 0.25s ease;
        }


        .otp-input:focus {
            border-color: #d4af37;

            background: #ffffff;

            box-shadow:
                0 0 0 4px
                rgba(212, 175, 55, 0.15);
        }


        .otp-input::placeholder {
            color: #c4cbd5;

            font-size: 22px;

            letter-spacing: 6px;
        }


        /* =========================
           REMOVE NUMBER SPINNER
        ========================= */

        .otp-input::-webkit-inner-spin-button,
        .otp-input::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }


        /* =========================
           BUTTON
        ========================= */

        .login-btn {
            width: 100%;

            height: 54px;

            margin-top: 22px;

            border: none;

            border-radius: 12px;

            background:
                linear-gradient(
                    135deg,
                    #14253d,
                    #203b5f
                );

            color: #ffffff;

            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            font-size: 16px;

            font-weight: 600;

            cursor: pointer;

            box-shadow:
                0 8px 18px
                rgba(20, 37, 61, 0.25);

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease;
        }


        .login-btn:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px
                rgba(20, 37, 61, 0.35);
        }


        .login-btn:active {
            transform: translateY(0);
        }


        /* =========================
           NOTE
        ========================= */

        .otp-note {
            margin-top: 22px;

            color: #7b8492;

            font-size: 13px;

            line-height: 1.5;
        }


        .otp-note span {
            color: #c39b25;

            font-weight: 600;
        }


        /* =========================
           ANIMATION
        ========================= */

        @keyframes fadeIn {

            from {
                opacity: 0;

                transform:
                    translateY(18px);
            }

            to {
                opacity: 1;

                transform:
                    translateY(0);
            }
        }


        /* =========================
           MOBILE
        ========================= */

        @media (max-width: 576px) {

            body {
                padding: 20px 12px;
            }

            .otp-card {
                padding: 32px 24px;

                border-radius: 20px;
            }

            .otp-icon {
                width: 68px;
                height: 68px;

                font-size: 27px;
            }

            .otp-card h2 {
                font-size: 25px;
            }

            .otp-description {
                font-size: 14px;
            }

            .otp-input {
                height: 58px;

                font-size: 25px;

                letter-spacing: 8px;
            }

            .login-btn {
                height: 52px;
            }
        }

        .back-register-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-top: 18px;
            color: #7b8492;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.25s ease, gap 0.25s ease;
        }

        .back-register-btn:hover {
            color: #c39b25;
            gap: 10px;
        }

    </style>

</head>


<body>


<div class="otp-wrapper">

    <div class="otp-card">


        <!-- ICON -->

        <div class="otp-icon">
            🔐
        </div>


        <!-- TITLE -->

        <h2>
            Xác minh tài khoản
        </h2>


        <!-- DESCRIPTION -->

        <p class="otp-description">

            Mã OTP gồm
            <strong>6 chữ số</strong>
            đã được gửi tới email của bạn.

            <br>

            Vui lòng nhập mã để hoàn tất đăng ký.

        </p>


        <!-- FORM -->

        <form
                method="post"
                action="${pageContext.request.contextPath}/verify-otp">


            <!-- ERROR -->

            <c:if test="${not empty error}">

                <div class="alert alert-danger">

                    ${error}

                </div>

            </c:if>


            <!-- OTP -->

            <div>

                <label
                        class="form-label"
                        for="otp">

                    Mã xác minh OTP

                </label>


                <input
                        id="otp"
                        type="text"
                        name="otp"

                        class="otp-input"

                        maxlength="6"
                        minlength="6"

                        pattern="[0-9]{6}"

                        inputmode="numeric"

                        autocomplete="one-time-code"

                        placeholder="000000"

                        required>

            </div>


            <!-- BUTTON -->

            <button
                    type="submit"
                    class="login-btn">

                Xác minh tài khoản

            </button>


        </form>


        <!-- NOTE -->

        <div class="otp-note">

            Mã OTP có hiệu lực trong
            <span>5 phút</span>.

        </div>

         <a
                                        href="${pageContext.request.contextPath}/register"
                                        class="back-register-btn">

                                    ← Quay lại đăng ký

                                </a>

    </div>

</div>


</body>

</html>