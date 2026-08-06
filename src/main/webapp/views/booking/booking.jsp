<%@page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<title>Đặt phòng</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">

<h2>Đặt phòng</h2>

<form method="post">

<input
type="hidden"
name="roomId"
value="${room.roomID}">

<div class="mb-3">

<label>Ngày nhận phòng</label>

<input

type="date"

name="checkIn"

class="form-control"

required>

</div>

<div class="mb-3">

<label>Ngày trả phòng</label>

<input

type="date"

name="checkOut"

class="form-control"

required>

</div>

<div class="mb-3">

<label>Tổng tiền</label>

<input

name="total"

class="form-control"

value="${room.price}"

readonly>

</div>

<button

class="btn btn-success">

Xác nhận đặt phòng

</button>

</form>

</div>

</body>

</html>