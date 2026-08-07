<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Cập nhật phòng</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/room.css">

</head>

<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<div class="container mt-5">

    <div class="card shadow border-0">

        <div class="card-header bg-warning">

            <h3 class="mb-0 text-dark"><i class="fa-solid fa-pen-to-square me-2"></i> Cập nhật phòng</h3>

        </div>

        <div class="card-body">

            <form action="${pageContext.request.contextPath}/room?action=update"
                  method="post">

                <input type="hidden"
                       name="roomID"
                       value="${room.roomID}">

                <div class="row">

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">Loại phòng</label>

                        <input type="number"
                               class="form-control"
                               name="categoryID"
                               value="${room.categoryID}"
                               required>

                    </div>

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">Số phòng</label>

                        <input type="text"
                               class="form-control"
                               name="roomNumber"
                               value="${room.roomNumber}"
                               required>

                    </div>

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">Tên phòng</label>

                        <input type="text"
                               class="form-control"
                               name="roomName"
                               value="${room.roomName}"
                               required>

                    </div>

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">Giá</label>

                        <input type="number"
                               class="form-control"
                               name="price"
                               value="${room.price}"
                               required>

                    </div>

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">Diện tích</label>

                        <input type="number"
                               step="0.1"
                               class="form-control"
                               name="acreage"
                               value="${room.acreage}"
                               required>

                    </div>

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">Số giường</label>

                        <input type="number"
                               class="form-control"
                               name="bed"
                               value="${room.bed}"
                               required>

                    </div>

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">Khu vực</label>

                        <input type="text"
                               class="form-control"
                               name="area"
                               value="${room.area}">

                    </div>

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">Trạng thái</label>

                        <select class="form-select"
                                name="status">

                            <option value="Available"
                                ${room.status=='Available'?'selected':''}>
                                Available
                            </option>

                            <option value="Occupied"
                                ${room.status=='Occupied'?'selected':''}>
                                Occupied
                            </option>

                            <option value="Maintenance"
                                ${room.status=='Maintenance'?'selected':''}>
                                Maintenance
                            </option>

                        </select>

                    </div>

                    <div class="col-12 mb-3">

                        <label class="form-label fw-bold">Mô tả</label>

                        <textarea class="form-control"
                                  rows="4"
                                  name="description">${room.description}</textarea>

                    </div>

                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/room"
                       class="btn btn-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                    </a>

                    <button class="btn btn-warning text-dark">
                        <i class="fa-solid fa-save me-1"></i> Cập nhật
                    </button>
                </div>

            </form>

        </div>

    </div>

</div>

<jsp:include page="../layout/footer.jsp"/>

</body>

</html>