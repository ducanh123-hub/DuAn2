<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý phòng - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/room.css">
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">
    <div class="card shadow border-0">
        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center py-3">
            <h4 class="mb-0"><i class="fa-solid fa-bed me-2"></i> Danh sách quản lý phòng</h4>
            <c:if test="${sessionScope.user != null && sessionScope.user.roleID == 1}">
                <a href="${pageContext.request.contextPath}/room?action=add" class="btn btn-success btn-sm">
                    <i class="fa-solid fa-plus me-1"></i> Thêm phòng mới
                </a>
            </c:if>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover align-middle">
                    <thead class="table-dark">
                        <tr class="text-center">
                            <th>ID</th>
                            <th>Số phòng</th>
                            <th>Tên phòng</th>
                            <th>Loại phòng ID</th>
                            <th>Giá phòng (VNĐ)</th>
                            <th>Diện tích</th>
                            <th>Giường</th>
                            <th>Khu vực</th>
                            <th>Trạng thái</th>
                            <th width="240">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="room">
                            <tr>
                                <td class="text-center fw-bold">${room.roomID}</td>
                                <td class="text-center fw-bold text-primary">${room.roomNumber}</td>
                                <td>${room.roomName}</td>
                                <td class="text-center">${room.categoryID}</td>
                                <td class="text-end text-danger fw-bold">${room.price}</td>
                                <td class="text-center">${room.acreage} m²</td>
                                <td class="text-center">${room.bed}</td>
                                <td class="text-center">${room.area}</td>
                                <td class="text-center">
                                    <span class="badge ${room.status == 'Available' ? 'bg-success' : (room.status == 'Occupied' ? 'bg-danger' : 'bg-warning')}">
                                        ${room.status}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}" 
                                       class="btn btn-info btn-sm text-white me-1">
                                        <i class="fa-solid fa-eye"></i> Chi tiết
                                    </a>
                                    <c:if test="${sessionScope.user != null && sessionScope.user.roleID == 1}">
                                        <a href="${pageContext.request.contextPath}/room?action=edit&id=${room.roomID}" 
                                           class="btn btn-warning btn-sm me-1">
                                            <i class="fa-solid fa-pen-to-square"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/room?action=delete&id=${room.roomID}" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa phòng này?')">
                                            <i class="fa-solid fa-trash"></i> Xóa
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty list}">
                            <tr>
                                <td colspan="10" class="text-center text-muted py-4">Chưa có phòng nào trong hệ thống.</td>
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