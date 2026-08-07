<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kết quả tìm kiếm phòng - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/room.css">
    <style>
        .search-hero {
            background: linear-gradient(rgba(12, 26, 48, 0.85), rgba(12, 26, 48, 0.9)), url('https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=1200&q=80') no-repeat center center;
            background-size: cover;
            color: white;
            padding: 60px 0;
            text-align: center;
            border-bottom: 4px solid var(--accent-color);
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<!-- Search Hero Banner -->
<div class="search-hero text-white mb-5">
    <div class="container">
        <h2 class="fw-bold mb-2">KẾT QUẢ TÌM KIẾM PHÒNG</h2>
        <p class="text-warning mb-4">Tìm thấy những lựa chọn tối ưu nhất cho kỳ nghỉ của bạn</p>
        
        <!-- Search bar inside hero -->
        <div class="max-width-600 mx-auto" style="max-width: 600px;">
            <form action="${pageContext.request.contextPath}/room" method="get">
                <input type="hidden" name="action" value="search">
                <div class="input-group shadow">
                    <input type="text" name="keyword" class="form-control py-3 border-0" placeholder="Nhập tên phòng hoặc số phòng cần tìm..." value="${param.keyword}">
                    <button type="submit" class="btn btn-warning text-dark fw-bold px-4">
                        <i class="fa-solid fa-magnifying-glass me-1"></i> Tìm kiếm
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="container my-5">
    <div class="row">
        <!-- Room Listing Grid -->
        <c:forEach items="${list}" var="room">
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm border-0 transition-hover">
                    <div class="position-relative">
                        <!-- Standard fallback image -->
                        <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80" 
                             class="card-img-top" 
                             alt="${room.roomName}"
                             onerror="this.src='https://placehold.co/600x400?text=Luxury+Room';">
                        <span class="position-absolute top-0 end-0 bg-dark text-warning fw-bold px-3 py-2 m-3 rounded shadow small">
                            ${room.status == 'Available' ? 'Còn trống' : (room.status == 'Occupied' ? 'Đang ở' : 'Bảo trì')}
                        </span>
                    </div>
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h5 class="card-title fw-bold text-primary mb-0">${room.roomName}</h5>
                            <span class="badge bg-secondary">P. ${room.roomNumber}</span>
                        </div>
                        
                        <p class="card-text text-muted flex-grow-1 small mt-2">
                            ${room.description != null ? room.description : 'Đầy đủ tiện nghi hiện đại, không gian thoáng đãng mang đến sự thoải mái tối đa.'}
                        </p>

                        <!-- Room specs badges -->
                        <div class="d-flex gap-2 mb-3 mt-2 flex-wrap">
                            <span class="badge bg-light text-dark border"><i class="fa-solid fa-expand text-muted me-1"></i>${room.acreage} m²</span>
                            <span class="badge bg-light text-dark border"><i class="fa-solid fa-bed text-muted me-1"></i>${room.bed} Giường</span>
                            <span class="badge bg-light text-dark border"><i class="fa-solid fa-location-dot text-muted me-1"></i>${room.area}</span>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center mt-3 pt-3 border-top">
                            <div>
                                <small class="text-muted d-block small">Giá phòng / Đêm</small>
                                <span class="fs-5 text-danger fw-bold">${room.price} VNĐ</span>
                            </div>
                            <div class="d-flex gap-1">
                                <a href="${pageContext.request.contextPath}/room?action=detail&id=${room.roomID}" 
                                   class="btn btn-outline-primary btn-sm px-3">
                                    <i class="fa-solid fa-eye"></i> Chi tiết
                                </a>
                                <c:if test="${room.status == 'Available'}">
                                    <a href="${pageContext.request.contextPath}/booking?roomId=${room.roomID}" 
                                       class="btn btn-success btn-sm px-3">
                                        Đăt ngay
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- No Results Found -->
        <c:if test="${empty list}">
            <div class="col-12 text-center py-5">
                <div class="text-muted">
                    <i class="fa-solid fa-circle-question fa-3x mb-3 text-warning"></i>
                    <h4 class="fw-bold text-dark">Không tìm thấy phòng phù hợp</h4>
                    <p class="text-muted">Vui lòng thử tìm kiếm lại với từ khóa khác (ví dụ: Standard, Deluxe, Suite hoặc số phòng).</p>
                    <a href="${pageContext.request.contextPath}/room" class="btn btn-primary mt-3">
                        <i class="fa-solid fa-list-ul me-1"></i> Xem tất cả phòng
                    </a>
                </div>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>