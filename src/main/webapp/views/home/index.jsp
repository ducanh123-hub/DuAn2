<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>

    <title>Luxury Hotel</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/home.css">

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body>

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">

    <h2 class="mb-4">

        Danh sách phòng nổi bật

    </h2>

    <div class="row">

        <c:forEach items="${roomList}" var="room">

            <div class="col-md-4 mb-4">

                <div class="card shadow">

                    <div class="card-body">

                        <h5>${room.roomName}</h5>

                        <p>

                            Giá:

                            ${room.price}

                            VNĐ

                        </p>

                        <p>

                            Trạng thái:

                            ${room.status}

                        </p>

                        <a

                                href="${pageContext.request.contextPath}/room/detail?id=${room.roomID}"

                                class="btn btn-primary">

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