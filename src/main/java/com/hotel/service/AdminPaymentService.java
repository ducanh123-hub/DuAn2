package com.hotel.service;

import com.hotel.config.DBConnect;
import com.hotel.dao.PaymentDAO;
import com.hotel.model.Payment;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Service xử lý nghiệp vụ Quản lý thanh toán.
 * Xác nhận, hoàn tiền, xem lịch sử giao dịch.
 */
public class AdminPaymentService {

    private final PaymentDAO paymentDAO = new PaymentDAO();

    public List<Payment> getAll() {
        return paymentDAO.getAll();
    }

    public Payment getById(int id) {
        return paymentDAO.getById(id);
    }

    public List<Payment> getByBookingId(int bookingId) {
        return paymentDAO.getByBookingId(bookingId);
    }

    /**
     * Xác nhận thanh toán (chuyển trạng thái sang "Đã thanh toán")
     * @return null nếu OK, chuỗi lỗi nếu thất bại
     */
    public String confirmPayment(int paymentId) {
        Payment payment = paymentDAO.getById(paymentId);
        if (payment == null) return "Không tìm thấy giao dịch!";
        if ("Đã thanh toán".equals(payment.getPaymentStatus())) {
            return "Giao dịch này đã được thanh toán trước đó!";
        }
        payment.setPaymentStatus("Đã thanh toán");
        payment.setPaidAmount(payment.getAmount());
        boolean ok = paymentDAO.update(payment);
        return ok ? null : "Xác nhận thanh toán thất bại!";
    }

    /**
     * Xử lý hoàn tiền theo chính sách
     * @param paymentId ID giao dịch cần hoàn
     * @param refundReason Lý do hoàn tiền
     * @return null nếu OK, chuỗi lỗi nếu thất bại
     */
    public String processRefund(int paymentId, String refundReason) {
        Payment payment = paymentDAO.getById(paymentId);
        if (payment == null) return "Không tìm thấy giao dịch!";
        if (!"Đã thanh toán".equals(payment.getPaymentStatus())) {
            return "Chỉ có thể hoàn tiền cho giao dịch đã thanh toán!";
        }
        payment.setPaymentStatus("Đã hoàn tiền");
        payment.setRefundAmount(payment.getAmount());
        payment.setRefundReason(refundReason);
        payment.setRefunda(true);
        boolean ok = paymentDAO.update(payment);
        return ok ? null : "Xử lý hoàn tiền thất bại!";
    }

    /**
     * Tính tổng doanh thu (các giao dịch đã thanh toán)
     */
    public BigDecimal getTotalRevenue() {
        String sql = """
            SELECT COALESCE(SUM(Amount), 0) FROM Payment
            WHERE Status = N'Đã thanh toán'
            """;
        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
}
