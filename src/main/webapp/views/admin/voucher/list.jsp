<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Quản lý Voucher - Luxury Hotel</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Font Awesome -->
    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <!-- CSS chung -->
    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>

        /* =====================================================
           CARD
           ===================================================== */

        .card {
            border-radius: 12px;
            overflow: hidden;
        }


        /* =====================================================
           BADGE TRẠNG THÁI
           ===================================================== */

        .badge-status {
            font-size: 13px;
            padding: 6px 12px;
        }


        /* =====================================================
           MÃ VOUCHER
           ===================================================== */

        .voucher-code {
            font-family: monospace;
            font-weight: 700;
            letter-spacing: 1px;
            color: #dc3545;
        }


        /* =====================================================
           BẢNG
           ===================================================== */

        table th {
            white-space: nowrap;
        }

    </style>

</head>


<body class="bg-light">


<!-- =====================================================
     HEADER
     ===================================================== -->

<jsp:include page="../../layout/header.jsp"/>


<div class="container mt-5 mb-5">

    <div class="row justify-content-center">

        <div class="col-lg-11">

            <div class="card shadow border-0">


                <!-- =================================================
                     HEADER CARD
                     ================================================= -->

                <div
                    class="card-header bg-dark text-white py-3 d-flex justify-content-between align-items-center">

                    <h4 class="mb-0">

                        <i class="fa-solid fa-ticket me-2"></i>

                        Quản lý Voucher

                    </h4>


                    <a
                        href="${pageContext.request.contextPath}/voucher?action=add"
                        class="btn btn-warning fw-bold">

                        <i class="fa-solid fa-plus me-1"></i>

                        Thêm voucher

                    </a>

                </div>


                <div class="card-body p-4">


                    <!-- =================================================
                         THÔNG BÁO THÀNH CÔNG
                         ================================================= -->

                    <c:if test="${param.success == 'add'}">

                        <div class="alert alert-success">

                            <i class="fa-solid fa-circle-check me-2"></i>

                            Thêm voucher thành công!

                        </div>

                    </c:if>


                    <c:if test="${param.success == 'update'}">

                        <div class="alert alert-success">

                            <i class="fa-solid fa-circle-check me-2"></i>

                            Cập nhật voucher thành công!

                        </div>

                    </c:if>


                    <c:if test="${param.success == 'delete'}">

                        <div class="alert alert-success">

                            <i class="fa-solid fa-circle-check me-2"></i>

                            Đã vô hiệu hóa voucher!

                        </div>

                    </c:if>


                    <!-- =================================================
                         BẢNG DANH SÁCH
                         ================================================= -->

                    <div class="table-responsive">

                        <table class="table table-hover align-middle">

                            <thead class="table-dark">

                                <tr>

                                    <th>#</th>
                                    <th>Mã</th>
                                    <th>Tên chương trình</th>
                                    <th>Loại giảm</th>
                                    <th>Giá trị</th>
                                    <th>Đơn tối thiểu</th>
                                    <th>Giảm tối đa</th>
                                    <th>Đã dùng / Giới hạn</th>
                                    <th>Hiệu lực</th>
                                    <th>Trạng thái</th>
                                    <th class="text-center">Thao tác</th>

                                </tr>

                            </thead>


                            <tbody>


                                <c:forEach
                                    items="${voucherList}"
                                    var="v"
                                    varStatus="loop">

                                    <tr>

                                        <td>${loop.index + 1}</td>


                                        <td>

                                            <span class="voucher-code">

                                                ${v.code}

                                            </span>

                                        </td>


                                        <td>${v.name}</td>


                                        <td>

                                            <c:choose>

                                                <c:when test="${v.discountType == 'Percentage'}">

                                                    <span class="badge bg-info text-dark">

                                                        Phần trăm

                                                    </span>

                                                </c:when>

                                                <c:otherwise>

                                                    <span class="badge bg-secondary">

                                                        Số tiền cố định

                                                    </span>

                                                </c:otherwise>

                                            </c:choose>

                                        </td>


                                        <td>

                                            <c:choose>

                                                <c:when test="${v.discountType == 'Percentage'}">

                                                    ${v.discountValue}%

                                                </c:when>

                                                <c:otherwise>

                                                    <fmt:formatNumber
                                                        value="${v.discountValue}"
                                                        type="number"
                                                        groupingUsed="true"
                                                        maxFractionDigits="0"/>

                                                    VNĐ

                                                </c:otherwise>

                                            </c:choose>

                                        </td>


                                        <td>

                                            <c:if test="${v.minOrderAmount != null}">

                                                <fmt:formatNumber
                                                    value="${v.minOrderAmount}"
                                                    type="number"
                                                    groupingUsed="true"
                                                    maxFractionDigits="0"/>

                                                VNĐ

                                            </c:if>

                                        </td>


                                        <td>

                                            <c:choose>

                                                <c:when test="${v.maxDiscountAmount != null}">

                                                    <fmt:formatNumber
                                                        value="${v.maxDiscountAmount}"
                                                        type="number"
                                                        groupingUsed="true"
                                                        maxFractionDigits="0"/>

                                                    VNĐ

                                                </c:when>

                                                <c:otherwise>

                                                    <span class="text-muted">Không giới hạn</span>

                                                </c:otherwise>

                                            </c:choose>

                                        </td>


                                        <td>

                                            ${v.usedCount} /

                                            <c:choose>

                                                <c:when test="${v.usageLimit != null}">

                                                    ${v.usageLimit}

                                                </c:when>

                                                <c:otherwise>

                                                    <span class="text-muted">∞</span>

                                                </c:otherwise>

                                            </c:choose>

                                        </td>


                                        <td>

                                            <fmt:formatDate
                                                value="${v.startDate}"
                                                pattern="dd/MM/yyyy"/>

                                            &ndash;

                                            <fmt:formatDate
                                                value="${v.endDate}"
                                                pattern="dd/MM/yyyy"/>

                                        </td>


                                        <td>

                                            <c:choose>

                                                <c:when test="${v.status == 'Active'}">

                                                    <span
                                                        class="badge bg-success badge-status">

                                                        Đang hoạt động

                                                    </span>

                                                </c:when>

                                                <c:otherwise>

                                                    <span
                                                        class="badge bg-secondary badge-status">

                                                        Vô hiệu hóa

                                                    </span>

                                                </c:otherwise>

                                            </c:choose>

                                        </td>


                                        <td class="text-center">

                                            <a
                                                href="${pageContext.request.contextPath}/voucher?action=edit&id=${v.promotionID}"
                                                class="btn btn-outline-primary btn-sm"
                                                title="Sửa">

                                                <i class="fa-solid fa-pen"></i>

                                            </a>


                                            <c:if test="${v.status == 'Active'}">

                                                <a
                                                    href="${pageContext.request.contextPath}/voucher?action=delete&id=${v.promotionID}"
                                                    class="btn btn-outline-danger btn-sm"
                                                    title="Vô hiệu hóa"
                                                    onclick="return confirm('Vô hiệu hóa voucher \'${v.code}\'?');">

                                                    <i class="fa-solid fa-ban"></i>

                                                </a>

                                            </c:if>

                                        </td>

                                    </tr>

                                </c:forEach>


                                <c:if test="${empty voucherList}">

                                    <tr>

                                        <td
                                            colspan="11"
                                            class="text-center text-muted py-4">

                                            Chưa có voucher nào.

                                        </td>

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


<!-- =====================================================
     FOOTER
     ===================================================== -->

<jsp:include page="../../layout/footer.jsp"/>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>
