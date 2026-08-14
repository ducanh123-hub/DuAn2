<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý bình luận - Luxury Hotel</title>
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
                <div>
                    <h3 class="fw-bold text-primary mb-1">
                        <i class="fa-solid fa-comments me-2"></i>Quản lý bình luận & Đánh giá
                    </h3>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                            <li class="breadcrumb-item active">Bình luận</li>
                        </ol>
                    </nav>
                </div>
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

            <!-- Bộ lọc -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-body p-3">
                    <form method="get" action="${pageContext.request.contextPath}/review" class="row g-2">
                        <input type="hidden" name="action" value="admin-list">
                        <div class="col-md-6">
                            <input type="text" name="keyword" class="form-control"
                                   placeholder="Tìm theo tên khách, phòng, nội dung..."
                                   value="${keyword}">
                        </div>
                        <div class="col-md-3">
                            <select name="status" class="form-select">
                                <option value="">Tất cả trạng thái</option>
                                <option value="Pending" ${filterStatus == 'Pending' ? 'selected' : ''}>Chờ duyệt</option>
                                <option value="Approved" ${filterStatus == 'Approved' ? 'selected' : ''}>Đã duyệt</option>
                                <option value="Hidden" ${filterStatus == 'Hidden' ? 'selected' : ''}>Đã ẩn</option>
                            </select>
                        </div>
                        <div class="col-md-3 d-flex gap-1">
                            <button type="submit" class="btn btn-outline-primary flex-grow-1">
                                <i class="fa-solid fa-search me-1"></i>Lọc
                            </button>
                            <a href="${pageContext.request.contextPath}/review?action=admin-list"
                               class="btn btn-outline-secondary">
                                <i class="fa-solid fa-xmark"></i>
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Bảng bình luận -->
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">
                        <i class="fa-solid fa-table me-2"></i>Danh sách bình luận (${list.size()})
                    </h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty list}">
                            <div class="text-center py-5 text-muted">
                                <i class="fa-solid fa-comments fs-1 mb-3"></i>
                                <p>Không tìm thấy bình luận nào.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-3">Khách hàng</th>
                                            <th>Phòng</th>
                                            <th class="text-center">Đánh giá</th>
                                            <th>Nội dung</th>
                                            <th class="text-center">Trạng thái</th>
                                            <th class="text-center">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="r" items="${list}">
                                            <tr>
                                                <td class="ps-3 fw-bold">${r.customerName}</td>
                                                <td><span class="badge bg-secondary">${r.roomNumber}</span> ${r.roomName}</td>
                                                <td class="text-center text-warning">
                                                    <c:forEach begin="1" end="${r.rating}">★</c:forEach>
                                                </td>
                                                <td style="max-width: 250px;">
                                                    <div class="text-truncate" title="${r.comment}">${r.comment}</div>
                                                    <c:if test="${not empty r.reply}">
                                                        <small class="text-primary d-block">
                                                            <i class="fa-solid fa-reply me-1"></i>Đã phản hồi
                                                        </small>
                                                    </c:if>
                                                </td>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${r.status == 'Approved'}">
                                                            <span class="badge bg-success">Đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${r.status == 'Pending'}">
                                                            <span class="badge bg-warning text-dark">Chờ duyệt</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger">Đã ẩn</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/review?action=admin-detail&id=${r.reviewID}"
                                                       class="btn btn-sm btn-outline-info" title="Chi tiết & Phản hồi">
                                                        <i class="fa-solid fa-eye"></i>
                                                    </a>
                                                    <c:if test="${r.status != 'Approved'}">
                                                        <a href="${pageContext.request.contextPath}/review?action=approve&id=${r.reviewID}"
                                                           class="btn btn-sm btn-outline-success" title="Duyệt">
                                                            <i class="fa-solid fa-check"></i>
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${r.status != 'Hidden'}">
                                                        <a href="${pageContext.request.contextPath}/review?action=hide&id=${r.reviewID}"
                                                           class="btn btn-sm btn-outline-warning" title="Ẩn">
                                                            <i class="fa-solid fa-eye-slash"></i>
                                                        </a>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/review?action=delete&id=${r.reviewID}"
                                                       class="btn btn-sm btn-outline-danger" title="Xóa"
                                                       onclick="return confirm('Bạn có chắc muốn xóa bình luận này?')">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </a>
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

<jsp:include page="../../layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
