<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Liên hệ - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container my-5">
    <div class="text-center mb-5">
        <h2 class="fw-bold text-primary">LIÊN HỆ VỚI CHÚNG TÔI</h2>
        <p class="text-muted mt-2">Gửi phản hồi cho chúng tôi hoặc kết nối trực tiếp với Luxury Hotel</p>
    </div>

    <div class="row">
        <!-- Contact Form Card -->
        <div class="col-md-6 mb-4 mb-md-0">
            <div class="card shadow border-0 h-100">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0"><i class="fa-solid fa-paper-plane me-2"></i> Gửi thông tin liên hệ</h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${message != null}">
                        <div class="alert alert-success">
                            <i class="fa-solid fa-circle-check me-2"></i> ${message}
                        </div>
                    </c:if>
                    <c:if test="${error != null}">
                        <div class="alert alert-danger">
                            <i class="fa-solid fa-triangle-exclamation me-2"></i> ${error}
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/contact" id="contactForm" novalidate>
                        <!-- FullName -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Họ và tên <span class="required">*</span></label>
                            <input type="text" name="fullName" id="fullName" class="form-control" placeholder="Nhập họ tên của bạn...">
                            <div class="invalid-feedback"></div>
                        </div>

                        <!-- Email & Phone -->
                        <div class="row">
                            <div class="col-sm-6 mb-3">
                                <label class="form-label fw-bold">Email <span class="required">*</span></label>
                                <input type="email" name="email" id="email" class="form-control" placeholder="Nhập địa chỉ email...">
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <label class="form-label fw-bold">Số điện thoại</label>
                                <input type="text" name="phone" id="phone" class="form-control" placeholder="Số điện thoại của bạn...">
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>

                        <!-- Subject -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tiêu đề <span class="required">*</span></label>
                            <input type="text" name="subject" id="subject" class="form-control" placeholder="Nhập tiêu đề liên hệ...">
                            <div class="invalid-feedback"></div>
                        </div>

                        <!-- Message -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Nội dung tin nhắn <span class="required">*</span></label>
                            <textarea name="message" id="message" class="form-control" rows="4" placeholder="Nhập nội dung tin nhắn của bạn..."></textarea>
                            <div class="invalid-feedback"></div>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-warning px-4 text-dark fw-bold">
                                <i class="fa-solid fa-paper-plane me-1"></i> Gửi đi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Info & Map -->
        <div class="col-md-6">
            <div class="card shadow border-0 h-100">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0"><i class="fa-solid fa-circle-info me-2"></i> Thông tin liên hệ</h5>
                </div>
                <div class="card-body p-4 d-flex flex-column justify-content-between">
                    <div>
                        <p class="mb-3"><strong><i class="fa-solid fa-location-dot text-warning me-2"></i> Địa chỉ:</strong> Khu Du Lịch Bãi Cháy, Hạ Long, Quảng Ninh</p>
                        <p class="mb-3"><strong><i class="fa-solid fa-phone text-warning me-2"></i> Hotline đặt phòng:</strong> 1900 6868</p>
                        <p class="mb-3"><strong><i class="fa-solid fa-envelope text-warning me-2"></i> Email hỗ trợ:</strong> contact@luxuryhotel.com</p>
                        <p class="mb-4"><strong><i class="fa-solid fa-clock text-warning me-2"></i> Giờ phục vụ:</strong> 24/7 hàng ngày</p>
                    </div>

                    <!-- Google Maps Embed -->
                    <div class="ratio ratio-16x9 rounded overflow-hidden shadow-sm border">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3725.875631777274!2d107.0371987760773!3d20.95751999022645!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a584061a7e44b%3A0xc48c081e7d00f6!2zQsOjaSBDaMOheSwgSOG6oSBMb25nLCBRdcOgbmcgTmluaCwgVmlldG5hbQ!5e0!3m2!1sen!2s!4v1716912345678!5m2!1sen!2s" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/form-validation.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const contactForm = document.getElementById("contactForm");
    if (!contactForm) return;

    createFormValidator(contactForm, {
        fullName: function(input) {
            const val = input.value.trim();
            if (!val) return "Họ và tên là phần bắt buộc";
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
            if (val) {
                const phoneRegex = /^(0|\+84)[3|5|7|8|9]\d{8}$/;
                if (!phoneRegex.test(val)) return "Số điện thoại không hợp lệ";
            }
            return null;
        },
        subject: function(input) {
            const val = input.value.trim();
            if (!val) return "Tiêu đề là phần bắt buộc";
            return null;
        },
        message: function(input) {
            const val = input.value.trim();
            if (!val) return "Nội dung tin nhắn là phần bắt buộc";
            return null;
        }
    });
});
</script>
</body>
</html>
