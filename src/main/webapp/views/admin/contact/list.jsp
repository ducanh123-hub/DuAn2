<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Liên hệ - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="bg-light">

<jsp:include page="../../layout/header.jsp"/>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-3 col-lg-2">
            <jsp:include page="../../layout/sidebar.jsp"/>
        </div>
        <div class="col-md-9 col-lg-10">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold"><i class="fa-solid fa-envelope-open-text me-2 text-warning"></i> Quản lý Liên hệ</h3>
            </div>

            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-circle-check me-2"></i> ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-triangle-exclamation me-2"></i> ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0 text-nowrap">
                            <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Ngày gửi</th>
                                <th>Họ tên</th>
                                <th>Tiêu đề</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="contact" items="${contactList}">
                                <tr>
                                    <td>#${contact.contactID}</td>
                                    <td><fmt:formatDate value="${contact.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>
                                        <strong>${contact.fullName}</strong><br>
                                        <small class="text-muted"><i class="fa-solid fa-envelope me-1"></i> ${contact.email}</small><br>
                                        <small class="text-muted"><i class="fa-solid fa-phone me-1"></i> ${contact.phone != null ? contact.phone : 'Không có'}</small>
                                    </td>
                                    <td>${contact.subject}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${contact.status == 'Đã xử lý'}">
                                                <span class="badge bg-success"><i class="fa-solid fa-check me-1"></i> Đã xử lý</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark"><i class="fa-solid fa-clock me-1"></i> Chưa xử lý</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#contactModal${contact.contactID}">
                                            <i class="fa-solid fa-eye"></i> Xem chi tiết
                                        </button>
                                        <c:if test="${contact.status == 'Chưa xử lý'}">
                                            <form action="${pageContext.request.contextPath}/admin/contact/update-status" method="post" class="d-inline">
                                                <input type="hidden" name="contactID" value="${contact.contactID}">
                                                <input type="hidden" name="status" value="Đã xử lý">
                                                <button type="submit" class="btn btn-sm btn-success" onclick="return confirm('Xác nhận đã xử lý liên hệ này?');">
                                                    <i class="fa-solid fa-check"></i> Đánh dấu đã xử lý
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>

                                <!-- Modal Chi tiết Liên hệ -->
                                <div class="modal fade" id="contactModal${contact.contactID}" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header bg-dark text-white">
                                                <h5 class="modal-title"><i class="fa-solid fa-envelope-open-text me-2"></i> Chi tiết liên hệ #${contact.contactID}</h5>
                                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <p class="mb-1"><strong>Người gửi:</strong> ${contact.fullName}</p>
                                                        <p class="mb-1"><strong>Email:</strong> ${contact.email}</p>
                                                        <p class="mb-1"><strong>SĐT:</strong> ${contact.phone != null ? contact.phone : 'Không có'}</p>
                                                    </div>
                                                    <div class="col-md-6 text-md-end">
                                                        <p class="mb-1"><strong>Ngày gửi:</strong> <fmt:formatDate value="${contact.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/></p>
                                                        <p class="mb-1"><strong>Trạng thái:</strong> 
                                                            <c:choose>
                                                                <c:when test="${contact.status == 'Đã xử lý'}"><span class="badge bg-success">Đã xử lý</span></c:when>
                                                                <c:otherwise><span class="badge bg-warning text-dark">Chưa xử lý</span></c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <h6 class="fw-bold">Tiêu đề: ${contact.subject}</h6>
                                                <div class="p-3 bg-light rounded border mt-3" style="min-height: 100px; white-space: pre-wrap;">${contact.message}</div>
                                            </div>
                                            <div class="modal-footer">
                                                <c:if test="${contact.status == 'Chưa xử lý'}">
                                                    <form action="${pageContext.request.contextPath}/admin/contact/update-status" method="post" class="d-inline">
                                                        <input type="hidden" name="contactID" value="${contact.contactID}">
                                                        <input type="hidden" name="status" value="Đã xử lý">
                                                        <button type="submit" class="btn btn-success">Đánh dấu đã xử lý</button>
                                                    </form>
                                                </c:if>
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty contactList}">
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">Không có liên hệ nào.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
