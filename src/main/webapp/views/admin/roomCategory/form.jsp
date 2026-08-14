<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${not empty category and category.categoryID > 0}">Chỉnh sửa</c:when>
            <c:otherwise>Thêm mới</c:otherwise>
        </c:choose>
        loại phòng - Luxury Hotel
    </title>
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

            <!-- Tiêu đề -->
            <div class="mb-4">
                <h3 class="fw-bold text-primary mb-1">
                    <c:choose>
                        <c:when test="${not empty category and category.categoryID > 0}">
                            <i class="fa-solid fa-edit me-2"></i>Chỉnh sửa loại phòng
                        </c:when>
                        <c:otherwise>
                            <i class="fa-solid fa-plus me-2"></i>Thêm loại phòng mới
                        </c:otherwise>
                    </c:choose>
                </h3>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/room-category">Danh mục phòng</a>
                        </li>
                        <li class="breadcrumb-item active">
                            <c:choose>
                                <c:when test="${not empty category and category.categoryID > 0}">Chỉnh sửa</c:when>
                                <c:otherwise>Thêm mới</c:otherwise>
                            </c:choose>
                        </li>
                    </ol>
                </nav>
            </div>

            <!-- Thông báo lỗi -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Form -->
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">
                        <i class="fa-solid fa-form me-2"></i>
                        Thông tin loại phòng
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form method="post"
                          action="${pageContext.request.contextPath}/room-category"
                          id="categoryForm" novalidate>

                        <%-- Action: insert hoặc update --%>
                        <c:choose>
                            <c:when test="${not empty category and category.categoryID > 0}">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="categoryID" value="${category.categoryID}">
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="action" value="insert">
                            </c:otherwise>
                        </c:choose>

                        <div class="row g-3">
                            <!-- Tên loại phòng -->
                            <div class="col-md-8">
                                <label class="form-label fw-semibold">
                                    Tên loại phòng <span class="text-danger">*</span>
                                </label>
                                <input type="text" name="categoryName"
                                       class="form-control"
                                       placeholder="VD: Standard, Deluxe, Suite, Family..."
                                       value="${category.categoryName}"
                                       required maxlength="100">
                                <div class="invalid-feedback">Vui lòng nhập tên loại phòng!</div>
                            </div>

                            <!-- Trạng thái -->
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Trạng thái</label>
                                <select name="status" class="form-select">
                                    <option value="Active"
                                        ${empty category or category.status == 'Active' ? 'selected' : ''}>
                                        Hoạt động
                                    </option>
                                    <option value="Inactive"
                                        ${category.status == 'Inactive' ? 'selected' : ''}>
                                        Ngừng hoạt động
                                    </option>
                                </select>
                            </div>

                            <!-- Giá cơ bản -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">
                                    Giá cơ bản (đ/đêm) <span class="text-danger">*</span>
                                </label>
                                <div class="input-group">
                                    <input type="number" name="basePrice"
                                           class="form-control"
                                           placeholder="VD: 500000"
                                           value="${category.basePrice}"
                                           min="1" required>
                                    <span class="input-group-text">đ</span>
                                </div>
                                <div class="invalid-feedback">Vui lòng nhập giá hợp lệ!</div>
                            </div>

                            <!-- Sức chứa -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">
                                    Sức chứa (người) <span class="text-danger">*</span>
                                </label>
                                <div class="input-group">
                                    <input type="number" name="maxPeople"
                                           class="form-control"
                                           placeholder="VD: 2"
                                           value="${category.maxPeople}"
                                           min="1" required>
                                    <span class="input-group-text">
                                        <i class="fa-solid fa-user"></i>
                                    </span>
                                </div>
                                <div class="invalid-feedback">Vui lòng nhập sức chứa!</div>
                            </div>

                            <!-- Mô tả -->
                            <div class="col-12">
                                <label class="form-label fw-semibold">Mô tả / Tiện nghi</label>
                                <textarea name="description" class="form-control"
                                          rows="4"
                                          placeholder="Mô tả đặc điểm, tiện nghi của loại phòng này..."
                                          maxlength="500">${category.description}</textarea>
                                <small class="text-muted">Tối đa 500 ký tự</small>
                            </div>
                        </div>

                        <!-- Nút hành động -->
                        <div class="d-flex gap-2 mt-4">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="fa-solid fa-save me-1"></i>
                                <c:choose>
                                    <c:when test="${not empty category and category.categoryID > 0}">
                                        Lưu thay đổi
                                    </c:when>
                                    <c:otherwise>Thêm loại phòng</c:otherwise>
                                </c:choose>
                            </button>
                            <a href="${pageContext.request.contextPath}/room-category"
                               class="btn btn-outline-secondary px-4">
                                <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                            </a>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Bootstrap validation
    (function () {
        'use strict'
        const form = document.getElementById('categoryForm');
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    })();
</script>
</body>
</html>
