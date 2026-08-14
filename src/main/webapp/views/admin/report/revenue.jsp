<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê doanh thu - Luxury Hotel</title>
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
                    <i class="fa-solid fa-chart-line me-2"></i>Thống kê Doanh thu
                </h3>
            </div>

            <!-- Tổng quan -->
            <div class="card shadow-sm border-0 mb-4 bg-primary text-white">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase mb-1 opacity-75">TỔNG DOANH THU HỆ THỐNG</h6>
                        <h2 class="fw-bold mb-0">
                            <fmt:formatNumber value="${totalRevenue}" type="number"/> VNĐ
                        </h2>
                    </div>
                    <i class="fa-solid fa-sack-dollar fs-1 opacity-50"></i>
                </div>
            </div>

            <!-- Bộ lọc thời gian -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-body p-3">
                    <form method="get" action="${pageContext.request.contextPath}/admin/report" class="row g-2 align-items-center">
                        <input type="hidden" name="tab" value="revenue">
                        <div class="col-md-4">
                            <select name="month" class="form-select">
                                <c:forEach begin="1" end="12" var="m">
                                    <option value="${m}" ${m == month ? 'selected' : ''}>Tháng ${m}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <select name="year" class="form-select">
                                <c:forEach begin="${currentYear - 4}" end="${currentYear}" var="y">
                                    <option value="${y}" ${y == year ? 'selected' : ''}>Năm ${y}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fa-solid fa-filter me-1"></i>Lọc thống kê
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Bảng Doanh thu theo Ngày -->
            <div class="card shadow border-0 mb-4">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Doanh thu theo ngày (Tháng ${month}/${year})</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3">Ngày</th>
                                <th class="text-end">Doanh thu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty revenueByDay}">
                                    <tr><td colspan="2" class="text-center py-4 text-muted">Chưa có doanh thu trong tháng này.</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="entry" items="${revenueByDay}">
                                        <tr>
                                            <td class="ps-3 fw-bold">${entry.key}</td>
                                            <td class="text-end text-success fw-bold">
                                                <fmt:formatNumber value="${entry.value}" type="number"/>đ
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Bảng Doanh thu theo Loại phòng -->
            <div class="card shadow border-0 mb-4">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Doanh thu theo Loại Phòng</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3">Loại phòng</th>
                                <th class="text-end">Tổng doanh thu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="entry" items="${revenueByCategory}">
                                <tr>
                                    <td class="ps-3 fw-bold">${entry.key}</td>
                                    <td class="text-end text-success fw-bold">
                                        <fmt:formatNumber value="${entry.value}" type="number"/>đ
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
