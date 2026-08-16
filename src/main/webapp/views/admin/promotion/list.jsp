<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý khuyến mãi - Luxury Hotel</title>
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
                        <i class="fa-solid fa-tags me-2"></i>Quản lý khuyến mãi / Voucher
                    </h3>
                </div>
                <a href="${pageContext.request.contextPath}/promotion?action=add" class="btn btn-primary">
                    <i class="fa-solid fa-plus me-1"></i>Thêm Mã Khuyến Mãi
                </a>
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

            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Danh sách mã khuyến mãi (${fn:length(list)})</h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty list}">
                            <div class="text-center py-5 text-muted">
                                <i class="fa-solid fa-tags fs-1 mb-3"></i>
                                <p>Chưa có chương trình khuyến mãi nào.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-3">Mã Voucher</th>
                                            <th>Tên chương trình</th>
                                            <th>Loại / Mức giảm</th>
                                            <th>Số lượng</th>
                                            <th>Thời gian</th>
                                            <th class="text-center">Trạng thái</th>
                                            <th class="text-center">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="v" items="${list}">
                                            <tr>
                                                <td class="ps-3 fw-bold text-primary">${v.code}</td>
                                                <td>${v.name}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${v.discountType == 'percent'}">
                                                            <span class="badge bg-info text-dark">${v.discountValue}%</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-success">
                                                                <fmt:formatNumber value="${v.discountValue}" type="number"/>đ
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${empty v.usageLimit}">Không giới hạn</c:when>
                                                        <c:otherwise>${v.usedCount} / ${v.usageLimit}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="small text-muted">${v.startDate} đến ${v.endDate}</td>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${v.status == 'Active'}">
                                                            <span class="badge bg-success">Hoạt động</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">${v.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/promotion?action=edit&id=${v.promotionID}"
                                                       class="btn btn-sm btn-outline-primary me-1"><i class="fa-solid fa-edit"></i></a>
                                                    <a href="${pageContext.request.contextPath}/promotion?action=delete&id=${v.promotionID}"
                                                       class="btn btn-sm btn-outline-danger"
                                                       onclick="return confirm('Bạn có chắc muốn xóa voucher này?')"><i class="fa-solid fa-trash"></i></a>
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