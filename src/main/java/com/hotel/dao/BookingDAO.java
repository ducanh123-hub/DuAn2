package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO implements BaseDAO<Booking> {

    // =========================================================
    // MAP RESULTSET -> BOOKING
    // =========================================================

    private Booking mapRow(ResultSet rs) throws SQLException {

        Booking b = new Booking();

        b.setBookingID(rs.getInt("BookingID"));
        b.setUserID(rs.getInt("UserID"));

        int vId = rs.getInt("VoucherID");

        b.setVoucherID(
                rs.wasNull() ? null : vId
        );

        b.setBookingCode(
                rs.getString("BookingCode")
        );

        b.setBookingDate(
                rs.getTimestamp("BookingDate")
        );

        b.setCheckInDate(
                rs.getDate("CheckinDate")
        );

        b.setCheckOutDate(
                rs.getDate("CheckoutDate")
        );

        b.setGuestCount(
                rs.getInt("GuestCount")
        );

        b.setTotalAmount(
                rs.getBigDecimal("TotalAmount")
        );

        b.setDiscountAmount(
                rs.getBigDecimal("DiscountAmount")
        );

        b.setFinalAmount(
                rs.getBigDecimal("FinalAmount")
        );

        b.setCancelReason(
                rs.getString("CancelReason")
        );

        b.setCancelDate(
                rs.getTimestamp("CancelDate")
        );

        b.setStatus(
                rs.getString("Status")
        );

        b.setNote(
                rs.getString("Note")
        );

        b.setCreatedAt(
                rs.getTimestamp("CreatedAt")
        );

        b.setUpdatedAt(
                rs.getTimestamp("UpdatedAt")
        );


        // =====================================================
        // FIELD PHỤ TỪ JOIN
        // =====================================================

        try {

            b.setRoomID(
                    rs.getInt("RoomID")
            );

        } catch (SQLException ignored) {
        }


        try {

            b.setRoomName(
                    rs.getString("RoomName")
            );

        } catch (SQLException ignored) {
        }


        try {

            b.setRoomNumber(
                    rs.getString("RoomNumber")
            );

        } catch (SQLException ignored) {
        }


        try {

            b.setRoomPrice(
                    rs.getBigDecimal("RoomPrice")
            );

        } catch (SQLException ignored) {
        }


        try {

            b.setCustomerName(
                    rs.getString("CustomerName")
            );

        } catch (SQLException ignored) {
        }


        try {

            b.setCustomerPhone(
                    rs.getString("CustomerPhone")
            );

        } catch (SQLException ignored) {
        }


        try {

            b.setCustomerEmail(
                    rs.getString("CustomerEmail")
            );

        } catch (SQLException ignored) {
        }


        return b;
    }


    // =========================================================
    // GET ALL
    // =========================================================

    @Override
    public List<Booking> getAll() {

        List<Booking> list =
                new ArrayList<>();


        String sql = """
                SELECT
                    b.*,
                    bd.RoomID,
                    bd.Price AS RoomPrice,
                    r.RoomName,
                    r.RoomNumber,
                    u.FullName AS CustomerName,
                    u.Phone AS CustomerPhone,
                    u.Email AS CustomerEmail

                FROM Booking b

                LEFT JOIN Booking_Detail bd
                    ON b.BookingID = bd.BookingID

                LEFT JOIN Room r
                    ON bd.RoomID = r.RoomID

                LEFT JOIN [User] u
                    ON b.UserID = u.UserID

                ORDER BY b.CreatedAt DESC
                """;


        try (
                Connection con =
                        DBConnect.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                list.add(
                        mapRow(rs)
                );

            }

        } catch (Exception e) {

            e.printStackTrace();

        }


        return list;
    }


    // =========================================================
    // GET BY ID
    // =========================================================

    @Override
    public Booking getById(int id) {

        String sql = """
                SELECT
                    b.*,
                    bd.RoomID,
                    bd.Price AS RoomPrice,
                    r.RoomName,
                    r.RoomNumber,
                    u.FullName AS CustomerName,
                    u.Phone AS CustomerPhone,
                    u.Email AS CustomerEmail

                FROM Booking b

                LEFT JOIN Booking_Detail bd
                    ON b.BookingID = bd.BookingID

                LEFT JOIN Room r
                    ON bd.RoomID = r.RoomID

                LEFT JOIN [User] u
                    ON b.UserID = u.UserID

                WHERE b.BookingID = ?
                """;


        try (
                Connection con =
                        DBConnect.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return mapRow(rs);

                }

            }

        } catch (Exception e) {

            e.printStackTrace();

        }


        return null;
    }


    // =========================================================
    // INSERT BOOKING
    //
    // ĐẶT PHÒNG THÀNH CÔNG:
    //
    // Booking
    //      ↓
    // Booking_Detail
    //      ↓
    // Room.Status = "Đang có khách"
    //
    // Tất cả thực hiện trong cùng một transaction.
    // =========================================================

    @Override
    public boolean insert(Booking booking) {

        String sqlBooking = """
                INSERT INTO Booking
                (
                    UserID,
                    VoucherID,
                    BookingCode,
                    CheckinDate,
                    CheckoutDate,
                    GuestCount,
                    TotalAmount,
                    DiscountAmount,
                    FinalAmount,
                    Status,
                    Note
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;


        String sqlDetail = """
                INSERT INTO Booking_Detail
                (
                    BookingID,
                    RoomID,
                    Price,
                    Quantity,
                    Discount,
                    TotalPrice
                )
                VALUES (?, ?, ?, 1, 0, ?)
                """;


        // Sau khi đặt thành công:
        // chuyển phòng thành đang có khách
        String sqlRoom = """
                UPDATE Room
                SET
                    Status = N'Đang có khách',
                    UpdatedAt = GETDATE()
                WHERE RoomID = ?
                """;


        try (
                Connection con =
                        DBConnect.getConnection()
        ) {

            con.setAutoCommit(false);


            try (
                    PreparedStatement psBooking =
                            con.prepareStatement(
                                    sqlBooking,
                                    Statement.RETURN_GENERATED_KEYS
                            )
            ) {

                // =================================================
                // INSERT BOOKING
                // =================================================

                psBooking.setInt(
                        1,
                        booking.getUserID()
                );


                if (booking.getVoucherID() == null) {

                    psBooking.setNull(
                            2,
                            Types.INTEGER
                    );

                } else {

                    psBooking.setInt(
                            2,
                            booking.getVoucherID()
                    );

                }


                psBooking.setString(
                        3,
                        booking.getBookingCode()
                );


                psBooking.setDate(
                        4,
                        booking.getCheckInDate()
                );


                psBooking.setDate(
                        5,
                        booking.getCheckOutDate()
                );


                psBooking.setInt(
                        6,
                        booking.getGuestCount()
                );


                psBooking.setBigDecimal(
                        7,
                        booking.getTotalAmount()
                );


                psBooking.setBigDecimal(
                        8,
                        booking.getDiscountAmount()
                );


                psBooking.setBigDecimal(
                        9,
                        booking.getFinalAmount()
                );


                psBooking.setString(
                        10,
                        booking.getStatus()
                );


                psBooking.setString(
                        11,
                        booking.getNote()
                );


                int bookingResult =
                        psBooking.executeUpdate();


                if (bookingResult == 0) {

                    con.rollback();

                    return false;
                }


                // =================================================
                // LẤY BOOKING ID
                // =================================================

                int newBookingId;


                try (
                        ResultSet keys =
                                psBooking.getGeneratedKeys()
                ) {

                    if (!keys.next()) {

                        con.rollback();

                        return false;
                    }


                    newBookingId =
                            keys.getInt(1);
                }


                // =================================================
                // INSERT BOOKING DETAIL
                // =================================================

                try (
                        PreparedStatement psDetail =
                                con.prepareStatement(
                                        sqlDetail
                                )
                ) {

                    psDetail.setInt(
                            1,
                            newBookingId
                    );


                    psDetail.setInt(
                            2,
                            booking.getRoomID()
                    );


                    psDetail.setBigDecimal(
                            3,
                            booking.getRoomPrice()
                    );


                    psDetail.setBigDecimal(
                            4,
                            booking.getTotalAmount()
                    );


                    int detailResult =
                            psDetail.executeUpdate();


                    if (detailResult == 0) {

                        con.rollback();

                        return false;
                    }
                }


                // =================================================
                // CẬP NHẬT TRẠNG THÁI PHÒNG
                // =================================================

                try (
                        PreparedStatement psRoom =
                                con.prepareStatement(
                                        sqlRoom
                                )
                ) {

                    psRoom.setInt(
                            1,
                            booking.getRoomID()
                    );


                    int roomResult =
                            psRoom.executeUpdate();


                    if (roomResult == 0) {

                        con.rollback();

                        return false;
                    }
                }


                // =================================================
                // COMMIT
                // =================================================

                con.commit();

                return true;


            } catch (Exception e) {

                con.rollback();

                e.printStackTrace();

            } finally {

                con.setAutoCommit(true);

            }


        } catch (Exception e) {

            e.printStackTrace();

        }


        return false;
    }


    // =========================================================
    // UPDATE BOOKING
    //
    // Nếu Status = "Đã hủy"
    // → phòng trở lại "Còn trống"
    //
    // Nếu Status khác "Đã hủy"
    // → phòng "Đang có khách"
    // =========================================================

    @Override
    public boolean update(Booking booking) {

        String sqlBooking = """
                UPDATE Booking
                SET
                    CheckinDate = ?,
                    CheckoutDate = ?,
                    GuestCount = ?,
                    TotalAmount = ?,
                    DiscountAmount = ?,
                    FinalAmount = ?,
                    Status = ?,
                    Note = ?,
                    CancelReason = ?,
                    CancelDate = ?,
                    UpdatedAt = GETDATE()
                WHERE BookingID = ?
                """;


        String sqlRoomAvailable = """
                UPDATE Room
                SET
                    Status = N'Còn trống',
                    UpdatedAt = GETDATE()
                WHERE RoomID = ?
                """;


        String sqlRoomOccupied = """
                UPDATE Room
                SET
                    Status = N'Đang có khách',
                    UpdatedAt = GETDATE()
                WHERE RoomID = ?
                """;


        try (
                Connection con =
                        DBConnect.getConnection()
        ) {

            con.setAutoCommit(false);


            try (
                    PreparedStatement ps =
                            con.prepareStatement(
                                    sqlBooking
                            )
            ) {

                ps.setDate(
                        1,
                        booking.getCheckInDate()
                );


                ps.setDate(
                        2,
                        booking.getCheckOutDate()
                );


                ps.setInt(
                        3,
                        booking.getGuestCount()
                );


                ps.setBigDecimal(
                        4,
                        booking.getTotalAmount()
                );


                ps.setBigDecimal(
                        5,
                        booking.getDiscountAmount()
                );


                ps.setBigDecimal(
                        6,
                        booking.getFinalAmount()
                );


                ps.setString(
                        7,
                        booking.getStatus()
                );


                ps.setString(
                        8,
                        booking.getNote()
                );


                ps.setString(
                        9,
                        booking.getCancelReason()
                );


                ps.setTimestamp(
                        10,
                        booking.getCancelDate()
                );


                ps.setInt(
                        11,
                        booking.getBookingID()
                );


                int result =
                        ps.executeUpdate();


                if (result == 0) {

                    con.rollback();

                    return false;
                }


                // =================================================
                // LẤY ROOM ID CỦA BOOKING
                // =================================================

                Integer roomId =
                        getRoomIdByBookingId(
                                con,
                                booking.getBookingID()
                        );


                if (roomId != null) {

                    String roomSql;


                    if (
                            "Đã hủy".equals(
                                    booking.getStatus()
                            )
                    ) {

                        roomSql =
                                sqlRoomAvailable;

                    } else {

                        roomSql =
                                sqlRoomOccupied;

                    }


                    try (
                            PreparedStatement psRoom =
                                    con.prepareStatement(
                                            roomSql
                                    )
                    ) {

                        psRoom.setInt(
                                1,
                                roomId
                        );


                        psRoom.executeUpdate();

                    }

                }


                con.commit();

                return true;


            } catch (Exception e) {

                con.rollback();

                e.printStackTrace();

            } finally {

                con.setAutoCommit(true);

            }


        } catch (Exception e) {

            e.printStackTrace();

        }


        return false;
    }


    // =========================================================
    // DELETE
    //
    // Xóa booking:
    //
    // Booking_Detail
    //      ↓
    // Booking
    //      ↓
    // Room = Còn trống
    // =========================================================

    @Override
    public boolean delete(int id) {

        String sqlGetRoom = """
                SELECT RoomID
                FROM Booking_Detail
                WHERE BookingID = ?
                """;


        String sqlDetail = """
                DELETE FROM Booking_Detail
                WHERE BookingID = ?
                """;


        String sqlBooking = """
                DELETE FROM Booking
                WHERE BookingID = ?
                """;


        String sqlRoom = """
                UPDATE Room
                SET
                    Status = N'Còn trống',
                    UpdatedAt = GETDATE()
                WHERE RoomID = ?
                """;


        try (
                Connection con =
                        DBConnect.getConnection()
        ) {

            con.setAutoCommit(false);


            try {

                Integer roomId = null;


                // =================================================
                // LẤY ROOM ID
                // =================================================

                try (
                        PreparedStatement ps =
                                con.prepareStatement(
                                        sqlGetRoom
                                )
                ) {

                    ps.setInt(
                            1,
                            id
                    );


                    try (
                            ResultSet rs =
                                    ps.executeQuery()
                    ) {

                        if (rs.next()) {

                            roomId =
                                    rs.getInt(
                                            "RoomID"
                                    );
                        }
                    }
                }


                // =================================================
                // XÓA DETAIL
                // =================================================

                try (
                        PreparedStatement ps =
                                con.prepareStatement(
                                        sqlDetail
                                )
                ) {

                    ps.setInt(
                            1,
                            id
                    );

                    ps.executeUpdate();
                }


                // =================================================
                // XÓA BOOKING
                // =================================================

                try (
                        PreparedStatement ps =
                                con.prepareStatement(
                                        sqlBooking
                                )
                ) {

                    ps.setInt(
                            1,
                            id
                    );


                    ps.executeUpdate();
                }


                // =================================================
                // TRẢ PHÒNG VỀ CÒN TRỐNG
                // =================================================

                if (roomId != null) {

                    try (
                            PreparedStatement ps =
                                    con.prepareStatement(
                                            sqlRoom
                                    )
                    ) {

                        ps.setInt(
                                1,
                                roomId
                        );


                        ps.executeUpdate();
                    }
                }


                con.commit();

                return true;


            } catch (Exception e) {

                con.rollback();

                e.printStackTrace();

            } finally {

                con.setAutoCommit(true);

            }


        } catch (Exception e) {

            e.printStackTrace();

        }


        return false;
    }


    // =========================================================
    // GET BY USER ID
    // =========================================================

    public List<Booking> getByUserId(int userId) {

        List<Booking> list =
                new ArrayList<>();


        String sql = """
                SELECT
                    b.*,
                    bd.RoomID,
                    bd.Price AS RoomPrice,
                    r.RoomName,
                    r.RoomNumber,
                    u.FullName AS CustomerName,
                    u.Phone AS CustomerPhone,
                    u.Email AS CustomerEmail

                FROM Booking b

                LEFT JOIN Booking_Detail bd
                    ON b.BookingID = bd.BookingID

                LEFT JOIN Room r
                    ON bd.RoomID = r.RoomID

                LEFT JOIN [User] u
                    ON b.UserID = u.UserID

                WHERE b.UserID = ?

                ORDER BY b.CreatedAt DESC
                """;


        try (
                Connection con =
                        DBConnect.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    userId
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                while (rs.next()) {

                    list.add(
                            mapRow(rs)
                    );

                }

            }

        } catch (Exception e) {

            e.printStackTrace();

        }


        return list;
    }


    // =========================================================
    // KIỂM TRA PHÒNG CÓ TRỐNG THEO NGÀY
    //
    // Phòng được xem là bận nếu:
    //
    // Checkin < ngày trả mới
    // AND
    // Checkout > ngày nhận mới
    //
    // Booking "Đã hủy" không tính.
    // =========================================================

    public boolean isRoomAvailable(
            int roomId,
            Date checkIn,
            Date checkOut
    ) {

        String sql = """
                SELECT COUNT(*)
                FROM Booking b

                INNER JOIN Booking_Detail bd
                    ON b.BookingID = bd.BookingID

                WHERE bd.RoomID = ?

                  AND b.Status != N'Đã hủy'

                  AND b.CheckinDate < ?

                  AND b.CheckoutDate > ?
                """;


        try (
                Connection con =
                        DBConnect.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    roomId
            );


            ps.setDate(
                    2,
                    checkOut
            );


            ps.setDate(
                    3,
                    checkIn
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return rs.getInt(1) == 0;

                }

            }

        } catch (Exception e) {

            e.printStackTrace();

        }


        return false;
    }


    // =========================================================
    // LẤY ROOM ID TỪ BOOKING ID
    //
    // Dùng nội bộ trong update()
    // =========================================================

    private Integer getRoomIdByBookingId(
            Connection con,
            int bookingId
    ) throws SQLException {

        String sql = """
                SELECT RoomID
                FROM Booking_Detail
                WHERE BookingID = ?
                """;


        try (
                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    bookingId
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return rs.getInt(
                            "RoomID"
                    );

                }

            }
        }


        return null;
    }

    public Booking getByBookingCode(String bookingCode) {

        String sql = """
        SELECT
            b.BookingID, b.UserID, b.VoucherID, b.BookingCode,
            b.BookingDate, b.CheckInDate, b.CheckOutDate, b.GuestCount,
            b.TotalAmount, b.DiscountAmount, b.FinalAmount,
            b.CancelReason, b.CancelDate, b.Status, b.Note,
            b.CreatedAt, b.UpdatedAt,
            bd.RoomID, bd.Price AS RoomPrice,
            r.RoomName, r.RoomNumber
        FROM Booking b
        JOIN Booking_Detail bd ON bd.BookingID = b.BookingID
        JOIN Room r ON r.RoomID = bd.RoomID
        WHERE b.BookingCode = ?
        """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, bookingCode.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Booking booking = new Booking();

                    booking.setBookingID(rs.getInt("BookingID"));
                    booking.setUserID(rs.getInt("UserID"));

                    int voucherId = rs.getInt("VoucherID");
                    booking.setVoucherID(rs.wasNull() ? null : voucherId);

                    booking.setBookingCode(rs.getString("BookingCode"));
                    booking.setBookingDate(rs.getTimestamp("BookingDate"));
                    booking.setCheckInDate(rs.getDate("CheckInDate"));
                    booking.setCheckOutDate(rs.getDate("CheckOutDate"));
                    booking.setGuestCount(rs.getInt("GuestCount"));
                    booking.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                    booking.setDiscountAmount(rs.getBigDecimal("DiscountAmount"));
                    booking.setFinalAmount(rs.getBigDecimal("FinalAmount"));
                    booking.setCancelReason(rs.getString("CancelReason"));
                    booking.setCancelDate(rs.getTimestamp("CancelDate"));
                    booking.setStatus(rs.getString("Status"));
                    booking.setNote(rs.getString("Note"));
                    booking.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    booking.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

                    booking.setRoomID(rs.getInt("RoomID"));
                    booking.setRoomPrice(rs.getBigDecimal("RoomPrice"));
                    booking.setRoomName(rs.getString("RoomName"));
                    booking.setRoomNumber(rs.getString("RoomNumber"));

                    return booking;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}