package com.hotel.service;

import com.hotel.dao.BookingDAO;
import com.hotel.dao.RoomDAO;
import com.hotel.model.Booking;

import java.sql.Date;
import java.util.List;

public class BookingService {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    // =====================================================
    // GET ALL BOOKINGS
    // =====================================================

    public List<Booking> getAllBookings() {
        return bookingDAO.getAll();
    }


    // =====================================================
    // GET BOOKING BY ID
    // =====================================================

    public Booking getBookingById(int id) {
        return bookingDAO.getById(id);
    }


    // =====================================================
    // ADD BOOKING
    // =====================================================

    public boolean addBooking(Booking booking) {

        return bookingDAO.insert(booking);
    }


    // =====================================================
    // UPDATE BOOKING
    // =====================================================

    public boolean updateBooking(Booking booking) {

        return bookingDAO.update(booking);
    }


    // =====================================================
    // DELETE BOOKING
    // =====================================================

    public boolean deleteBooking(int id) {

        return bookingDAO.delete(id);
    }


    // =====================================================
    // GET BOOKINGS BY USER
    // =====================================================

    public List<Booking> getBookingsByUserId(int userId) {

        return bookingDAO.getByUserId(userId);
    }


    // =====================================================
    // KIỂM TRA PHÒNG CÓ THỂ ĐẶT
    // =====================================================

    public boolean isRoomAvailable(
            int roomId,
            Date checkIn,
            Date checkOut
    ) {

        // Kiểm tra ngày hợp lệ
        if (checkIn == null || checkOut == null) {
            return false;
        }

        // Check-out phải sau check-in
        if (!checkOut.after(checkIn)) {
            return false;
        }

        // Kiểm tra booking bị trùng
        return bookingDAO.isRoomAvailable(
                roomId,
                checkIn,
                checkOut
        );
    }

    public Booking getByBookingCode(String bookingCode) {
        return bookingDAO.getByBookingCode(bookingCode);
    }
}