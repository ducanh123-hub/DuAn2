<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Phân quyền người dùng - Luxury Hotel</title>
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
                    <i class="fa-solid fa-key me-2"></i>Quản lý Vai trò & Phân quyền
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

            <!-- Bảng danh sách vai trò -->
            <div class="card shadow border-0 mb-4">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Danh sách Vai trò trong Hệ thống</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3">Role ID</th>
                                <th>Tên vai trò</th>
                                <th>Mô tả</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${roles}">
                                <tr>
                                    <td class="ps-3 font-monospace">#${r.roleID}</td>
                                    <td class="fw-bold">${r.roleName}</td>
                                    <td class="text-muted">${r.description}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Bảng gán vai trò người dùng -->
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Gán Vai trò & Trạng thái Tài khoản</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3">Họ tên</th>
                                <th>Email</th>
                                <th>Vai trò hiện tại</th>
                                <th class="text-center">Trạng thái</th>
                                <th class="text-center">Đổi vai trò</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${users}">
                                <tr>
                                    <td class="ps-3 fw-bold">${u.fullName}</td>
                                    <td>${u.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${u.roleID == 1}"><span class="badge bg-warning text-dark">Quản lý</span></c:when>
                                            <c:when test="${u.roleID == 2}"><span class="badge bg-info text-dark">Nhân viên</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">Khách hàng</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${u.status == 'Active'}"><span class="badge bg-success">Active</span></c:when>
                                            <c:otherwise><span class="badge bg-danger">Locked</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/permission" class="d-flex gap-1 justify-content-center">
                                            <input type="hidden" name="action" value="assign-role">
                                            <input type="hidden" name="userId" value="${u.userID}">
                                            <select name="roleId" class="form-select form-select-sm" style="width: auto;">
                                                <option value="1" ${u.roleID == 1 ? 'selected' : ''}>Quản lý</option>
                                                <option value="2" ${u.roleID == 2 ? 'selected' : ''}>Nhân viên</option>
                                                <option value="3" ${u.roleID == 3 ? 'selected' : ''}>Khách hàng</option>
                                            </select>
                                            <button type="submit" class="btn btn-sm btn-outline-primary">Lưu</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
