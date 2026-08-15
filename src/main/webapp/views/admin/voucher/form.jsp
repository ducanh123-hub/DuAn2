<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>

        <c:choose>
            <c:when test="${mode == 'edit'}">Sửa Voucher</c:when>
            <c:otherwise>Thêm Voucher</c:otherwise>
        </c:choose>

        - Luxury Hotel

    </title>

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
           CARD
           ===================================================== */

        .card {
            border-radius: 12px;
            overflow: hidden;
        }


        /* =====================================================
           LỖI
           ===================================================== */

        .error-box {
            border-left: 5px solid #dc3545;
        }

    </style>

</head>


<body class="bg-light">


<!-- =====================================================
     HEADER
     ===================================================== -->

<jsp:include page="../../layout/header.jsp"/>


<div class="container mt-5 mb-5">

    <div class="row justify-content-center">

        <div class="col-lg-8">

            <div class="card shadow border-0">


                <!-- =================================================
                     HEADER CARD
                     ================================================= -->

                <div class="card-header bg-dark text-white py-3">

                    <h4 class="mb-0">

                        <i class="fa-solid fa-ticket me-2"></i>

                        <c:choose>
                            <c:when test="${mode == 'edit'}">Sửa Voucher</c:when>
                            <c:otherwise>Thêm Voucher mới</c:otherwise>
                        </c:choose>

                    </h4>

                </div>


                <div class="card-body p-4">


                    <!-- =================================================
                         THÔNG BÁO LỖI
                         ================================================= -->

                    <c:if test="${error != null}">

                        <div class="alert alert-danger error-box">

                            <i class="fa-solid fa-triangle-exclamation me-2"></i>

                            ${error}

                        </div>

                    </c:if>


                    <!-- =================================================
                         FORM
                         ================================================= -->

                    <form
                        method="post"
                        action="${pageContext.request.contextPath}/voucher"
                        id="voucherForm">


                        <input
                            type="hidden"
                            name="action"
                            value="${mode == 'edit' ? 'update' : 'insert'}">


                        <c:if test="${mode == 'edit'}">

                            <input
                                type="hidden"
                                name="promotionID"
                                value="${voucher.promotionID}">

                        </c:if>


                        <!-- =================================================
                             MÃ & TÊN
                             ================================================= -->

                        <div class="row">


                            <!-- MÃ VOUCHER -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Mã voucher <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="text"
                                    name="code"
                                    class="form-control text-uppercase"
                                    value="${voucher.code}"
                                    placeholder="VD: HOTEL10"
                                    required>

                            </div>


                            <!-- TÊN CHƯƠNG TRÌNH -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Tên chương trình <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="text"
                                    name="name"
                                    class="form-control"
                                    value="${voucher.name}"
                                    placeholder="VD: Ưu đãi mùa hè"
                                    required>

                            </div>

                        </div>


                        <!-- =================================================
                             MÔ TẢ
                             ================================================= -->

                        <div class="mb-3">

                            <label class="form-label fw-bold">

                                Mô tả

                            </label>

                            <textarea
                                name="description"
                                class="form-control"
                                rows="2"
                                placeholder="Mô tả ngắn về chương trình khuyến mãi...">${voucher.description}</textarea>

                        </div>


                        <!-- =================================================
                             LOẠI GIẢM & GIÁ TRỊ
                             ================================================= -->

                        <h5
                            class="fw-bold text-primary mt-3 mb-3 border-bottom pb-2">

                            <i class="fa-solid fa-percent me-1"></i>

                            Thiết lập giảm giá

                        </h5>


                        <div class="row">


                            <!-- LOẠI GIẢM -->

                            <div class="col-md-4 mb-3">

                                <label class="form-label fw-bold">

                                    Loại giảm giá <span class="text-danger">*</span>

                                </label>

                                <select
                                    name="discountType"
                                    id="discountType"
                                    class="form-select"
                                    required>

                                    <option
                                        value="Percentage"
                                        ${voucher.discountType == 'Percentage' ? 'selected' : ''}>

                                        Phần trăm (%)

                                    </option>

                                    <option
                                        value="FixedAmount"
                                        ${voucher.discountType == 'FixedAmount' ? 'selected' : ''}>

                                        Số tiền cố định (VNĐ)

                                    </option>

                                </select>

                            </div>


                            <!-- GIÁ TRỊ GIẢM -->

                            <div class="col-md-4 mb-3">

                                <label class="form-label fw-bold">

                                    Giá trị giảm <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="number"
                                    step="0.01"
                                    min="0"
                                    name="discountValue"
                                    class="form-control"
                                    value="${voucher.discountValue}"
                                    required>

                            </div>


                            <!-- GIẢM TỐI ĐA -->

                            <div class="col-md-4 mb-3">

                                <label class="form-label fw-bold">

                                    Giảm tối đa (VNĐ)

                                </label>

                                <input
                                    type="number"
                                    step="0.01"
                                    min="0"
                                    name="maxDiscountAmount"
                                    class="form-control"
                                    value="${voucher.maxDiscountAmount}"
                                    placeholder="Để trống nếu không giới hạn">

                                <div class="form-text">

                                    Chỉ áp dụng cho loại phần trăm. Để trống = không giới hạn.

                                </div>

                            </div>

                        </div>


                        <!-- =================================================
                             ĐIỀU KIỆN ÁP DỤNG
                             ================================================= -->

                        <div class="row">


                            <!-- ĐƠN TỐI THIỂU -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Giá trị đơn tối thiểu (VNĐ)

                                </label>

                                <input
                                    type="number"
                                    step="0.01"
                                    min="0"
                                    name="minOrderAmount"
                                    class="form-control"
                                    value="${voucher.minOrderAmount}"
                                    placeholder="0">

                            </div>


                            <!-- GIỚI HẠN LƯỢT DÙNG -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Giới hạn lượt sử dụng

                                </label>

                                <input
                                    type="number"
                                    min="1"
                                    name="usageLimit"
                                    class="form-control"
                                    value="${voucher.usageLimit}"
                                    placeholder="Để trống nếu không giới hạn">

                            </div>

                        </div>


                        <!-- =================================================
                             THỜI GIAN HIỆU LỰC
                             ================================================= -->

                        <h5
                            class="fw-bold text-primary mt-3 mb-3 border-bottom pb-2">

                            <i class="fa-solid fa-calendar-days me-1"></i>

                            Thời gian hiệu lực

                        </h5>


                        <div class="row">


                            <!-- NGÀY BẮT ĐẦU -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Ngày bắt đầu <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="date"
                                    name="startDate"
                                    id="startDate"
                                    class="form-control"
                                    value="${voucher.startDate}"
                                    required>

                            </div>


                            <!-- NGÀY KẾT THÚC -->

                            <div class="col-md-6 mb-3">

                                <label class="form-label fw-bold">

                                    Ngày kết thúc <span class="text-danger">*</span>

                                </label>

                                <input
                                    type="date"
                                    name="endDate"
                                    id="endDate"
                                    class="form-control"
                                    value="${voucher.endDate}"
                                    required>

                            </div>

                        </div>


                        <!-- =================================================
                             TRẠNG THÁI
                             ================================================= -->

                        <div class="mb-4">

                            <label class="form-label fw-bold">

                                Trạng thái

                            </label>

                            <select
                                name="status"
                                class="form-select">

                                <option
                                    value="Active"
                                    ${voucher.status == 'Active' || empty voucher.status ? 'selected' : ''}>

                                    Đang hoạt động

                                </option>

                                <option
                                    value="Inactive"
                                    ${voucher.status == 'Inactive' ? 'selected' : ''}>

                                    Vô hiệu hóa

                                </option>

                            </select>

                        </div>


                        <!-- =================================================
                             NÚT
                             ================================================= -->

                        <div class="d-flex justify-content-between mt-4">


                            <!-- QUAY LẠI -->

                            <a
                                href="${pageContext.request.contextPath}/voucher"
                                class="btn btn-secondary">

                                <i class="fa-solid fa-arrow-left me-1"></i>

                                Quay lại

                            </a>


                            <!-- LƯU -->

                            <button
                                type="submit"
                                class="btn btn-success px-4 fw-bold">

                                <i class="fa-solid fa-circle-check me-1"></i>

                                Lưu voucher

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

<jsp:include page="../../layout/footer.jsp"/>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


<script>

/* ============================================================
   TỰ VIẾT HOA MÃ VOUCHER
   ============================================================ */

document.querySelector('input[name="code"]')
    .addEventListener("input", function (e) {
        e.target.value = e.target.value.toUpperCase();
    });


/* ============================================================
   NGÀY KẾT THÚC PHẢI SAU NGÀY BẮT ĐẦU
   ============================================================ */

document.getElementById("voucherForm")
    .addEventListener("submit", function (e) {

        const startDate = document.getElementById("startDate").value;
        const endDate   = document.getElementById("endDate").value;

        if (startDate && endDate && endDate < startDate) {

            e.preventDefault();

            alert("Ngày kết thúc phải sau ngày bắt đầu!");

        }

    });

</script>


</body>

</html>
