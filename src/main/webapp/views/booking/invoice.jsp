<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Hóa đơn thanh toán - Luxury Hotel</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f1f3f5;
            font-family: Arial, Helvetica, sans-serif;
            color: #333;
        }

        .invoice-page {
            padding: 40px 15px;
        }

        .invoice-card {
            width: 100%;
            max-width: 900px;
            margin: 0 auto;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
            overflow: hidden;
        }

        .invoice-content {
            padding: 45px;
        }

        /* =========================
           HEADER
        ========================= */

        .hotel-name {
            color: #1769e0;
            font-size: 32px;
            font-weight: 800;
            margin: 0;
        }

        .hotel-name i {
            color: #ffb000;
        }

        .hotel-slogan {
            color: #777;
            margin-top: 5px;
            font-size: 14px;
        }

        .invoice-heading {
            text-align: right;
        }

        .invoice-heading h2 {
            margin: 0;
            color: #666;
            font-size: 30px;
            font-weight: 800;
        }

        .booking-code {
            margin-top: 8px;
            font-size: 16px;
        }

        .booking-code strong {
            color: #138a52;
        }

        .invoice-line {
            border: 0;
            border-top: 1px solid #ddd;
            margin: 30px 0;
        }

        /* =========================
           INFO
        ========================= */

        .section-title {
            font-size: 13px;
            font-weight: 700;
            color: #777;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .info-box {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 18px;
            height: 100%;
        }

        .info-box p {
            margin-bottom: 7px;
        }

        .customer-name {
            font-size: 18px;
            font-weight: 700;
            color: #222;
        }

        /* =========================
           BOOKING INFO
        ========================= */

        .booking-info {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-top: 25px;
        }

        .booking-info-label {
            color: #777;
            font-size: 12px;
            display: block;
            margin-bottom: 5px;
        }

        .booking-info-value {
            font-weight: 700;
            color: #222;
        }

        .status-checkout {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            background: #198754;
            color: white;
            font-size: 12px;
            font-weight: 700;
        }

        /* =========================
           TABLE
        ========================= */

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        .invoice-table th {
            background: #212529;
            color: white;
            padding: 13px;
            font-size: 13px;
        }

        .invoice-table td {
            padding: 14px 13px;
            border: 1px solid #dee2e6;
            vertical-align: middle;
        }

        .invoice-table th:first-child {
            text-align: left;
        }

        .invoice-table th:not(:first-child) {
            text-align: right;
        }

        .text-right {
            text-align: right;
        }

        .text-center {
            text-align: center;
        }

        .price {
            font-weight: 600;
            white-space: nowrap;
        }

        /* =========================
           TOTAL
        ========================= */

        .total-row td {
            background: #f8f9fa;
            font-size: 18px;
            font-weight: 700;
        }

        .total-money {
            color: #dc3545;
            font-size: 21px;
            font-weight: 800;
        }

        /* =========================
           NOTE
        ========================= */

        .note-box {
            margin-top: 25px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .note-title {
            font-weight: 700;
            margin-bottom: 8px;
        }

        /* =========================
           SIGNATURE
        ========================= */

        .signature {
            margin-top: 60px;
            text-align: center;
        }

        .signature-line {
            width: 180px;
            margin: 55px auto 10px;
            border-top: 1px solid #333;
        }

        /* =========================
           FOOTER
        ========================= */

        .invoice-footer {
            padding: 20px 45px;
            background: #f8f9fa;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* =========================
           RESPONSIVE
        ========================= */

        @media (max-width: 768px) {

            .invoice-content {
                padding: 25px 18px;
            }

            .invoice-heading {
                text-align: left;
                margin-top: 25px;
            }

            .invoice-heading h2 {
                font-size: 24px;
            }

            .hotel-name {
                font-size: 26px;
            }

            .invoice-table {
                font-size: 13px;
            }

            .invoice-table th,
            .invoice-table td {
                padding: 8px;
            }

            .invoice-footer {
                padding: 15px;
            }

        }

        /* =========================
           PRINT
        ========================= */

        @media print {

            body {
                background: white;
            }

            .no-print {
                display: none !important;
            }

            .invoice-page {
                padding: 0;
            }

            .invoice-card {
                max-width: 100%;
                box-shadow: none;
                border-radius: 0;
            }

            .invoice-content {
                padding: 20px;
            }

        }

    </style>

</head>


<body>


<!-- =========================================================
     HEADER WEBSITE
========================================================= -->

<div class="no-print">

    <jsp:include page="../layout/header.jsp"/>

</div>


<!-- =========================================================
     INVOICE
========================================================= -->

<div class="invoice-page">

    <div class="invoice-card">

        <div class="invoice-content">


            <!-- =================================================
                 HEADER HÓA ĐƠN
            ================================================== -->

            <div class="row align-items-center">

                <div class="col-md-6">

                    <h1 class="hotel-name">

                        <i class="fa-solid fa-hotel"></i>

                        LUXURY HOTEL

                    </h1>

                    <div class="hotel-slogan">

                        Dịch vụ nghỉ dưỡng chuẩn hoàng gia

                    </div>

                </div>


                <div class="col-md-6 invoice-heading">

                    <h2>

                        HÓA ĐƠN THANH TOÁN

                    </h2>

                    <div class="booking-code">

                        Mã đơn:

                        <strong>
                            #${booking.bookingCode}
                        </strong>

                    </div>

                </div>

            </div>


            <hr class="invoice-line">


            <!-- =================================================
                 THÔNG TIN KHÁCH SẠN + KHÁCH HÀNG
            ================================================== -->

            <div class="row">


                <!-- KHÁCH SẠN -->

                <div class="col-md-6 mb-3">

                    <div class="info-box">

                        <div class="section-title">

                            Đơn vị cung cấp

                        </div>

                        <p class="fw-bold">

                            Luxury Hotel Group

                        </p>

                        <p class="text-muted">

                            <i class="fa-solid fa-location-dot"></i>

                            Khu Du Lịch Bãi Cháy,
                            Hạ Long, Quảng Ninh

                        </p>

                        <p class="text-muted">

                            <i class="fa-solid fa-phone"></i>

                            Hotline: 1900 6868

                        </p>

                        <p class="text-muted mb-0">

                            <i class="fa-solid fa-envelope"></i>

                            contact@luxuryhotel.com

                        </p>

                    </div>

                </div>


                <!-- KHÁCH HÀNG -->

                <div class="col-md-6 mb-3">

                    <div class="info-box">

                        <div class="section-title">

                            Khách hàng

                        </div>

                        <p class="customer-name">

                            ${customer.fullName}

                        </p>


                        <p class="text-muted">

                            <i class="fa-solid fa-id-card"></i>

                            CCCD:

                            <c:choose>

                                <c:when test="${not empty customer.cccd}">

                                    ${customer.cccd}

                                </c:when>

                                <c:otherwise>

                                    N/A

                                </c:otherwise>

                            </c:choose>

                        </p>


                        <p class="text-muted">

                            <i class="fa-solid fa-phone"></i>

                            ${customer.phone}

                        </p>


                        <p class="text-muted mb-0">

                            <i class="fa-solid fa-envelope"></i>

                            ${customer.email}

                        </p>

                    </div>

                </div>

            </div>


            <!-- =================================================
                 THÔNG TIN ĐẶT PHÒNG
            ================================================== -->

            <div class="booking-info">

                <div class="row">


                    <!-- NGÀY NHẬN -->

                    <div class="col-md-3 mb-3 mb-md-0">

                        <span class="booking-info-label">

                            Ngày nhận phòng

                        </span>

                        <span class="booking-info-value">

                            ${booking.checkInDate}

                        </span>

                    </div>


                    <!-- NGÀY TRẢ -->

                    <div class="col-md-3 mb-3 mb-md-0">

                        <span class="booking-info-label">

                            Ngày trả phòng

                        </span>

                        <span class="booking-info-value">

                            ${booking.checkOutDate}

                        </span>

                    </div>


                    <!-- PHÒNG -->

                    <div class="col-md-3 mb-3 mb-md-0">

                        <span class="booking-info-label">

                            Phòng

                        </span>

                        <span class="booking-info-value">

                            P. ${room.roomNumber}

                        </span>

                    </div>


                    <!-- TRẠNG THÁI -->

                    <div class="col-md-3">

                        <span class="booking-info-label">

                            Trạng thái

                        </span>

                        <span class="status-checkout">

                            Đã trả phòng

                        </span>

                    </div>

                </div>

            </div>


            <!-- =================================================
                 BẢNG HÓA ĐƠN

                 LƯU Ý:
                 nights và roomTotal được tính từ Controller.
            ================================================== -->

            <table class="invoice-table">

                <thead>

                <tr>

                    <th>
                        Mô tả khoản thu
                    </th>

                    <th style="width: 12%;">
                        Số đêm
                    </th>

                    <th style="width: 23%;">
                        Đơn giá/đêm
                    </th>

                    <th style="width: 23%;">
                        Thành tiền
                    </th>

                </tr>

                </thead>


                <tbody>


                <!-- =================================================
                     TIỀN PHÒNG
                ================================================== -->

                <tr>

                    <td>

                        <strong>
                            Tiền thuê phòng
                        </strong>

                        <br>

                        <small class="text-muted">

                            ${room.roomName}

                            -

                            P. ${room.roomNumber}

                        </small>

                    </td>


                    <!-- SỐ ĐÊM -->

                    <td class="text-center">

                        <fmt:formatNumber
                                value="${nights}"
                                type="number"
                                groupingUsed="false"
                                maxFractionDigits="0"/>

                    </td>


                    <!-- GIÁ PHÒNG / ĐÊM -->

                    <td class="text-right price">

                        <fmt:formatNumber
                                value="${booking.roomPrice}"
                                type="number"
                                groupingUsed="true"
                                maxFractionDigits="0"/>

                        VNĐ

                    </td>


                    <!-- THÀNH TIỀN -->

                    <td class="text-right price">

                        <fmt:formatNumber
                                value="${roomTotal}"
                                type="number"
                                groupingUsed="true"
                                maxFractionDigits="0"/>

                        VNĐ

                    </td>

                </tr>


                <!-- =================================================
                     KHUYẾN MÃI

                     HIỆN TẠI CHƯA CODE VOUCHER
                     => KHÔNG HIỂN THỊ DÒNG GIẢM GIÁ
                ================================================== -->


                <!-- =================================================
                     TỔNG TIỀN

                     Khi chưa có voucher:
                     Tổng = roomTotal
                ================================================== -->

                <tr class="total-row">

                    <td
                            colspan="3"
                            class="text-right">

                        TỔNG TIỀN THANH TOÁN

                    </td>


                    <td
                            class="text-right total-money">

                        <fmt:formatNumber
                                value="${roomTotal}"
                                type="number"
                                groupingUsed="true"
                                maxFractionDigits="0"/>

                        VNĐ

                    </td>

                </tr>


                </tbody>

            </table>


            <!-- =================================================
                 GHI CHÚ
            ================================================== -->

            <c:if test="${not empty booking.note}">

                <div class="note-box">

                    <div class="note-title">

                        <i class="fa-solid fa-comment-dots"></i>

                        Ghi chú

                    </div>

                    <div class="text-muted">

                        ${booking.note}

                    </div>

                </div>

            </c:if>


            <!-- =================================================
                 CHỮ KÝ
            ================================================== -->

            <div class="row signature">


                <!-- KHÁCH HÀNG -->

                <div class="col-6">

                    <div>

                        Khách hàng

                    </div>

                    <div class="signature-line"></div>

                    <strong>

                        ${customer.fullName}

                    </strong>

                </div>


                <!-- KHÁCH SẠN -->

                <div class="col-6">

                    <div>

                        Đại diện khách sạn

                    </div>

                    <div class="signature-line"></div>

                    <strong>

                        Luxury Hotel Cashier

                    </strong>

                </div>

            </div>


        </div>


        <!-- =================================================
             BUTTON
        ================================================== -->

        <div class="invoice-footer no-print">


            <button
                    type="button"
                    onclick="history.back()"
                    class="btn btn-secondary">

                <i class="fa-solid fa-arrow-left"></i>

                Quay lại

            </button>


            <button
                    type="button"
                    onclick="window.print()"
                    class="btn btn-primary">

                <i class="fa-solid fa-print"></i>

                In hóa đơn

            </button>

        </div>

    </div>

</div>


<!-- =========================================================
     FOOTER
========================================================= -->

<div class="no-print">

    <jsp:include page="../layout/footer.jsp"/>

</div>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>