<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giới thiệu - Luxury Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .about-header {
            background: linear-gradient(rgba(12, 26, 48, 0.8), rgba(12, 26, 48, 0.85)), url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1200&q=80') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 100px 0;
            text-align: center;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="../layout/header.jsp"/>

<!-- About Banner -->
<div class="about-header mb-5">
    <div class="container">
        <h1 class="fw-bold display-4">GIỚI THIỆU VỀ LUXURY HOTEL</h1>
        <p class="fs-5 text-warning mb-0">Hơn cả một nơi nghỉ dưỡng – Đó là hành trình trải nghiệm phong cách hoàng gia</p>
    </div>
</div>

<div class="container my-5">
    <div class="row align-items-center mb-5">
        <div class="col-md-6 mb-4 mb-md-0">
            <h2 class="fw-bold text-primary mb-3">Lịch Sử Hình Thành</h2>
            <p class="text-muted leading-relaxed">
                Được thành lập vào năm 2018, Luxury Hotel tự hào là một trong những biểu tượng nghỉ dưỡng hàng đầu tại Việt Nam. Tọa lạc tại các vị trí đắc địa nhất, chúng tôi không ngừng cải tiến dịch vụ và không gian kiến trúc để đem đến cho quý khách sự thư thái và thăng hoa nhất trong suốt kỳ lưu trú.
            </p>
            <p class="text-muted leading-relaxed">
                Mỗi chi tiết thiết kế tại Luxury Hotel đều được chăm chút tỉ mỉ từ những phiến đá cẩm thạch cho đến hệ thống chiếu sáng thông minh. Chúng tôi tin rằng sự tinh tế luôn nằm trong từng trải nghiệm nhỏ nhất của quý khách.
            </p>
        </div>
        <div class="col-md-6 text-center">
            <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=600&q=80" class="img-fluid rounded shadow-lg" alt="Lịch sử Luxury Hotel">
        </div>
    </div>

    <!-- Vision, Mission & Values -->
    <div class="row g-4 text-center mb-5">
        <div class="col-md-4">
            <div class="card p-4 shadow-sm h-100 border">
                <i class="fa-solid fa-eye text-warning fs-1 mb-3"></i>
                <h4 class="fw-bold text-primary">Tầm Nhìn</h4>
                <p class="text-muted mb-0">Trở thành chuỗi thương hiệu khách sạn nghỉ dưỡng 5 sao sang trọng hàng đầu khu vực, là lựa chọn số một của du khách trong và ngoài nước.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card p-4 shadow-sm h-100 border">
                <i class="fa-solid fa-bullseye text-warning fs-1 mb-3"></i>
                <h4 class="fw-bold text-primary">Sứ Mệnh</h4>
                <p class="text-muted mb-0">Kiến tạo không gian nghỉ dưỡng tuyệt mỹ, cung cấp dịch vụ tận tâm và chuẩn mực nhằm mang lại sự hài lòng vượt bậc cho khách hàng.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card p-4 shadow-sm h-100 border">
                <i class="fa-solid fa-gem text-warning fs-1 mb-3"></i>
                <h4 class="fw-bold text-primary">Giá Trị Cốt Lõi</h4>
                <p class="text-muted mb-0">Sự sang trọng tinh tế, dịch vụ chu đáo tận tâm, tính chuyên nghiệp cao và luôn mang lại các giá trị bền vững cho cộng đồng.</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
