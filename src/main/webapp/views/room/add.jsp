<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm phòng mới - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="card shadow border-0 max-width-800 mx-auto" style="max-width: 800px;">
        <div class="card-header bg-success text-white py-3">
            <h4 class="mb-0"><i class="fa-solid fa-plus-circle me-2"></i> Thêm phòng mới</h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/room?action=insert" method="post">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">ID Loại phòng</label>
                        <input type="number" class="form-control" name="categoryID" required placeholder="Ví dụ: 1 (STD), 2 (DLX)">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Số phòng</label>
                        <input type="text" class="form-control" name="roomNumber" required placeholder="Ví dụ: 101, 202">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Tên phòng</label>
                        <input type="text" class="form-control" name="roomName" required placeholder="Ví dụ: Standard Room 101">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Giá phòng (VNĐ)</label>
                        <input type="number" class="form-control" name="price" required min="0" placeholder="Ví dụ: 500000">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Diện tích (m²)</label>
                        <input type="number" step="0.1" class="form-control" name="acreage" required placeholder="Ví dụ: 25.5">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Số giường</label>
                        <input type="number" class="form-control" name="bed" required min="1" placeholder="Ví dụ: 1 hoặc 2">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Khu vực / Tầng</label>
                        <input type="text" class="form-control" name="area" placeholder="Ví dụ: Tầng 1, Khu A">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Trạng thái</label>
                        <select class="form-select" name="status">
                            <option value="Available">Available (Còn trống)</option>
                            <option value="Occupied">Occupied (Đang có khách)</option>
                            <option value="Maintenance">Maintenance (Bảo trì)</option>
                        </select>
                    </div>

                    <div class="col-12 mb-3">
                        <label class="form-label fw-bold">Mô tả chi tiết</label>
                        <textarea class="form-control" name="description" rows="3" placeholder="Nhập mô tả phòng..."></textarea>
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/room" class="btn btn-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                    </a>
                    <button type="submit" class="btn btn-success">
                        <i class="fa-solid fa-save me-1"></i> Lưu phòng
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

</body>
</html>