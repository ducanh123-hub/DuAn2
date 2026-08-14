<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết bình luận - Luxury Hotel</title>
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
                <div>
                    <h3 class="fw-bold text-primary mb-1">
                        <i class="fa-solid fa-comment-dots me-2"></i>Chi tiết bình luận #${review.reviewID}
                    </h3>
                </div>
                <a href="${pageContext.request.contextPath}/review?action=admin-list"
                   class="btn btn-outline-secondary">
                    <i class="fa-solid fa-arrow-left me-1"></i>Quay lại
                </a>
            </div>

            <div class="card shadow border-0 mb-4">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="mb-0">Thông tin bình luận</h5>
                </div>
                <div class="card-body p-4">
                    <div class="mb-3">
                        <label class="fw-bold text-muted">Khách hàng:</label>
                        <div class="fs-5">${review.customerName}</div>
                    </div>
                    <div class="mb-3">
                        <label class="fw-bold text-muted">Phòng:</label>
                        <div><span class="badge bg-secondary">${review.roomNumber}</span> ${review.roomName}</div>
                    </div>
                    <div class="mb-3">
                        <label class="fw-bold text-muted">Đánh giá:</label>
                        <div class="text-warning fs-5">
                            <c:forEach begin="1" end="${review.rating}">★</c:forEach> (${review.rating}/5)
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="fw-bold text-muted">Nội dung bình luận:</label>
                        <div class="p-3 bg-light border rounded fs-6">${review.comment}</div>
                    </div>

                    <!-- Phản hồi hiện tại nếu có -->
                    <c:if test="${not empty review.reply}">
                        <div class="mb-3">
                            <label class="fw-bold text-primary">Phản hồi của quản lý (${review.replyAt}):</label>
                            <div class="p-3 bg-primary bg-opacity-10 border border-primary rounded">${review.reply}</div>
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/review" class="mt-4">
                        <input type="hidden" name="action" value="reply">
                        <input type="hidden" name="reviewId" value="${review.reviewID}">
                        <div class="mb-3">
                            <label class="form-label fw-bold text-dark">
                                <i class="fa-solid fa-reply me-1"></i>Phản hồi bình luận này:
                            </label>
                            <textarea name="reply" class="form-control" rows="3"
                                      placeholder="Nhập câu trả lời cho khách hàng..." required>${review.reply}</textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-paper-plane me-1"></i>Gửi phản hồi
                        </button>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
