<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục phòng - Luxury Hotel</title>
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
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold text-primary mb-1">
                        <i class="fa-solid fa-list-ul me-2"></i>Quản lý danh mục phòng
                    </h3>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active">Danh mục phòng</li>
                        </ol>
                    </nav>
                </div>
                <a href="${pageContext.request.contextPath}/room-category?action=add"
                   class="btn btn-primary">
                    <i class="fa-solid fa-plus me-1"></i>Thêm loại phòng
                </a>
            </div>

            <!-- Thông báo -->
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

            <!-- Tìm kiếm -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-body p-3">
                    <form method="get" action="${pageContext.request.contextPath}/room-category"
                          class="d-flex gap-2">
                        <input type="hidden" name="action" value="search">
                        <input type="text" name="keyword" class="form-control"
                               placeholder="Tìm theo tên hoặc mô tả..."
                               value="${keyword}">
                        <button type="submit" class="btn btn-outline-primary px-4">
                            <i class="fa-solid fa-search me-1"></i>Tìm
                        </button>
                        <c:if test="${not empty keyword}">
                            <a href="${pageContext.request.contextPath}/room-category"
                               class="btn btn-outline-secondary">
                                <i class="fa-solid fa-xmark"></i>
                            </a>
                        </c:if>
                    </form>
                </div>
            </div>

            <!-- Bảng danh sách -->
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">
                        <i class="fa-solid fa-table me-2"></i>
                        Danh sách loại phòng
                        <span class="badge bg-warning text-dark ms-2">${list.size()}</span>
                    </h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty list}">
                            <div class="text-center py-5 text-muted">
                                <i class="fa-solid fa-inbox fs-1 mb-3"></i>
                                <p>Chưa có loại phòng nào.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-4">#</th>
                                            <th>Tên loại phòng</th>
                                            <th>Mô tả</th>
                                            <th class="text-end">Giá cơ bản</th>
                                            <th class="text-center">Sức chứa</th>
                                            <th class="text-center">Trạng thái</th>
                                            <th class="text-center">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cat" items="${list}" varStatus="s">
                                            <tr>
                                                <td class="ps-4 text-muted">${s.count}</td>
                                                <td class="fw-semibold">${cat.categoryName}</td>
                                                <td class="text-muted" style="max-width: 200px;">
                                                    <div class="text-truncate" title="${cat.description}">
                                                        ${not empty cat.description ? cat.description : '—'}
                                                    </div>
                                                </td>
                                                <td class="text-end fw-bold text-success">
                                                    <fmt:formatNumber value="${cat.basePrice}" type="number"/>đ
                                                </td>
                                                <td class="text-center">
                                                    <i class="fa-solid fa-user me-1 text-info"></i>${cat.maxPeople}
                                                </td>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${cat.status == 'Active'}">
                                                            <span class="badge bg-success">Hoạt động</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">${cat.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/room-category?action=edit&id=${cat.categoryID}"
                                                       class="btn btn-sm btn-outline-primary me-1"
                                                       title="Chỉnh sửa">
                                                        <i class="fa-solid fa-edit"></i>
                                                    </a>
                                                    <button type="button"
                                                            class="btn btn-sm btn-outline-danger"
                                                            title="Xóa"
                                                            onclick="confirmDelete(${cat.categoryID}, '${cat.categoryName}')">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Modal xác nhận xóa -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i>Xác nhận xóa
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc muốn xóa loại phòng <strong id="deleteName"></strong>?</p>
                <p class="text-danger small">
                    <i class="fa-solid fa-info-circle me-1"></i>
                    Không thể xóa nếu đang có phòng sử dụng loại phòng này!
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <a id="deleteConfirmBtn" href="#" class="btn btn-danger">
                    <i class="fa-solid fa-trash me-1"></i>Xóa
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(id, name) {
        document.getElementById('deleteName').textContent = name;
        document.getElementById('deleteConfirmBtn').href =
            '${pageContext.request.contextPath}/room-category?action=delete&id=' + id;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }
</script>
</body>
</html>
