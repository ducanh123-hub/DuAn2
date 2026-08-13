<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt phòng thành công - Luxury Hotel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #0c1a30, #162a4a);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .success-card {
            width: 100%;
            max-width: 560px;
            background: rgba(255, 255, 255, 0.97);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.4);
        }

        .success-header {
            background: linear-gradient(135deg, #0c1a30, #162a4a);
            padding: 50px 40px 40px;
            text-align: center;
        }

        .success-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: rgba(212, 175, 55, 0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }

        .success-icon i {
            font-size: 42px;
            color: #d4af37;
        }

        .success-header h2 {
            color: white;
            font-weight: 800;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .success-header p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 14px;
            margin-bottom: 4px;
        }

        .booking-code {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 24px;
            border: 1px dashed #d4af37;
            border-radius: 30px;
            color: #d4af37;
            font-weight: 700;
            font-size: 20px;
            letter-spacing: 2px;
        }

        .success-body {
            padding: 40px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 0;
            border-bottom: 1px solid #eef1f5;
        }

        .info-row:last-of-type {
            border-bottom: none;
        }

        .info-label {
            color: #7a828e;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-label i {
            color: #d4af37;
            width: 18px;
            text-align: center;
        }

        .info-value {
            color: #10213d;
            font-weight: 600;
            font-size: 15px;
            text-align: right;
        }

        .info-value.price {
            color: #d4af37;
            font-size: 17px;
            font-weight: 800;
        }

        .action-buttons {
            display: flex;
            gap: 12px;
            margin-top: 30px;
        }

        .btn-outline-luxury {
            flex: 1;
            height: 48px;
            border-radius: 8px;
            border: 1.5px solid #10213d;
            color: #10213d;
            background: transparent;
            font-weight: 600;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-outline-luxury:hover {
            background: #10213d;
            color: white;
        }

        .btn-fill-luxury {
            flex: 1;
            height: 48px;
            border-radius: 8px;
            border: none;
            background: linear-gradient(135deg, #0c1a30, #162a4a);
            color: white;
            font-weight: 700;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-fill-luxury:hover {
            background: linear-gradient(135deg, #162a4a, #213f6f);
            color: white;
            box-shadow: 0 4px 15px rgba(22, 42, 74, 0.4);
        }

        @media (max-width: 576px) {
            body {
                padding: 15px;
            }

            .success-header {
                padding: 40px 24px 30px;
            }

            .success-body {
                padding: 28px 24px;
            }

            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<div class="success-card">

    <div class="success-header">
        <div class="success-icon">
            <i class="fa-solid fa-check"></i>
        </div>
        <h2>Đặt phòng thành công!</h2>
        <p>Mã đơn của bạn</p>
        <div class="booking-code">${booking.bookingCode}</div>
    </div>

    <div class="success-body">

        <div class="info-row">
            <span class="info-label"><i class="fa-solid fa-door-open"></i> Phòng</span>
            <span class="info-value">${booking.roomName} (Phòng ${booking.roomNumber})</span>
        </div>

        <div class="info-row">
            <span class="info-label"><i class="fa-solid fa-calendar-check"></i> Nhận phòng</span>
            <span class="info-value">${booking.checkInDate}</span>
        </div>

        <div class="info-row">
            <span class="info-label"><i class="fa-solid fa-calendar-xmark"></i> Trả phòng</span>
            <span class="info-value">${booking.checkOutDate}</span>
        </div>

        <div class="info-row">
            <span class="info-label"><i class="fa-solid fa-coins"></i> Tổng tiền</span>
            <span class="info-value price">${booking.finalAmount} VNĐ</span>
        </div>

        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/booking?action=history" class="btn-outline-luxury">
                <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử đặt phòng
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn-fill-luxury">
                Về trang chủ
            </a>
        </div>

    </div>

</div>

</body>
</html>