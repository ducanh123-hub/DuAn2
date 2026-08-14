<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${not empty voucher and voucher.voucherID > 0 ? 'Sửa' : 'Thêm'} khuyến mãi - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body class="bg-light">

<jsp:include page="../../layout/header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-3">
            <jsp:include page="../../layout/sidebar.jsp"/>
        </div>
        <div class="col-md-9">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold text-primary">
                    <i class="fa-solid fa-tags me-2"></i>
                    ${not empty voucher and voucher.voucherID > 0 ? 'Chỉnh sửa' : 'Thêm mới'} khuyến mãi
                </h3>
                <a href="${pageContext.request.contextPath}/promotion" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                </a>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card shadow border-0">
                <div class="card-body p-4">
                    <form method="post" action="${pageContext.request.contextPath}/promotion">
                        <c:choose>
                            <c:when test="${not empty voucher and voucher.voucherID > 0}">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="voucherID" value="${voucher.voucherID}">
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="action" value="insert">
                            </c:otherwise>
                        </c:choose>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Mã Voucher *</label>
                                <input type="text" name="voucherCode" class="form-control"
                                       placeholder="VD: SUMMERSALE" value="${voucher.voucherCode}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Tên chương trình *</label>
                                <input type="text" name="voucherName" class="form-control"
                                       placeholder="VD: Chào Hè Rực Rỡ" value="${voucher.voucherName}" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold">Loại giảm giá</label>
                                <select name="discountType" class="form-select">
                                    <option value="percent" ${voucher.discountType == 'percent' ? 'selected' : ''}>Phần trăm (%)</option>
                                    <option value="fixed" ${voucher.discountType == 'fixed' ? 'selected' : ''}>Số tiền cố định (VNĐ)</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold">Mức giảm *</label>
                                <input type="number" name="discountValue" class="form-control"
                                       placeholder="VD: 10 hoặc 100000" value="${voucher.discountValue}" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold">Số lượng *</label>
                                <input type="number" name="quantity" class="form-control"
                                       placeholder="VD: 50" value="${voucher.quantity}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Ngày bắt đầu *</label>
                                <input type="date" name="startDate" class="form-control" value="${voucher.startDate}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Ngày kết thúc *</label>
                                <input type="date" name="endDate" class="form-control" value="${voucher.endDate}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Giảm tối đa (VNĐ)</label>
                                <input type="number" name="maxDiscount" class="form-control"
                                       placeholder="Dành cho giảm theo %" value="${voucher.maxDiscount}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Đơn tối thiểu (VNĐ)</label>
                                <input type="number" name="minOrderValue" class="form-control"
                                       placeholder="VD: 500000" value="${voucher.minOrderValue}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Trạng thái</label>
                                <select name="status" class="form-select">
                                    <option value="Active" ${empty voucher or voucher.status == 'Active' ? 'selected' : ''}>Hoạt động</option>
                                    <option value="Inactive" ${voucher.status == 'Inactive' ? 'selected' : ''}>Ngừng dùng</option>
                                </select>
                            </div>
                        </div>

                        <div class="mt-4">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="fa-solid fa-save me-1"></i>Lưu khuyến mãi
                            </button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
