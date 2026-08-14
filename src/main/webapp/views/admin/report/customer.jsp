<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê khách hàng - Luxury Hotel</title>
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
                    <i class="fa-solid fa-chart-pie me-2"></i>Thống kê Khách hàng
                </h3>
            </div>

            <!-- Thống kê tổng quan -->
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm bg-info text-white">
                        <div class="card-body p-4 d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase mb-1 opacity-75">Khách mới tháng này</h6>
                                <h2 class="fw-bold mb-0">${newCustomersThisMonth}</h2>
                            </div>
                            <i class="fa-solid fa-user-plus fs-1 opacity-50"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm bg-success text-white">
                        <div class="card-body p-4 d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase mb-1 opacity-75">Lượt lưu trú hoàn thành</h6>
                                <h2 class="fw-bold mb-0">${totalCompleted}</h2>
                            </div>
                            <i class="fa-solid fa-house-user fs-1 opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Top 10 Khách hàng thân thiết -->
            <div class="card shadow border-0 mb-4">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Top 10 Khách hàng đặt phòng nhiều nhất</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3">#</th>
                                <th>Họ và tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th class="text-center">Số lượt đặt</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${topCustomers}" varStatus="st">
                                <tr>
                                    <td class="ps-3 fw-bold">${st.count}</td>
                                    <td class="fw-bold">${c[0]}</td>
                                    <td>${c[1]}</td>
                                    <td>${c[2]}</td>
                                    <td class="text-center"><span class="badge bg-primary fs-6">${c[3]}</span></td>
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
