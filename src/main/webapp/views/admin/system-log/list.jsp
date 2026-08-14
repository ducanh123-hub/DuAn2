<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nhật ký hệ thống - Luxury Hotel</title>
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
                    <i class="fa-solid fa-scroll me-2"></i>Nhật ký hệ thống (System Logs)
                </h3>
            </div>

            <!-- Bộ lọc log -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-body p-3">
                    <form method="get" action="${pageContext.request.contextPath}/admin/system-log" class="row g-2">
                        <div class="col-md-3">
                            <input type="text" name="keyword" class="form-control" placeholder="Từ khóa..." value="${keyword}">
                        </div>
                        <div class="col-md-3">
                            <select name="filterAction" class="form-select">
                                <option value="">Tất cả Action</option>
                                <c:forEach var="a" items="${actions}">
                                    <option value="${a}" ${a == filterAction ? 'selected' : ''}>${a}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <input type="date" name="fromDate" class="form-control" value="${fromDate}">
                        </div>
                        <div class="col-md-2">
                            <input type="date" name="toDate" class="form-control" value="${toDate}">
                        </div>
                        <div class="col-md-2 d-flex gap-1">
                            <button type="submit" class="btn btn-primary w-100"><i class="fa-solid fa-search"></i></button>
                            <a href="${pageContext.request.contextPath}/admin/system-log" class="btn btn-outline-secondary"><i class="fa-solid fa-xmark"></i></a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Bảng Log -->
            <div class="card shadow border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Danh sách nhật ký (${list.size()})</h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty list}">
                            <div class="text-center py-5 text-muted">
                                <i class="fa-solid fa-scroll fs-1 mb-3"></i>
                                <p>Chưa có nhật ký nào.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0 font-monospace small">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-3">ID</th>
                                            <th>User ID</th>
                                            <th>Hành động</th>
                                            <th>Mô tả</th>
                                            <th>IP Address</th>
                                            <th>Thời gian</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="log" items="${list}">
                                            <tr>
                                                <td class="ps-3 text-muted">#${log.logID}</td>
                                                <td><span class="badge bg-secondary">${not empty log.userID ? log.userID : 'System'}</span></td>
                                                <td><span class="badge bg-info text-dark">${log.action}</span></td>
                                                <td>${log.description}</td>
                                                <td>${log.ipAddress}</td>
                                                <td class="text-muted">${log.createdAt}</td>
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
