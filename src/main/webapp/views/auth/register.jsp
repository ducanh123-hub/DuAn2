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

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        .required {
            color: #dc3545 !important;
            font-weight: bold;
        }

        .is-invalid {
            border: 1px solid #dc3545 !important;
        }

        .is-invalid:focus {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.1rem rgba(220, 53, 69, 0.15) !important;
        }

        .validation-error,
        .invalid-feedback {
            color: #dc3545 !important;
            font-size: 13px !important;
            margin-top: 4px !important;
            display: none;
        }

        .is-invalid ~ .validation-error,
        .is-invalid ~ .invalid-feedback {
            display: block !important;
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
              action="${pageContext.request.contextPath}/register"
              id="registerForm"
              novalidate>


            <!-- HỌ TÊN -->

            <div class="mb-3">

                <label class="form-label">
                    Họ và tên <span class="required">*</span>
                </label>

                <input
                        type="text"
                        class="form-control"
                        id="fullName"
                        name="fullName"
                        placeholder="Họ và tên của bạn">

                <div class="validation-error invalid-feedback" id="fullNameError"></div>

            </div>


            <!-- EMAIL -->

            <div class="mb-3">

                <label class="form-label">
                    Email <span class="required">*</span>
                </label>

                <input
                        type="email"
                        class="form-control"
                        id="email"
                        name="email"
                        placeholder="Địa chỉ email...">

                <div class="validation-error invalid-feedback" id="emailError"></div>

            </div>


            <!-- SỐ ĐIỆN THOẠI -->

            <div class="mb-3">

                <label class="form-label">
                    Số điện thoại <span class="required">*</span>
                </label>

                <input
                        type="text"
                        class="form-control"
                        id="phone"
                        name="phone"
                        placeholder="Số điện thoại...">

                <div class="validation-error invalid-feedback" id="phoneError"></div>

            </div>


            <!-- MẬT KHẨU -->

            <div class="mb-3">

                <label class="form-label">
                    Mật khẩu <span class="required">*</span>
                </label>

                <input
                        type="password"
                        class="form-control"
                        id="password"
                        name="password"
                        placeholder="Nhập mật khẩu (tối thiểu 6 ký tự)...">

                <div class="validation-error invalid-feedback" id="passwordError"></div>

            </div>

            <!-- XÁC NHẬN MẬT KHẨU -->

            <div class="mb-3">
                <label class="form-label">
                    Xác nhận mật khẩu <span class="required">*</span>
                </label>
                <input
                        type="password"
                        class="form-control"
                        id="confirmPassword"
                        name="confirmPassword"
                        placeholder="Nhập lại mật khẩu...">
                <div class="validation-error invalid-feedback" id="confirmPasswordError"></div>
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

<script src="${pageContext.request.contextPath}/assets/js/form-validation.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const registerForm = document.getElementById("registerForm");
    if (!registerForm) return;

    createFormValidator(registerForm, {
        fullName: function(input) {
            const val = input.value.trim();
            if (!val) return "Họ và tên là phần bắt buộc";
            const nameRegex = /^[a-zA-ZàáảãạâầấẩẫậăằắẳẵặèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđÀÁẢÃẠÂẦẤẨẪẬĂẰẮẲẴẶÈÉẺẼẸÊỀẾỂỄỆÌÍỈĨỊÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢÙÚỦŨỤƯỪỨỬỮỰỲÝỶỸỴĐ\s]+$/;
            if (!nameRegex.test(val)) return "Họ và tên không hợp lệ";
            return null;
        },
        email: function(input) {
            const val = input.value.trim();
            if (!val) return "Email là phần bắt buộc";
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailRegex.test(val)) return "Email không đúng định dạng";
            return null;
        },
        phone: function(input) {
            const val = input.value.trim();
            if (!val) return "Số điện thoại là phần bắt buộc";
            const phoneRegex = /^(0|\+84)[3|5|7|8|9]\d{8}$/;
            if (!phoneRegex.test(val)) return "Số điện thoại không hợp lệ";
            return null;
        },
        password: function(input) {
            const val = input.value;
            if (!val) return "Mật khẩu là phần bắt buộc";
            if (val.length < 6) return "Mật khẩu phải có ít nhất 6 ký tự";
            return null;
        },
        confirmPassword: function(input, form) {
            const val = input.value;
            if (!val) return "Vui lòng xác nhận mật khẩu";
            const passVal = form.querySelector("[name='password']").value;
            if (val !== passVal) return "Mật khẩu xác nhận không khớp";
            return null;
        }
    });
});
</script>
</body>

</html>
