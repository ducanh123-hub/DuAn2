<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật loại phòng - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="card shadow border-0 max-width-600 mx-auto" style="max-width: 600px;">
        <div class="card-header bg-warning py-3">
            <h4 class="mb-0 text-dark"><i class="fa-solid fa-pen-to-square me-2"></i> Cập nhật loại phòng</h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/room-category?action=update" method="post">
                <input type="hidden" name="categoryID" value="${category.categoryID}">

                <div class="mb-3">
                    <label class="form-label fw-bold">Tên loại phòng</label>
                    <input type="text" class="form-control" name="categoryName" value="${category.categoryName}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Mô tả</label>
                    <textarea class="form-control" name="description" rows="3">${category.description}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Giá cơ bản (VNĐ)</label>
                    <input type="number" class="form-control" name="basePrice" value="${category.basePrice}" required min="0">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Số người tối đa</label>
                    <input type="number" class="form-control" name="maxPeople" value="${category.maxPeople}" required min="1" max="10">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Trạng thái</label>
                    <select class="form-select" name="status">
                        <option value="Available" ${category.status == 'Available' ? 'selected' : ''}>Available (Có sẵn)</option>
                        <option value="Unavailable" ${category.status == 'Unavailable' ? 'selected' : ''}>Unavailable (Hết hàng)</option>
                    </select>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/room-category" class="btn btn-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                    </a>
                    <button type="submit" class="btn btn-warning text-dark">
                        <i class="fa-solid fa-save me-1"></i> Cập nhật
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

</body>
</html>
