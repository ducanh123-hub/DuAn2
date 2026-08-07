<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý loại phòng - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="card shadow border-0">
        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center py-3">
            <h4 class="mb-0"><i class="fa-solid fa-list-ul me-2"></i> Danh sách loại phòng</h4>
            <a href="${pageContext.request.contextPath}/room-category?action=add" class="btn btn-success btn-sm">
                <i class="fa-solid fa-plus me-1"></i> Thêm loại phòng
            </a>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover align-middle">
                    <thead class="table-dark">
                        <tr class="text-center">
                            <th>ID</th>
                            <th>Tên loại phòng</th>
                            <th>Mô tả</th>
                            <th>Giá cơ bản (VNĐ)</th>
                            <th>Số người tối đa</th>
                            <th>Trạng thái</th>
                            <th width="180">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="c">
                            <tr>
                                <td class="text-center fw-bold">${c.categoryID}</td>
                                <td>${c.categoryName}</td>
                                <td>${c.description}</td>
                                <td class="text-end text-danger fw-bold">${c.basePrice}</td>
                                <td class="text-center">${c.maxPeople}</td>
                                <td class="text-center">
                                    <span class="badge ${c.status == 'Available' || c.status == 'Active' ? 'bg-success' : 'bg-secondary'}">
                                        ${c.status}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/room-category?action=edit&id=${c.categoryID}" 
                                       class="btn btn-warning btn-sm me-1">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/room-category?action=delete&id=${c.categoryID}" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Bạn chắc chắn muốn xóa loại phòng này?')">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty list}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">Chưa có loại phòng nào trong hệ thống.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

</body>
</html>
