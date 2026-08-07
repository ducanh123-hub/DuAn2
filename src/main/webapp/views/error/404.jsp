<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Không tìm thấy trang - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<jsp:include page="../layout/header.jsp"/>

<div class="container my-auto text-center py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h1 class="display-1 fw-bold text-primary">404</h1>
            <h3 class="fw-bold mb-3">Không Tìm Thấy Trang</h3>
            <p class="text-muted mb-4">Trang bạn đang tìm kiếm không tồn tại hoặc đã bị di dời sang địa chỉ khác.</p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-warning text-dark fw-bold px-4 py-2 shadow-sm">
                <i class="fa-solid fa-house me-1"></i> Quay về Trang chủ
            </a>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
