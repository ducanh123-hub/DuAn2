<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Đặt phòng - Luxury Hotel</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-lg-8">

            <div class="card shadow border-0">

                <div class="card-header bg-dark text-white py-3">

                    <h4 class="mb-0">
                        <i class="fa-solid fa-calendar-days me-2"></i>
                        Đặt phòng khách sạn
                    </h4>

                </div>

                <div class="card-body p-4">

                    <!-- Hiển thị lỗi -->
                    <c:if test="${error != null}">
                        <div class="alert alert-danger animate__animated animate__fadeIn">

                            <i class="fa-solid fa-triangle-exclamation me-2"></i>

                            ${error}

                        </div>
                    </c:if>


                    <form method="post"
                          action="${pageContext.request.contextPath}/booking">

                        <!-- ID phòng -->
                        <input type="hidden"
                               name="roomId"
                               value="${room.roomID}">


                        <!-- THÔNG TIN PHÒNG -->
                        <div class="row">

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">
                                    Tên phòng
                                </label>

                                <input type="text"
                                       class="form-control bg-light"
                                       value="${room.roomName}"
                                       readonly>

                            </div>


                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">
                                    Giá phòng / Đêm (VNĐ)
                                </label>

                                <!--
                                    Giá hiển thị:
                                    500000 -> 500.000 VNĐ
                                -->
                                <input type="text"
                                       class="form-control bg-light text-danger fw-bold"
                                       value="<fmt:formatNumber value='${room.price}' type='number' groupingUsed='true' maxFractionDigits='0'/> VNĐ"
                                       readonly>

                            </div>

                        </div>


                        <!-- THÔNG TIN NGƯỜI ĐẶT -->
                        <h5 class="fw-bold text-primary mt-3 mb-3 border-bottom pb-2">

                            <i class="fa-solid fa-user me-1"></i>

                            Thông tin người đặt phòng

                        </h5>


                        <div class="row">

                            <div class="col-md-4 mb-3">

                                <label class="form-label fw-bold">
                                    Họ và tên
                                </label>

                                <input type="text"
                                       class="form-control bg-light"
                                       value="${sessionScope.user.fullName}"
                                       readonly>

                            </div>


                            <div class="col-md-4 mb-3">

                                <label class="form-label fw-bold">
                                    Số điện thoại
                                </label>

                                <input type="text"
                                       class="form-control bg-light"
                                       value="${sessionScope.user.phone}"
                                       readonly>

                            </div>


                            <div class="col-md-4 mb-3">

                                <label class="form-label fw-bold">
                                    Email
                                </label>

                                <input type="text"
                                       class="form-control bg-light"
                                       value="${sessionScope.user.email}"
                                       readonly>

                            </div>

                        </div>


                        <!-- ĐẶT PHÒNG HỘ -->
                        <div class="form-check mb-4 mt-2">

                            <input class="form-check-input"
                                   type="checkbox"
                                   name="isBookingForOthers"
                                   id="isBookingForOthers"
                                   onchange="toggleGuestFields()">

                            <label class="form-check-label fw-bold text-secondary"
                                   for="isBookingForOthers">

                                <i class="fa-solid fa-user-friends me-1"></i>

                                Tôi đặt phòng hộ cho người khác

                            </label>

                        </div>


                        <!-- THÔNG TIN KHÁCH THỰC TẾ -->
                        <div id="guestFields"
                             class="p-3 bg-light border rounded mb-4 d-none">

                            <h6 class="fw-bold text-dark mb-3">

                                <i class="fa-solid fa-id-card me-1"></i>

                                Thông tin người lưu trú (Khách hàng thực tế)

                            </h6>


                            <div class="row">

                                <div class="col-md-4 mb-2">

                                    <label class="form-label small fw-bold">
                                        Họ tên khách
                                    </label>

                                    <input type="text"
                                           name="guestName"
                                           id="guestName"
                                           class="form-control form-control-sm"
                                           placeholder="Nhập tên khách...">

                                </div>


                                <div class="col-md-4 mb-2">

                                    <label class="form-label small fw-bold">
                                        Số điện thoại khách
                                    </label>

                                    <input type="text"
                                           name="guestPhone"
                                           id="guestPhone"
                                           class="form-control form-control-sm"
                                           placeholder="Nhập số điện thoại...">

                                </div>


                                <div class="col-md-4 mb-2">

                                    <label class="form-label small fw-bold">
                                        Email khách
                                    </label>

                                    <input type="email"
                                           name="guestEmail"
                                           id="guestEmail"
                                           class="form-control form-control-sm"
                                           placeholder="Nhập email...">

                                </div>

                            </div>

                        </div>


                        <!-- THỜI GIAN -->
                        <h5 class="fw-bold text-primary mt-3 mb-3 border-bottom pb-2">

                            <i class="fa-solid fa-calendar-check me-1"></i>

                            Thời gian lưu trú & Số lượng khách

                        </h5>


                        <div class="row">

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">
                                    Ngày nhận phòng
                                </label>

                                <input type="date"
                                       name="checkIn"
                                       id="checkIn"
                                       class="form-control"
                                       required>

                            </div>


                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">
                                    Ngày trả phòng
                                </label>

                                <input type="date"
                                       name="checkOut"
                                       id="checkOut"
                                       class="form-control"
                                       required>

                            </div>

                        </div>


                        <!-- SỐ LƯỢNG KHÁCH -->
                        <div class="row">

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">
                                    Số lượng Người lớn (Adults)
                                </label>

                                <input type="number"
                                       name="adults"
                                       id="adults"
                                       class="form-control"
                                       value="1"
                                       min="1"
                                       max="6"
                                       required>

                            </div>


                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">
                                    Số lượng Trẻ em (Children)
                                </label>

                                <input type="number"
                                       name="children"
                                       id="children"
                                       class="form-control"
                                       value="0"
                                       min="0"
                                       max="6"
                                       required>

                            </div>

                        </div>


                        <!-- GHI CHÚ -->
                        <div class="mb-4">

                            <label class="form-label fw-bold">
                                Yêu cầu đặc biệt / Ghi chú
                            </label>

                            <textarea name="note"
                                      class="form-control"
                                      rows="2"
                                      placeholder="Ví dụ: phòng tầng cao, giường phụ, check-in muộn..."></textarea>

                        </div>


                        <!-- CHÍNH SÁCH -->
                        <div class="alert alert-secondary p-3 small mb-4">

                            <h6 class="fw-bold text-dark mb-2">

                                <i class="fa-solid fa-circle-exclamation text-warning me-1"></i>

                                Chính sách khách sạn & Quy định áp dụng:

                            </h6>

                            <ul class="mb-0 ps-3 text-muted">

                                <li>
                                    <strong>Chính sách hủy phòng:</strong>
                                    Hủy phòng miễn phí trước 24 giờ kể từ thời điểm nhận phòng.
                                    Hủy trễ hơn sẽ chịu phí đêm đầu tiên.
                                </li>

                                <li>
                                    <strong>Thời gian Check-in/out:</strong>
                                    Nhận phòng sau 14:00 | Trả phòng trước 12:00 trưa hôm sau.
                                </li>

                                <li>
                                    <strong>Quy định:</strong>
                                    Quý khách vui lòng xuất trình CCCD hoặc Hộ chiếu khi làm thủ tục nhận phòng tại quầy lễ tân.
                                </li>

                            </ul>

                        </div>


                        <!-- TỔNG CHI PHÍ -->
                        <div class="p-3 rounded bg-danger bg-opacity-10 border border-danger border-opacity-20 d-flex justify-content-between align-items-center mb-4">

                            <h5 class="fw-bold text-danger mb-0">
                                TỔNG CHI PHÍ DỰ KIẾN:
                            </h5>


                            <!--
                                Đây là phần HIỂN THỊ cho khách hàng.
                                Ví dụ:
                                500000 -> 500.000 VNĐ
                            -->
                            <span id="totalDisplay"
                                  class="fw-bold text-danger fs-4">

                                <fmt:formatNumber
                                        value="${room.price}"
                                        type="number"
                                        groupingUsed="true"
                                        maxFractionDigits="0"/> VNĐ

                            </span>


                            <!--
                                Đây là phần GỬI VỀ SERVER.

                                Không được thêm "VNĐ" ở đây.
                                Server sẽ nhận:
                                500000

                                Không nhận:
                                500000 VNĐ
                            -->
                            <input type="hidden"
                                   name="total"
                                   id="total"
                                   value="${room.price}">

                        </div>


                        <!-- BUTTON -->
                        <div class="d-flex justify-content-between mt-4">

                            <a href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                               class="btn btn-secondary">

                                <i class="fa-solid fa-arrow-left me-1"></i>

                                Quay lại

                            </a>


                            <button type="submit"
                                    class="btn btn-success px-4 fw-bold">

                                <i class="fa-solid fa-circle-check me-1"></i>

                                Xác nhận đặt phòng

                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>


<jsp:include page="../layout/footer.jsp"/>


<script>

document.addEventListener("DOMContentLoaded", function() {

    const checkInInput = document.getElementById('checkIn');

    const checkOutInput = document.getElementById('checkOut');

    // Input hidden - gửi số về Java
    const totalInput = document.getElementById('total');

    // Span - chỉ hiển thị cho khách hàng
    const totalDisplay = document.getElementById('totalDisplay');

    // Giá phòng gốc
    const basePrice = parseFloat("${room.price}") || 0;


    // Định dạng tiền Việt Nam
    function formatCurrency(number) {

        return new Intl.NumberFormat('vi-VN').format(number) + " VNĐ";

    }


    // Ngày nhận phòng không được nhỏ hơn hôm nay
    const today = new Date()
        .toISOString()
        .split('T')[0];

    checkInInput.min = today;


    function calculateTotal() {

        if (checkInInput.value && checkOutInput.value) {

            const checkInDate = new Date(checkInInput.value);

            const checkOutDate = new Date(checkOutInput.value);

            const timeDiff =
                checkOutDate.getTime() -
                checkInDate.getTime();

            const nights =
                Math.ceil(
                    timeDiff /
                    (1000 * 3600 * 24)
                );


            if (nights > 0) {

                const totalAmount =
                    nights * basePrice;


                // Gửi về server dưới dạng số
                totalInput.value =
                    totalAmount.toFixed(0);


                // Hiển thị đẹp cho người dùng
                totalDisplay.textContent =
                    formatCurrency(totalAmount);

            } else {

                totalInput.value =
                    basePrice.toFixed(0);

                totalDisplay.textContent =
                    formatCurrency(basePrice);

                checkOutInput.value = "";

                alert(
                    "Ngày trả phòng phải sau ngày nhận phòng ít nhất 1 ngày!"
                );

            }

        } else {

            totalInput.value =
                basePrice.toFixed(0);

            totalDisplay.textContent =
                formatCurrency(basePrice);

        }

    }


    // Khi thay đổi ngày nhận phòng
    checkInInput.addEventListener("change", function() {

        if (checkInInput.value) {

            const nextDay =
                new Date(checkInInput.value);

            nextDay.setDate(
                nextDay.getDate() + 1
            );

            checkOutInput.min =
                nextDay
                    .toISOString()
                    .split('T')[0];

        }

        calculateTotal();

    });


    // Khi thay đổi ngày trả phòng
    checkOutInput.addEventListener(
        "change",
        calculateTotal
    );

});


/* ================================
   ĐẶT PHÒNG HỘ CHO NGƯỜI KHÁC
   ================================ */

function toggleGuestFields() {

    const isChecked =
        document.getElementById(
            'isBookingForOthers'
        ).checked;


    const guestFields =
        document.getElementById(
            'guestFields'
        );


    const guestName =
        document.getElementById(
            'guestName'
        );


    const guestPhone =
        document.getElementById(
            'guestPhone'
        );


    if (isChecked) {

        guestFields.classList.remove(
            'd-none'
        );

        guestName.required = true;

        guestPhone.required = true;

    } else {

        guestFields.classList.add(
            'd-none'
        );

        guestName.required = false;

        guestPhone.required = false;

        guestName.value = "";

        guestPhone.value = "";

        document.getElementById(
            'guestEmail'
        ).value = "";

    }

}

</script>


</body>

</html>