package com.hotel.service;

import com.hotel.dao.BookingDAO;
import com.hotel.dao.RoomDAO;
import com.hotel.model.Booking;

import java.util.List;

public class BookingService {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    public List<Booking> getAllBookings() {
        return bookingDAO.getAll();
    }

    public Booking getBookingById(int id) {
        return bookingDAO.getById(id);
    }

    public boolean addBooking(Booking booking) {
        return bookingDAO.insert(booking);
    }

    public boolean updateBooking(Booking booking) {
        return bookingDAO.update(booking);
    }

    public boolean deleteBooking(int id) {
        return bookingDAO.delete(id);
    }

}