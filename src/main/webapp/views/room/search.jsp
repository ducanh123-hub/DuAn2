<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>
        Kết quả tìm kiếm phòng - Luxury Hotel
    </title>


    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">


    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">


    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/assets/css/style.css">


    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/assets/css/room.css">


    <style>

        .search-hero {

            background:
                    linear-gradient(
                            rgba(12, 26, 48, 0.88),
                            rgba(12, 26, 48, 0.92)
                    ),
                    url('https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=1200&q=80')
                    no-repeat
                    center;

            background-size: cover;

            color: white;

            padding: 50px 0;

            border-bottom: 4px solid #ffc107;
        }


        .filter-card {

            background: white;

            border-radius: 15px;

            padding: 25px;

            box-shadow:
                    0 5px 20px rgba(0,0,0,0.08);
        }


        .room-card {

            border: none;

            border-radius: 15px;

            overflow: hidden;

            transition: 0.3s;
        }


        .room-card:hover {

            transform: translateY(-5px);

            box-shadow:
                    0 10px 30px rgba(0,0,0,0.15);
        }


        .room-image {

            height: 240px;

            object-fit: cover;
        }


        .price {

            color: #dc3545;

            font-weight: bold;

            font-size: 20px;
        }

    </style>

</head>


<body class="bg-light">


<jsp:include page="../layout/header.jsp"/>


<!-- =====================================================
     HERO
====================================================== -->

<div class="search-hero">

    <div class="container">

        <div class="text-center">

            <h2 class="fw-bold">

                KẾT QUẢ TÌM KIẾM PHÒNG

            </h2>


            <p class="text-warning">

                Tìm thấy những lựa chọn phù hợp với yêu cầu của bạn

            </p>

        </div>

    </div>

</div>


<div class="container my-5">


    <!-- =================================================
         FILTER
    ================================================== -->

    <div class="filter-card mb-5">


        <form
                action="${pageContext.request.contextPath}/room"
                method="get">


            <input
                    type="hidden"
                    name="action"
                    value="search">


            <div class="row g-3">


                <!-- KEYWORD -->

                <div class="col-md-12">

                    <label class="form-label fw-bold">

                        <i class="fa-solid fa-magnifying-glass me-1"></i>

                        Tìm kiếm

                    </label>


                    <input
                            type="text"
                            name="keyword"
                            class="form-control"
                            value="${keyword}"
                            placeholder="Tên phòng, số phòng hoặc loại phòng...">


                    <div class="mt-2">

                        <small class="text-muted">

                            Gợi ý:

                        </small>


                        <a
                                href="${pageContext.request.contextPath}/room?action=search&keyword=Standard"
                                class="badge bg-light text-dark border text-decoration-none">

                            Standard

                        </a>


                        <a
                                href="${pageContext.request.contextPath}/room?action=search&keyword=Deluxe"
                                class="badge bg-light text-dark border text-decoration-none">

                            Deluxe

                        </a>


                        <a
                                href="${pageContext.request.contextPath}/room?action=search&keyword=Suite"
                                class="badge bg-light text-dark border text-decoration-none">

                            Suite

                        </a>


                        <a
                                href="${pageContext.request.contextPath}/room?action=search&keyword=Family"
                                class="badge bg-light text-dark border text-decoration-none">

                            Family

                        </a>

                    </div>

                </div>


                <!-- MIN PRICE -->

                <div class="col-md-3">

                    <label class="form-label fw-bold">

                        Giá từ

                    </label>


                    <input
                            type="number"
                            name="minPrice"
                            value="${minPrice}"
                            class="form-control"
                            min="0"
                            step="100000"
                            placeholder="0">

                </div>


                <!-- MAX PRICE -->

                <div class="col-md-3">

                    <label class="form-label fw-bold">

                        Giá đến

                    </label>


                    <input
                            type="number"
                            name="maxPrice"
                            value="${maxPrice}"
                            class="form-control"
                            min="0"
                            step="100000"
                            placeholder="24.000.000">

                </div>


                <!-- PEOPLE -->

                <div class="col-md-3">

                    <label class="form-label fw-bold">

                        Số người

                    </label>


                    <select
                            name="people"
                            class="form-select">


                        <option value="">
                            Tất cả
                        </option>


                        <option
                                value="1"
                                ${people == 1 ? 'selected' : ''}>

                            1 người

                        </option>


                        <option
                                value="2"
                                ${people == 2 ? 'selected' : ''}>

                            2 người

                        </option>


                        <option
                                value="3"
                                ${people == 3 ? 'selected' : ''}>

                            3 người

                        </option>


                        <option
                                value="4"
                                ${people == 4 ? 'selected' : ''}>

                            4 người

                        </option>


                        <option
                                value="5"
                                ${people == 5 ? 'selected' : ''}>

                            5 người

                        </option>


                        <option
                                value="6"
                                ${people == 6 ? 'selected' : ''}>

                            6 người

                        </option>

                    </select>

                </div>


                <!-- SORT -->

                <div class="col-md-3">

                    <label class="form-label fw-bold">

                        Sắp xếp giá

                    </label>


                    <select
                            name="sortPrice"
                            class="form-select">


                        <option
                                value=""
                                ${empty sortPrice ? 'selected' : ''}>

                            Mặc định

                        </option>


                        <option
                                value="asc"
                                ${sortPrice == 'asc' ? 'selected' : ''}>

                            Giá thấp → cao

                        </option>


                        <option
                                value="desc"
                                ${sortPrice == 'desc' ? 'selected' : ''}>

                            Giá cao → thấp

                        </option>

                    </select>

                </div>


                <!-- BUTTON -->

                <div class="col-12">

                    <button
                            type="submit"
                            class="btn btn-warning fw-bold px-4">

                        <i class="fa-solid fa-filter me-2"></i>

                        Áp dụng bộ lọc

                    </button>


                    <a
                            href="${pageContext.request.contextPath}/room"
                            class="btn btn-outline-secondary ms-2">

                        <i class="fa-solid fa-rotate-left me-1"></i>

                        Xóa bộ lọc

                    </a>

                </div>

            </div>

        </form>

    </div>


    <!-- =================================================
         RESULT
    ================================================== -->

    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>

            <h4 class="fw-bold mb-1">

                Danh sách phòng

            </h4>


            <span class="text-muted">

                Tìm thấy

                <strong>
                    ${list.size()}
                </strong>

                phòng phù hợp

            </span>

        </div>

    </div>


    <!-- =================================================
         ROOM LIST
    ================================================== -->

    <div class="row">


        <c:forEach
                items="${list}"
                var="room">


            <div class="col-md-4 mb-4">


                <div class="card room-card h-100 shadow-sm">


                    <!-- IMAGE -->

                    <div class="position-relative">


                        <img
                                src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80"
                                class="card-img-top room-image"
                                alt="${room.roomName}">


                        <span
                                class="position-absolute top-0 end-0 bg-dark text-warning fw-bold px-3 py-2 m-3 rounded">


                            <c:choose>

                                <c:when test="${room.status == 'Còn trống'}">

                                    Còn trống

                                </c:when>


                                <c:when test="${room.status == 'Đang ở'}">

                                    Đang ở

                                </c:when>


                                <c:otherwise>

                                    ${room.status}

                                </c:otherwise>

                            </c:choose>


                        </span>

                    </div>


                    <!-- BODY -->

                    <div class="card-body p-4">


                        <div
                                class="d-flex justify-content-between align-items-start">


                            <h5
                                    class="card-title fw-bold text-primary">

                                ${room.roomName}

                            </h5>


                            <span class="badge bg-secondary">

                                P. ${room.roomNumber}

                            </span>

                        </div>


                        <p
                                class="text-muted small">


                            ${room.description != null
                                    ? room.description
                                    : 'Phòng đầy đủ tiện nghi hiện đại.'}

                        </p>


                        <!-- SPECS -->

                        <div class="d-flex gap-2 flex-wrap mb-3">


                            <span
                                    class="badge bg-light text-dark border">


                                <i
                                        class="fa-solid fa-expand text-muted me-1">
                                </i>


                                ${room.acreage} m²


                            </span>


                            <span
                                    class="badge bg-light text-dark border">


                                <i
                                        class="fa-solid fa-bed text-muted me-1">
                                </i>


                                ${room.bed} Giường


                            </span>


                            <span
                                    class="badge bg-light text-dark border">


                                <i
                                        class="fa-solid fa-location-dot text-muted me-1">
                                </i>


                                ${room.area}


                            </span>

                        </div>


                        <hr>


                        <!-- PRICE + BUTTON -->

                        <div
                                class="d-flex justify-content-between align-items-center">


                            <div>

                                <small
                                        class="text-muted d-block">

                                    Giá phòng / đêm

                                </small>


                                <span class="price">

                                    ${room.price} VNĐ

                                </span>

                            </div>


                            <div>


                                <a
                                        href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}"
                                        class="btn btn-outline-primary btn-sm">


                                    <i
                                            class="fa-solid fa-eye me-1">
                                    </i>

                                    Chi tiết

                                </a>


                                <c:if test="${room.status == 'Còn trống'}">


                                    <a
                                            href="${pageContext.request.contextPath}/booking?roomId=${room.roomID}"
                                            class="btn btn-success btn-sm ms-1">


                                        Đặt ngay

                                    </a>


                                </c:if>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </c:forEach>


        <!-- =================================================
             EMPTY
        ================================================== -->

        <c:if test="${empty list}">


            <div class="col-12">


                <div
                        class="text-center bg-white rounded shadow-sm py-5">


                    <i
                            class="fa-solid fa-hotel fa-3x text-warning mb-3">
                    </i>


                    <h4 class="fw-bold">

                        Không tìm thấy phòng

                    </h4>


                    <p class="text-muted">

                        Không có phòng nào phù hợp với điều kiện tìm kiếm.

                    </p>


                    <a
                            href="${pageContext.request.contextPath}/room"
                            class="btn btn-primary">


                        <i
                                class="fa-solid fa-list me-1">
                        </i>

                        Xem tất cả phòng

                    </a>

                </div>

            </div>

        </c:if>

    </div>

</div>


<jsp:include page="../layout/footer.jsp"/>


<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>