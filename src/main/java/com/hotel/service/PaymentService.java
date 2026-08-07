package com.hotel.service;

import com.hotel.dao.PaymentDAO;
import com.hotel.model.Payment;

import java.util.List;

public class PaymentService {

    private final PaymentDAO paymentDAO = new PaymentDAO();

    public List<Payment> getAllPayments() {
        return paymentDAO.getAll();
    }

    public Payment getPaymentById(int id) {
        return paymentDAO.getById(id);
    }

    public boolean addPayment(Payment payment) {
        return paymentDAO.insert(payment);
    }

    public boolean updatePayment(Payment payment) {
        return paymentDAO.update(payment);
    }

    public boolean deletePayment(int id) {
        return paymentDAO.delete(id);
    }

    public List<Payment> getPaymentsByBookingId(int bookingId) {
        return paymentDAO.getByBookingId(bookingId);
    }
}
