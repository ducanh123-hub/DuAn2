<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html>

<head>

    <title>Danh sách phòng</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/room.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body>

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-4">

    <h2>Danh sách phòng</h2>

    <form action="${pageContext.request.contextPath}/room">

        <input type="hidden" name="action" value="search">

        <div class="row">

            <div class="col-md-10">

                <input

                        class="form-control"

                        name="keyword"

                        placeholder="Nhập tên phòng...">

            </div>

            <div class="col-md-2">

                <button class="btn btn-primary w-100">

                    Tìm kiếm

                </button>

            </div>

        </div>

    </form>

    <hr>

    <div class="row">

        <c:forEach items="${roomList}" var="room">

            <div class="col-md-4">

                <div class="card mb-4 shadow">

                    <div class="card-body">

                        <h4>${room.roomName}</h4>

                        <p>Giá: ${room.price} VNĐ</p>

                        <p>Trạng thái: ${room.status}</p>

                        <a

                                href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"

                                class="btn btn-success">

                            Xem chi tiết

                        </a>

                    </div>

                </div>

            </div>

        </c:forEach>

    </div>

</div>

<jsp:include page="../layout/footer.jsp"/>

</body>

</html>