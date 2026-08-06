<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Quản lý người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="../../layout/header.jsp"/>

<div class="container mt-4">

    <h2>Danh sách người dùng</h2>

    <table class="table table-bordered table-hover">

        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Họ tên</th>
            <th>Email</th>
            <th>SĐT</th>
            <th>Quốc tịch</th>
            <th>Trạng thái</th>
        </tr>
        </thead>

        <tbody>

        <c:forEach items="${userList}" var="u">

            <tr>

                <td>${u.userID}</td>
                <td>${u.fullName}</td>
                <td>${u.email}</td>
                <td>${u.phone}</td>
                <td>${u.nationality}</td>
                <td>${u.status}</td>

            </tr>

        </c:forEach>

        </tbody>

    </table>

</div>

</body>
</html>