<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <style>
        .user-table th,.user-table td{white-space:nowrap;vertical-align:middle}
        .user-table th{font-size:14px}
        .user-table td{font-size:14px}
        .user-actions{display:flex;gap:6px;justify-content:center;white-space:nowrap}
        .user-actions form{margin:0}
        .search-box{max-width:420px}
        .role-badge{min-width:85px}
        .status-badge{min-width:75px}
    </style>
</head>

<body class="bg-light">
<jsp:include page="../../layout/header.jsp"/>

<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-md-3">
            <jsp:include page="../../layout/sidebar.jsp"/>
        </div>

        <div class="col-md-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold text-primary mb-1">Quản lý người dùng</h3>
                    <nav>
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/user?action=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active">Quản lý người dùng</li>
                        </ol>
                    </nav>
                </div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                    + Thêm người dùng
                </button>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="card shadow-sm border-0 mb-3">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/user" method="get" class="d-flex gap-2">
                        <input type="hidden" name="action" value="list">
                        <input type="text" name="keyword" value="${param.keyword}" class="form-control search-box"
                               placeholder="Tìm theo tên, email hoặc SĐT...">
                        <button class="btn btn-primary">Tìm kiếm</button>
                        <a href="${pageContext.request.contextPath}/user?action=list" class="btn btn-outline-secondary">Làm mới</a>
                    </form>
                </div>
            </div>

            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Danh sách người dùng (${userList.size()})</h5>
                </div>

                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 user-table">
                            <thead class="table-light">
                            <tr>
                                <th class="ps-3">ID</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>SĐT</th>
                                <th>Quốc tịch</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:choose>
                                <c:when test="${empty userList}">
                                    <tr>
                                        <td colspan="8" class="text-center py-5 text-muted">Không tìm thấy người dùng.</td>
                                    </tr>
                                </c:when>

                                <c:otherwise>
                                    <c:forEach items="${userList}" var="u">
                                        <tr>
                                            <td class="ps-3">${u.userID}</td>
                                            <td class="fw-semibold">${u.fullName}</td>
                                            <td>${u.email}</td>
                                            <td>${u.phone}</td>
                                            <td>${u.nationality}</td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.roleID == 1}">
                                                        <span class="badge bg-danger role-badge">Quản lý</span>
                                                    </c:when>
                                                    <c:when test="${u.roleID == 2}">
                                                        <span class="badge bg-primary role-badge">Nhân viên</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary role-badge">Khách hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.status == 'Active'}">
                                                        <span class="badge bg-success status-badge">Hoạt động</span>
                                                    </c:when>
                                                    <c:when test="${u.status == 'Locked'}">
                                                        <span class="badge bg-danger status-badge">Đã khóa</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning text-dark status-badge">${u.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <div class="user-actions">
                                                    <a href="${pageContext.request.contextPath}/user?action=edit&id=${u.userID}"
                                                       class="btn btn-sm btn-warning">Sửa</a>

                                                    <c:choose>
                                                        <c:when test="${u.status == 'Locked'}">
                                                            <form action="${pageContext.request.contextPath}/user" method="post">
                                                                <input type="hidden" name="action" value="unlockUser">
                                                                <input type="hidden" name="userId" value="${u.userID}">
                                                                <button type="submit" class="btn btn-sm btn-success">Mở khóa</button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <form action="${pageContext.request.contextPath}/user" method="post">
                                                                <input type="hidden" name="action" value="lockUser">
                                                                <input type="hidden" name="userId" value="${u.userID}">
                                                                <button type="submit" class="btn btn-sm btn-danger"
                                                                        onclick="return confirm('Bạn có chắc muốn khóa tài khoản này?')">
                                                                    Khóa
                                                                </button>
                                                            </form>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <button type="button" class="btn btn-sm btn-info text-white"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#resetModal${u.userID}">
                                                        Reset MK
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>

                                        <div class="modal fade" id="resetModal${u.userID}" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <form action="${pageContext.request.contextPath}/user" method="post">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Đặt lại mật khẩu</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>

                                                        <div class="modal-body">
                                                            <p>Người dùng: <strong>${u.fullName}</strong></p>
                                                            <input type="hidden" name="action" value="resetPassword">
                                                            <input type="hidden" name="userId" value="${u.userID}">
                                                            <input type="password" name="newPassword" class="form-control"
                                                                   minlength="6" required placeholder="Mật khẩu mới">
                                                        </div>

                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                            <button type="submit" class="btn btn-primary">Đặt lại</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>

<div class="modal fade" id="addUserModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/user" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm người dùng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="action" value="createUser">

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Họ tên</label>
                            <input type="text" name="fullName" class="form-control" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" name="password" class="form-control" minlength="6" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Vai trò</label>
                            <select name="roleID" class="form-select" required>
                                <option value="3">Khách hàng</option>
                                <option value="2">Nhân viên</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Giới tính</label>
                            <select name="gender" class="form-select">
                                <option value="">-- Chọn --</option>
                                <option value="Nam">Nam</option>
                                <option value="Nữ">Nữ</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Ngày sinh</label>
                            <input type="date" name="date" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">CCCD</label>
                            <input type="text" name="cccd" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" name="address" class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Quốc tịch</label>
                            <input type="text" name="nationality" class="form-control" value="Việt Nam">
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Thêm người dùng</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>