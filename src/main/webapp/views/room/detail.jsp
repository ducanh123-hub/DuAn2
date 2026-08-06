<%@page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<title>Chi tiết phòng</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

</head>

<body>

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">

<h2>${room.roomName}</h2>

<hr>

<h4>Giá</h4>

<p>${room.price} VNĐ</p>

<h4>Diện tích</h4>

<p>${room.acreage} m²</p>

<h4>Số giường</h4>

<p>${room.bed}</p>

<h4>Mô tả</h4>

<p>${room.description}</p>

<a

href="${pageContext.request.contextPath}/booking"

class="btn btn-primary">

Đặt ngay

</a>

</div>

</body>

</html>