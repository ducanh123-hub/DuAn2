<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cấu hình hệ thống - Luxury Hotel</title>
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
                <h3 class="fw-bold text-primary mb-1">
                    <i class="fa-solid fa-gear me-2"></i>Cấu hình hệ thống
                </h3>
            </div>

            <c:if test="${not empty successMsg}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-check-circle me-2"></i>${successMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Thông tin Khách sạn & Quy định</h5>
                </div>
                <div class="card-body p-4">
                    <form method="post" action="${pageContext.request.contextPath}/admin/setting">
                        <input type="hidden" name="settingID" value="${setting.settingID}">

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Tên khách sạn *</label>
                                <input type="text" name="hotelName" class="form-control" value="${setting.hotelName}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Số điện thoại *</label>
                                <input type="text" name="phone" class="form-control" value="${setting.phone}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Email hỗ trợ *</label>
                                <input type="email" name="email" class="form-control" value="${setting.email}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Địa chỉ</label>
                                <input type="text" name="address" class="form-control" value="${setting.address}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Giờ Check-in tiêu chuẩn</label>
                                <input type="time" name="checkinTime" class="form-control" value="${setting.checkinTime}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Giờ Check-out tiêu chuẩn</label>
                                <input type="time" name="checkoutTime" class="form-control" value="${setting.checkoutTime}">
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-bold">Chính sách hủy phòng</label>
                                <textarea name="cancelPolicy" class="form-control" rows="3">${setting.cancelPolicy}</textarea>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-bold">Phương thức thanh toán chấp nhận</label>
                                <input type="text" name="paymentMethods" class="form-control" value="${setting.paymentMethods}">
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-bold">Ghi chú khác</label>
                                <textarea name="otherSetting" class="form-control" rows="2">${setting.otherSetting}</textarea>
                            </div>
                        </div>

                        <div class="mt-4">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="fa-solid fa-save me-1"></i>Lưu cấu hình
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
