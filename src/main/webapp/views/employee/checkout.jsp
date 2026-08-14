<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">

    <title>Thủ tục Trả phòng & Thanh toán - Luxury Hotel</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>


<div class="container mt-5 mb-5">

    <div
            class="card shadow border-0 mx-auto"
            style="max-width: 800px;">

        <!-- ================================================= -->
        <!-- HEADER -->
        <!-- ================================================= -->

        <div class="card-header bg-dark text-white py-3">

            <h4 class="mb-0">

                <i
                        class="fa-solid fa-bell-concierge me-2 text-warning">
                </i>

                Tính tiền & Trả phòng (Check-out)

            </h4>

        </div>


        <div class="card-body p-4">


            <!-- ================================================= -->
            <!-- THÔNG TIN KHÁCH -->
            <!-- ================================================= -->

            <div
                    class="row mb-4 bg-light p-3 rounded mx-0">

                <div class="col-sm-6 mb-3 mb-sm-0">

                    <span class="text-muted small d-block">
                        Khách hàng:
                    </span>

                    <strong class="text-dark">
                        ${customer.fullName}
                    </strong>

                    <span class="d-block text-muted small">
                        ${customer.phone}
                    </span>

                    <span class="d-block text-muted small">
                        ${customer.email}
                    </span>

                </div>


                <div class="col-sm-6 text-sm-end">

                    <span class="text-muted small d-block">
                        Phòng bàn giao:
                    </span>

                    <strong class="text-dark">

                        P. ${room.roomNumber}
                        -
                        ${room.roomName}

                    </strong>

                    <span class="d-block text-muted small">

                        Nhận:
                        ${booking.checkInDate}

                    </span>

                    <span class="d-block text-muted small">

                        Trả:
                        ${booking.checkOutDate}

                    </span>

                </div>

            </div>


            <!-- ================================================= -->
            <!-- THÔNG TIN THANH TOÁN -->
            <!-- ================================================= -->

            <form
                    method="post"
                    action="${pageContext.request.contextPath}/booking">

                <!-- QUAN TRỌNG -->
                <input
                        type="hidden"
                        name="action"
                        value="confirmCheckout">


                <input
                        type="hidden"
                        name="bookingId"
                        value="${booking.bookingID}">


                <!-- ================================================= -->
                <!-- TIỀN PHÒNG -->
                <!-- ================================================= -->

                <div class="mb-3">

                    <label class="form-label fw-bold">

                        <i class="fa-solid fa-bed me-1"></i>

                        Tiền phòng

                    </label>


                    <div class="input-group">

                        <input
                                type="text"
                                class="form-control bg-light"
                                value="${booking.totalAmount}"
                                readonly>

                        <span class="input-group-text">
                            VNĐ
                        </span>

                    </div>

                    <div class="form-text">

                        Đây là tổng tiền phòng theo đơn đặt phòng.

                    </div>

                </div>


                <!-- ================================================= -->
                <!-- DỊCH VỤ -->
                <!-- ================================================= -->

                <div class="mb-3">

                    <label
                            for="servicePrice"
                            class="form-label fw-bold">

                        <i class="fa-solid fa-cart-shopping me-1"></i>

                        Chi phí dịch vụ phát sinh

                    </label>


                    <div class="input-group">

                        <input
                                type="number"
                                name="servicePrice"
                                id="servicePrice"
                                class="form-control"
                                value="0"
                                min="0"
                                step="1000">

                        <span class="input-group-text">
                            VNĐ
                        </span>

                    </div>


                    <div class="form-text">

                        Ví dụ: minibar, giặt là, ăn uống,
                        dịch vụ phòng...

                    </div>

                </div>


                <!-- ================================================= -->
                <!-- GHI CHÚ -->
                <!-- ================================================= -->

                <div class="mb-4">

                    <label
                            for="note"
                            class="form-label fw-bold">

                        <i class="fa-solid fa-note-sticky me-1"></i>

                        Ghi chú thanh toán

                    </label>


                    <textarea
                            id="note"
                            name="note"
                            class="form-control"
                            rows="3"
                            placeholder="Nhập ghi chú về dịch vụ sử dụng nếu có..."></textarea>

                </div>


                <!-- ================================================= -->
                <!-- TỔNG THANH TOÁN -->
                <!-- ================================================= -->

                <div
                        class="p-4 rounded mb-4
                               bg-danger bg-opacity-10
                               border border-danger
                               d-flex justify-content-between
                               align-items-center">

                    <div>

                        <h5 class="fw-bold text-danger mb-1">

                            TỔNG THANH TOÁN

                        </h5>

                        <p class="text-muted small mb-0">

                            Tiền phòng + dịch vụ phát sinh

                        </p>

                    </div>


                    <div>

                        <span
                                id="totalAmountDisplay"
                                class="text-danger fw-bold"
                                style="font-size: 24px;">

                            0 VNĐ

                        </span>

                    </div>

                </div>


                <!-- ================================================= -->
                <!-- BUTTON -->
                <!-- ================================================= -->

                <div
                        class="d-flex justify-content-between
                               border-top pt-4">

                    <a
                            href="${pageContext.request.contextPath}/booking?action=manage"
                            class="btn btn-secondary">

                        <i class="fa-solid fa-arrow-left me-1"></i>

                        Quay lại danh sách

                    </a>


                    <button
                            type="submit"
                            class="btn btn-danger px-4">

                        <i
                                class="fa-solid fa-circle-check me-1">
                        </i>

                        Xác nhận Trả phòng & Thanh toán

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>


<jsp:include page="../layout/footer.jsp"/>


<script>

    document.addEventListener("DOMContentLoaded", function () {

        /*
         * Lấy tổng tiền phòng từ DATABASE.
         *
         * booking.totalAmount là số tiền thuần,
         * không có chữ VNĐ.
         */
        const roomTotal =
            parseFloat("${booking.totalAmount}") || 0;


        const serviceInput =
            document.getElementById("servicePrice");


        const totalDisplay =
            document.getElementById("totalAmountDisplay");


        function formatMoney(number) {

            return new Intl.NumberFormat(
                "vi-VN"
            ).format(number) + " VNĐ";

        }


        function calculateTotal() {

            const servicePrice =
                parseFloat(serviceInput.value) || 0;


            const total =
                roomTotal + servicePrice;


            totalDisplay.textContent =
                formatMoney(total);

        }


        serviceInput.addEventListener(
            "input",
            calculateTotal
        );


        calculateTotal();

    });

</script>


</body>

</html>