<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Đặt phòng - Luxury Hotel</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Font Awesome -->
    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <!-- CSS chung -->
    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>

        /* =====================================================
           THÔNG BÁO
           ===================================================== */

        .success-box {
            border-left: 5px solid #198754;
            background: #d1e7dd;
        }

        .error-box {
            border-left: 5px solid #dc3545;
        }


        /* =====================================================
           GIÁ PHÒNG
           ===================================================== */

        .room-price {
            color: #dc3545;
            font-size: 18px;
            font-weight: 700;
        }


        /* =====================================================
           TỔNG TIỀN
           ===================================================== */

        #totalDisplay {
            min-width: 220px;
            text-align: right;
            color: #dc3545;
            font-size: 20px;
            font-weight: 700;
        }


        /* =====================================================
           CARD
           ===================================================== */

        .card {
            border-radius: 12px;
            overflow: hidden;
        }


        /* =====================================================
           BUTTON
           ===================================================== */

        #submitButton {
            min-width: 200px;
        }

    </style>

</head>


<body class="bg-light">


<!-- =====================================================
     HEADER
     ===================================================== -->

<jsp:include page="../layout/header.jsp"/>


<div class="container mt-5 mb-5">

    <div class="row justify-content-center">

        <div class="col-lg-8">

            <div class="card shadow border-0">


                <!-- =================================================
                     HEADER CARD
                     ================================================= -->

                <div class="card-header bg-dark text-white py-3">

                    <h4 class="mb-0">

                        <i class="fa-solid fa-calendar-days me-2"></i>

                        Đặt phòng khách sạn

                    </h4>

                </div>


                <div class="card-body p-4">


                    <!-- =================================================
                         THÔNG BÁO THÀNH CÔNG
                         ================================================= -->

                    <c:if test="${success != null}">

                        <div class="alert alert-success success-box shadow-sm">

                            <div class="d-flex align-items-center">

                                <div class="me-3">

                                    <i
                                        class="fa-solid fa-circle-check fa-2x text-success">
                                    </i>

                                </div>


                                <div>

                                    <h5 class="fw-bold mb-1">

                                        Đặt phòng thành công!

                                    </h5>


                                    <div>

                                        ${success}

                                    </div>


                                    <div class="mt-2">

                                        <a
                                            href="${pageContext.request.contextPath}/booking?action=history"
                                            class="btn btn-success btn-sm">

                                            <i
                                                class="fa-solid fa-clock-rotate-left me-1">
                                            </i>

                                            Xem lịch sử đặt phòng

                                        </a>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </c:if>


                    <!-- =================================================
                         THÔNG BÁO LỖI
                         ================================================= -->

                    <c:if test="${error != null}">

                        <div class="alert alert-danger error-box">

                            <i
                                class="fa-solid fa-triangle-exclamation me-2">
                            </i>

                            ${error}

                        </div>

                    </c:if>


                    <!-- =================================================
                         FORM ĐẶT PHÒNG
                         ================================================= -->

                    <form
                        method="post"
                        action="${pageContext.request.contextPath}/booking"
                        id="bookingForm"
                        novalidate>


                        <!-- ROOM ID -->

                        <input
                            type="hidden"
                            name="roomId"
                            value="${room.roomID}">


                        <!-- =================================================
                             THÔNG TIN PHÒNG
                             ================================================= -->

                        <div class="row">


                            <!-- TÊN PHÒNG -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Tên phòng

                                </label>

                                <input
                                    type="text"
                                    class="form-control bg-light"
                                    value="${room.roomName}"
                                    readonly>

                            </div>


                            <!-- GIÁ PHÒNG -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Giá phòng / Đêm

                                </label>


                                <div
                                    class="form-control bg-light">

                                    <span class="room-price">

                                        <fmt:formatNumber
                                            value="${room.price}"
                                            type="number"
                                            groupingUsed="true"
                                            minFractionDigits="0"
                                            maxFractionDigits="0"/>

                                        VNĐ

                                    </span>

                                </div>

                            </div>

                        </div>


                        <!-- =================================================
                             THÔNG TIN NGƯỜI ĐẶT
                             ================================================= -->

                        <h5
                            class="fw-bold text-primary mt-3 mb-3 border-bottom pb-2">

                            <i class="fa-solid fa-user me-1"></i>

                            Thông tin người đặt phòng

                        </h5>


                        <div class="row">


                            <!-- HỌ TÊN -->

                            <div class="col-md-4 mb-3">

                                <label class="form-label fw-bold">

                                    Họ và tên <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="text"
                                    id="fullName"
                                    name="fullName"
                                    class="form-control"
                                    value="${sessionScope.user.fullName}"
                                    placeholder="Nhập họ và tên...">

                                <div class="invalid-feedback"></div>

                            </div>


                            <!-- SỐ ĐIỆN THOẠI -->

                            <div class="col-md-4 mb-3">

                                <label class="form-label fw-bold">

                                    Số điện thoại <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="text"
                                    id="phone"
                                    name="phone"
                                    class="form-control"
                                    value="${sessionScope.user.phone}"
                                    placeholder="Nhập số điện thoại...">

                                <div class="invalid-feedback"></div>

                            </div>


                            <!-- EMAIL -->

                            <div class="col-md-4 mb-3">

                                <label class="form-label fw-bold">

                                    Email <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="email"
                                    id="email"
                                    name="email"
                                    class="form-control"
                                    value="${sessionScope.user.email}"
                                    placeholder="Nhập email...">

                                <div class="invalid-feedback"></div>

                            </div>

                        </div>


                        <!-- =================================================
                             ĐẶT PHÒNG HỘ
                             ================================================= -->

                        <div class="form-check mb-4 mt-2">

                            <input
                                class="form-check-input"
                                type="checkbox"
                                name="isBookingForOthers"
                                id="isBookingForOthers"
                                onchange="toggleGuestFields()">


                            <label
                                class="form-check-label fw-bold text-secondary"
                                for="isBookingForOthers">

                                <i
                                    class="fa-solid fa-user-friends me-1">
                                </i>

                                Tôi đặt phòng hộ cho người khác

                            </label>

                        </div>


                        <!-- =================================================
                             THÔNG TIN KHÁCH LƯU TRÚ
                             ================================================= -->

                        <div
                            id="guestFields"
                            class="p-3 bg-light border rounded mb-4 d-none">


                            <h6 class="fw-bold text-dark mb-3">

                                <i class="fa-solid fa-id-card me-1"></i>

                                Thông tin người lưu trú

                            </h6>


                            <div class="row">


                                <!-- TÊN -->

                                <div class="col-md-4 mb-2">

                                    <label
                                        class="form-label small fw-bold">

                                        Họ tên khách <span class="text-danger">*</span>

                                    </label>

                                    <input
                                        type="text"
                                        name="guestName"
                                        id="guestName"
                                        class="form-control form-control-sm"
                                        placeholder="Nhập tên khách...">

                                    <div class="invalid-feedback"></div>

                                </div>


                                <!-- SĐT -->

                                <div class="col-md-4 mb-2">

                                    <label
                                        class="form-label small fw-bold">

                                        Số điện thoại khách <span class="text-danger">*</span>

                                    </label>

                                    <input
                                        type="text"
                                        name="guestPhone"
                                        id="guestPhone"
                                        class="form-control form-control-sm"
                                        placeholder="Nhập số điện thoại...">

                                    <div class="invalid-feedback"></div>

                                </div>


                                <!-- EMAIL -->

                                <div class="col-md-4 mb-2">

                                    <label
                                        class="form-label small fw-bold">

                                        Email khách

                                    </label>

                                    <input
                                        type="email"
                                        name="guestEmail"
                                        id="guestEmail"
                                        class="form-control form-control-sm"
                                        placeholder="Nhập email...">

                                    <div class="invalid-feedback"></div>

                                </div>

                            </div>

                        </div>


                        <!-- =================================================
                             THỜI GIAN LƯU TRÚ
                             ================================================= -->

                        <h5
                            class="fw-bold text-primary mt-3 mb-3 border-bottom pb-2">

                            <i class="fa-solid fa-calendar-check me-1"></i>

                            Thời gian lưu trú & Số lượng khách

                        </h5>


                        <div class="row">


                            <!-- CHECK IN -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Ngày nhận phòng <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="date"
                                    name="checkIn"
                                    id="checkIn"
                                    class="form-control">

                                <div class="invalid-feedback"></div>

                            </div>


                            <!-- CHECK OUT -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Ngày trả phòng <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="date"
                                    name="checkOut"
                                    id="checkOut"
                                    class="form-control">

                                <div class="invalid-feedback"></div>

                            </div>

                        </div>


                        <!-- =================================================
                             SỐ KHÁCH
                             ================================================= -->

                        <div class="row">


                            <!-- NGƯỜI LỚN -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Số lượng Người lớn <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="number"
                                    name="adults"
                                    id="adults"
                                    class="form-control"
                                    value="1">

                                <div class="invalid-feedback"></div>

                            </div>


                            <!-- TRẺ EM -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Số lượng Trẻ em

                                </label>

                                <input
                                    type="number"
                                    name="children"
                                    id="children"
                                    class="form-control"
                                    value="0">

                                <div class="invalid-feedback"></div>

                            </div>

                        </div>


                        <!-- =================================================
                             GHI CHÚ
                             ================================================= -->

                        <div class="mb-4">

                            <label class="form-label fw-bold">

                                Yêu cầu đặc biệt / Ghi chú

                            </label>

                            <textarea
                                name="note"
                                id="note"
                                class="form-control"
                                rows="2"
                                placeholder="Ví dụ: phòng tầng cao, giường phụ, check-in muộn..."></textarea>

                            <div class="invalid-feedback"></div>

                        </div>


                        <!-- =================================================
                             CHÍNH SÁCH
                             ================================================= -->

                        <div class="alert alert-secondary p-3 small mb-4">

                            <h6 class="fw-bold text-dark mb-2">

                                <i
                                    class="fa-solid fa-circle-exclamation text-warning me-1">
                                </i>

                                Chính sách khách sạn & Quy định áp dụng:

                            </h6>


                            <ul class="mb-0 ps-3 text-muted">


                                <li>

                                    <strong>
                                        Chính sách hủy phòng:
                                    </strong>

                                    Hủy phòng miễn phí trước 24 giờ kể từ
                                    thời điểm nhận phòng.

                                    Hủy trễ hơn sẽ chịu phí đêm đầu tiên.

                                </li>


                                <li>

                                    <strong>
                                        Thời gian Check-in/out:
                                    </strong>

                                    Nhận phòng sau 14:00 |

                                    Trả phòng trước 12:00 trưa hôm sau.

                                </li>


                                <li>

                                    <strong>
                                        Quy định:
                                    </strong>

                                    Quý khách vui lòng xuất trình CCCD
                                    hoặc Hộ chiếu khi làm thủ tục nhận
                                    phòng tại quầy lễ tân.

                                </li>

                            </ul>

                        </div>

                        <!-- =================================================
                             VOUCHER
                             ================================================= -->

                        <div class="mb-4">

                            <label class="form-label fw-bold">
                                <i class="fa-solid fa-ticket text-warning me-1"></i>
                                Mã giảm giá
                            </label>

                            <div class="input-group">

                                <input
                                    type="text"
                                    name="voucherCode"
                                    id="voucherCode"
                                    class="form-control"
                                    placeholder="Nhập mã voucher...">

                                <button
                                    type="button"
                                    class="btn btn-warning"
                                    id="applyVoucher">

                                    Áp dụng

                                </button>

                            </div>

                            <div id="voucherMessage" class="small mt-2"></div>

                        </div>


                        <!-- =================================================
                             TỔNG TIỀN
                             ================================================= -->

                        <div class="p-3 rounded bg-danger bg-opacity-10 border border-danger border-opacity-20 mb-4">

                            <!-- SỐ ĐÊM LƯU TRÚ -->
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <span class="text-muted">Số đêm:</span>
                                <span id="nightsDisplay" class="fw-bold text-dark">0 đêm</span>
                            </div>

                            <!-- TỔNG TIỀN GỐC -->
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <span class="text-muted">Tổng tiền phòng:</span>
                                <span id="originalTotalDisplay" class="fw-bold">
                                    <fmt:formatNumber value="${room.price}" type="number"
                                        groupingUsed="true" maxFractionDigits="0"/> VNĐ
                                </span>
                            </div>

                            <!-- SỐ TIỀN ĐƯỢC GIẢM -->
                            <div id="discountBox" class="d-flex justify-content-between align-items-center mb-1 d-none">
                                <span class="text-success">
                                    <i class="fa-solid fa-tag me-1"></i>
                                    Giảm giá (<span id="voucherCodeLabel"></span>):
                                </span>
                                <span id="discountDisplay" class="text-success fw-bold">-0 VNĐ</span>
                            </div>

                            <hr class="my-2">

                            <!-- TỔNG SAU GIẢM -->
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="fw-bold text-danger mb-0">TỔNG CHI PHÍ DỰ KIẾN:</h5>
                                <span id="totalDisplay" class="fs-4">
                                    <fmt:formatNumber value="${room.price}" type="number"
                                        groupingUsed="true" maxFractionDigits="0"/> VNĐ
                                </span>
                            </div>

                            <input type="hidden" name="discountAmount" id="discountAmount" value="0">
                            <input type="hidden" name="finalAmount" id="finalAmount" value="${room.price}">

                        </div>


                        <!-- =================================================
                             NÚT
                             ================================================= -->

                        <div
                            class="d-flex justify-content-between mt-4">


                            <!-- QUAY LẠI -->

                            <a
                                href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                                class="btn btn-secondary">

                                <i
                                    class="fa-solid fa-arrow-left me-1">
                                </i>

                                Quay lại

                            </a>


                            <!-- XÁC NHẬN -->

                            <button
                                type="submit"
                                id="submitButton"
                                class="btn btn-success px-4 fw-bold">

                                <i
                                    class="fa-solid fa-circle-check me-1">
                                </i>

                                Xác nhận đặt phòng

                            </button>

                        </div>


                    </form>

                </div>

            </div>

        </div>

    </div>

</div>


<!-- =====================================================
     FOOTER
     ===================================================== -->

<jsp:include page="../layout/footer.jsp"/>


<script>

/* ============================================================
   BIẾN TOÀN CỤC
   ============================================================ */

const rawPrice = "${room.price}";
const basePrice = parseFloat(String(rawPrice).replace(/[^0-9.]/g, "")) || 0;
let currentNights = 0;
let currentTotal = basePrice;   // tổng tiền gốc (trước giảm) — cập nhật khi đổi ngày
let discountAmount = 0;         // tiền được giảm — chỉ set khi server xác nhận hợp lệ


/* ============================================================
   FORMAT TIỀN (global, dùng chung mọi nơi)
   ============================================================ */

function formatMoney(amount) {
    return Number(amount).toLocaleString("vi-VN") + " VNĐ";
}


/* ============================================================
   CẬP NHẬT HIỂN THỊ TỔNG / GIẢM / CÒN LẠI / SỐ ĐÊM
   ============================================================ */

function updateFinalAmount() {

    const finalAmount = Math.max(0, currentTotal - discountAmount);

    const nightsElement = document.getElementById("nightsDisplay");
    if (nightsElement) {
        nightsElement.textContent = currentNights + " đêm";
    }

    const origTotalEl = document.getElementById("originalTotalDisplay");
    if (origTotalEl) {
        origTotalEl.textContent = formatMoney(currentTotal);
    }

    const discountBox = document.getElementById("discountBox");
    const discountDisplay = document.getElementById("discountDisplay");
    if (discountAmount > 0) {
        if (discountBox) discountBox.classList.remove("d-none");
        if (discountDisplay) discountDisplay.textContent = "-" + formatMoney(discountAmount);
    } else {
        if (discountBox) discountBox.classList.add("d-none");
    }

    const totalDisplayEl = document.getElementById("totalDisplay");
    if (totalDisplayEl) {
        totalDisplayEl.textContent = formatMoney(finalAmount);
    }

    const discountInput = document.getElementById("discountAmount");
    if (discountInput) discountInput.value = discountAmount;

    const finalInput = document.getElementById("finalAmount");
    if (finalInput) finalInput.value = finalAmount;
}


/* ============================================================
   TÍNH SỐ ĐÊM & TỔNG TIỀN GỐC (GIÁ PHÒNG × SỐ ĐÊM)
   ============================================================ */

function calculateTotal() {

    const checkInInput  = document.getElementById("checkIn");
    const checkOutInput = document.getElementById("checkOut");

    if (!checkInInput || !checkOutInput) return;

    const checkInVal  = checkInInput.value;
    const checkOutVal = checkOutInput.value;

    console.log("Check-in:", checkInVal);
    console.log("Check-out:", checkOutVal);
    console.log("Room price:", basePrice);

    if (!checkInVal || !checkOutVal) {
        currentNights = 0;
        currentTotal = basePrice;
        console.log("Nights:", 0);
        console.log("Room total:", currentTotal);
        console.log("Grand total:", currentTotal);
        updateFinalAmount();
        return;
    }

    const checkInDate  = new Date(checkInVal + "T00:00:00");
    const checkOutDate = new Date(checkOutVal + "T00:00:00");
    const diffTime     = checkOutDate.getTime() - checkInDate.getTime();
    const nights       = Math.round(diffTime / (1000 * 60 * 60 * 24));

    if (nights > 0) {
        currentNights = nights;
        currentTotal  = nights * basePrice;
    } else {
        currentNights = 0;
        currentTotal  = basePrice;
    }

    const grandTotal = Math.max(0, currentTotal - discountAmount);

    console.log("Nights:", nights);
    console.log("Room total:", currentTotal);
    console.log("Grand total:", grandTotal);

    // Đổi ngày -> voucher cũ (nếu có) không còn đúng nữa, phải áp lại
    if (discountAmount > 0) {
        discountAmount = 0;
        const msgEl = document.getElementById("voucherMessage");
        if (msgEl) {
            msgEl.innerHTML =
                '<span class="text-warning">Bạn đã đổi ngày, vui lòng áp dụng lại voucher.</span>';
        }
    }

    updateFinalAmount();
}

window.calculateTotal = calculateTotal;


/* ============================================================
   XỬ LÝ FORM ĐẶT PHÒNG
   ============================================================ */

document.addEventListener("DOMContentLoaded", function () {

    const checkInInput  = document.getElementById("checkIn");
    const checkOutInput = document.getElementById("checkOut");
    const bookingForm    = document.getElementById("bookingForm");
    const submitButton   = document.getElementById("submitButton");

    if (checkInInput) {
        const now = new Date();
        const today = now.getFullYear() + "-"
            + String(now.getMonth() + 1).padStart(2, "0") + "-"
            + String(now.getDate()).padStart(2, "0");
        checkInInput.min = today;

        checkInInput.addEventListener("change", function () {
            if (checkInInput.value) {
                const nextDay = new Date(checkInInput.value + "T00:00:00");
                nextDay.setDate(nextDay.getDate() + 1);
                if (checkOutInput) {
                    checkOutInput.min = nextDay.getFullYear() + "-"
                        + String(nextDay.getMonth() + 1).padStart(2, "0") + "-"
                        + String(nextDay.getDate()).padStart(2, "0");
                }
            }
            calculateTotal();
        });
        checkInInput.addEventListener("input", calculateTotal);
    }

    if (checkOutInput) {
        checkOutInput.addEventListener("change", calculateTotal);
        checkOutInput.addEventListener("input", calculateTotal);
    }

    if (bookingForm && submitButton) {
        bookingForm.addEventListener("submit", function () {
            if (bookingForm.querySelectorAll(".is-invalid").length > 0) {
                return;
            }
            submitButton.disabled = true;
            submitButton.innerHTML =
                '<i class="fa-solid fa-spinner fa-spin me-1"></i> Đang xử lý...';
        });
    }

    /* Hiển thị tổng tiền ban đầu */
    calculateTotal();

});


/* ================================================================
   ĐẶT PHÒNG HỘ
   ================================================================ */

function toggleGuestFields() {

    const checkbox    = document.getElementById("isBookingForOthers");
    const guestFields = document.getElementById("guestFields");
    const guestName   = document.getElementById("guestName");
    const guestPhone  = document.getElementById("guestPhone");
    const guestEmail  = document.getElementById("guestEmail");

    if (!checkbox || !guestFields) return;

    if (checkbox.checked) {
        guestFields.classList.remove("d-none");
        if (guestName) guestName.required = true;
        if (guestPhone) guestPhone.required = true;
    } else {
        guestFields.classList.add("d-none");
        if (guestName) { guestName.required = false; guestName.value = ""; }
        if (guestPhone) { guestPhone.required = false; guestPhone.value = ""; }
        if (guestEmail) { guestEmail.value = ""; }
    }

}


/* ================================================================
   ÁP DỤNG VOUCHER — GỌI SERVER THẬT (POST /voucher?action=apply)
   ================================================================ */

const applyVoucherBtn = document.getElementById("applyVoucher");
if (applyVoucherBtn) {
    applyVoucherBtn.addEventListener("click", function () {

        const voucherInput = document.getElementById("voucherCode");
        const code = voucherInput ? voucherInput.value.trim() : "";
        const message = document.getElementById("voucherMessage");
        const applyBtn = this;

        if (!code) {
            if (message) message.innerHTML = '<span class="text-danger">Vui lòng nhập mã voucher.</span>';
            return;
        }

        applyBtn.disabled = true;
        applyBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i>';

        const params = new URLSearchParams();
        params.append("code", code);
        params.append("totalAmount", currentTotal);

        fetch("${pageContext.request.contextPath}/voucher?action=apply", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: params.toString()
        })
        .then(res => res.json())
        .then(data => {
            applyBtn.disabled = false;
            applyBtn.innerHTML = "Áp dụng";

            if (data.valid) {
                discountAmount = Number(data.discount);
                const labelEl = document.getElementById("voucherCodeLabel");
                if (labelEl) labelEl.textContent = code.toUpperCase();
                if (message) message.innerHTML = '<span class="text-success">' + data.message + '</span>';
            } else {
                discountAmount = 0;
                if (message) message.innerHTML = '<span class="text-danger">' + data.message + '</span>';
            }

            updateFinalAmount();
        })
        .catch(() => {
            applyBtn.disabled = false;
            applyBtn.innerHTML = "Áp dụng";
            discountAmount = 0;
            if (message) message.innerHTML = '<span class="text-danger">Có lỗi xảy ra, vui lòng thử lại.</span>';
            updateFinalAmount();
        });

    });
}

</script>

<script src="${pageContext.request.contextPath}/assets/js/booking-validation.js"></script>

</body>

</html>
