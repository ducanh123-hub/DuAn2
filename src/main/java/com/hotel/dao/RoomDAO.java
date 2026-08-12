package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Room;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO implements BaseDAO<Room> {

    // =========================================================
    // GET ALL
    // =========================================================

    @Override
    public List<Room> getAll() {

        List<Room> list = new ArrayList<>();

        String sql = """
                SELECT
                    RoomID,
                    CategoryID,
                    RoomNumber,
                    RoomName,
                    Price,
                    Acreage,
                    Bed,
                    Area,
                    Description,
                    Status,
                    CreatedAt,
                    UpdatedAt
                FROM Room
                ORDER BY RoomID DESC
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {
                list.add(mapRoom(rs));
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
    public Room getById(int id) {

        String sql = """
                SELECT
                    RoomID,
                    CategoryID,
                    RoomNumber,
                    RoomName,
                    Price,
                    Acreage,
                    Bed,
                    Area,
                    Description,
                    Status,
                    CreatedAt,
                    UpdatedAt
                FROM Room
                WHERE RoomID = ?
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapRoom(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================================================
    // INSERT
    // =========================================================

    @Override
    public boolean insert(Room room) {

        if (room == null) {
            return false;
        }

        String sql = """
                INSERT INTO Room
                (
                    CategoryID,
                    RoomNumber,
                    RoomName,
                    Price,
                    Acreage,
                    Bed,
                    Area,
                    Description,
                    Status
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, room.getCategoryID());
            ps.setString(2, room.getRoomNumber());
            ps.setString(3, room.getRoomName());
            ps.setBigDecimal(4, room.getPrice());
            ps.setBigDecimal(5, room.getAcreage());
            ps.setInt(6, room.getBed());
            ps.setString(7, room.getArea());
            ps.setString(8, room.getDescription());
            ps.setString(9, room.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================================================
    // UPDATE
    // =========================================================

    @Override
    public boolean update(Room room) {

        if (room == null) {
            return false;
        }

        String sql = """
                UPDATE Room
                SET
                    CategoryID = ?,
                    RoomNumber = ?,
                    RoomName = ?,
                    Price = ?,
                    Acreage = ?,
                    Bed = ?,
                    Area = ?,
                    Description = ?,
                    Status = ?,
                    UpdatedAt = GETDATE()
                WHERE RoomID = ?
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, room.getCategoryID());
            ps.setString(2, room.getRoomNumber());
            ps.setString(3, room.getRoomName());
            ps.setBigDecimal(4, room.getPrice());
            ps.setBigDecimal(5, room.getAcreage());
            ps.setInt(6, room.getBed());
            ps.setString(7, room.getArea());
            ps.setString(8, room.getDescription());
            ps.setString(9, room.getStatus());
            ps.setInt(10, room.getRoomID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================================================
    // DELETE
    // =========================================================

    @Override
    public boolean delete(int id) {

        String sql = """
                DELETE FROM Room
                WHERE RoomID = ?
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================================================
    // SEARCH CŨ
    // =========================================================

    public List<Room> searchByName(String keyword) {

        List<Room> list = new ArrayList<>();

        if (keyword == null) {
            keyword = "";
        }

        keyword = keyword.trim();

        String sql = """
                SELECT
                    r.RoomID,
                    r.CategoryID,
                    r.RoomNumber,
                    r.RoomName,
                    r.Price,
                    r.Acreage,
                    r.Bed,
                    r.Area,
                    r.Description,
                    r.Status,
                    r.CreatedAt,
                    r.UpdatedAt
                FROM Room r
                INNER JOIN Room_Category rc
                    ON r.CategoryID = rc.CategoryID
                WHERE
                    r.RoomName LIKE ?
                    OR r.RoomNumber LIKE ?
                    OR rc.CategoryName LIKE ?
                ORDER BY r.RoomID DESC
                """;

        String search = "%" + keyword + "%";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    list.add(mapRoom(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================================================
    // SEARCH + FILTER
    // CÓ PHÂN TRANG
    // =========================================================

    public List<Room> searchRooms(
            String keyword,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            Integer people,
            String sortPrice,
            int page,
            int pageSize
    ) {

        List<Room> list = new ArrayList<>();

        if (page < 1) {
            page = 1;
        }

        if (pageSize <= 0) {
            pageSize = 6;
        }

        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder("""
                SELECT
                    r.RoomID,
                    r.CategoryID,
                    r.RoomNumber,
                    r.RoomName,
                    r.Price,
                    r.Acreage,
                    r.Bed,
                    r.Area,
                    r.Description,
                    r.Status,
                    r.CreatedAt,
                    r.UpdatedAt
                FROM Room r
                INNER JOIN Room_Category rc
                    ON r.CategoryID = rc.CategoryID
                WHERE 1 = 1
                """);

        List<Object> params = new ArrayList<>();

        // =====================================================
        // KEYWORD
        // =====================================================

        if (keyword != null && !keyword.trim().isEmpty()) {

            sql.append("""
                    AND (
                        r.RoomName LIKE ?
                        OR r.RoomNumber LIKE ?
                        OR rc.CategoryName LIKE ?
                    )
                    """);

            String search = "%" + keyword.trim() + "%";

            params.add(search);
            params.add(search);
            params.add(search);
        }

        // =====================================================
        // MIN PRICE
        // =====================================================

        if (minPrice != null
                && minPrice.compareTo(BigDecimal.ZERO) >= 0) {

            sql.append("""
                    AND r.Price >= ?
                    """);

            params.add(minPrice);
        }

        // =====================================================
        // MAX PRICE
        // =====================================================

        if (maxPrice != null
                && maxPrice.compareTo(BigDecimal.ZERO) >= 0) {

            sql.append("""
                    AND r.Price <= ?
                    """);

            params.add(maxPrice);
        }

        // =====================================================
        // PEOPLE
        // =====================================================

        if (people != null && people > 0) {

            sql.append("""
                    AND rc.MaxPeople >= ?
                    """);

            params.add(people);
        }

        // =====================================================
        // CHỈ LẤY PHÒNG CÒN TRỐNG
        // =====================================================

        sql.append("""
                AND r.Status = N'Còn trống'
                """);

        // =====================================================
        // SORT
        // =====================================================

        if ("asc".equalsIgnoreCase(sortPrice)) {

            sql.append("""
                    ORDER BY r.Price ASC, r.RoomID DESC
                    """);

        } else if ("desc".equalsIgnoreCase(sortPrice)) {

            sql.append("""
                    ORDER BY r.Price DESC, r.RoomID DESC
                    """);

        } else {

            sql.append("""
                    ORDER BY r.RoomID DESC
                    """);
        }

        // =====================================================
        // PAGINATION
        // =====================================================

        sql.append("""
                OFFSET ? ROWS
                FETCH NEXT ? ROWS ONLY
                """);

        params.add(offset);
        params.add(pageSize);

        // =====================================================
        // EXECUTE
        // =====================================================

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps =
                        con.prepareStatement(sql.toString())
        ) {

            for (int i = 0; i < params.size(); i++) {

                Object value = params.get(i);

                if (value instanceof BigDecimal) {

                    ps.setBigDecimal(
                            i + 1,
                            (BigDecimal) value
                    );

                } else if (value instanceof Integer) {

                    ps.setInt(
                            i + 1,
                            (Integer) value
                    );

                } else {

                    ps.setString(
                            i + 1,
                            String.valueOf(value)
                    );
                }
            }

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    list.add(mapRoom(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================================================
    // COUNT SEARCH + FILTER
    // =========================================================

    public int countSearchRooms(
            String keyword,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            Integer people
    ) {

        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(*)
                FROM Room r
                INNER JOIN Room_Category rc
                    ON r.CategoryID = rc.CategoryID
                WHERE 1 = 1
                """);

        List<Object> params = new ArrayList<>();

        // KEYWORD

        if (keyword != null && !keyword.trim().isEmpty()) {

            sql.append("""
                    AND (
                        r.RoomName LIKE ?
                        OR r.RoomNumber LIKE ?
                        OR rc.CategoryName LIKE ?
                    )
                    """);

            String search = "%" + keyword.trim() + "%";

            params.add(search);
            params.add(search);
            params.add(search);
        }

        // MIN PRICE

        if (minPrice != null
                && minPrice.compareTo(BigDecimal.ZERO) >= 0) {

            sql.append("""
                    AND r.Price >= ?
                    """);

            params.add(minPrice);
        }

        // MAX PRICE

        if (maxPrice != null
                && maxPrice.compareTo(BigDecimal.ZERO) >= 0) {

            sql.append("""
                    AND r.Price <= ?
                    """);

            params.add(maxPrice);
        }

        // PEOPLE

        if (people != null && people > 0) {

            sql.append("""
                    AND rc.MaxPeople >= ?
                    """);

            params.add(people);
        }

        // AVAILABLE

        sql.append("""
                AND r.Status = N'Còn trống'
                """);

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps =
                        con.prepareStatement(sql.toString())
        ) {

            for (int i = 0; i < params.size(); i++) {

                Object value = params.get(i);

                if (value instanceof BigDecimal) {

                    ps.setBigDecimal(
                            i + 1,
                            (BigDecimal) value
                    );

                } else if (value instanceof Integer) {

                    ps.setInt(
                            i + 1,
                            (Integer) value
                    );

                } else {

                    ps.setString(
                            i + 1,
                            String.valueOf(value)
                    );
                }
            }

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // =========================================================
    // GET BY CATEGORY
    // =========================================================

    public List<Room> getByCategory(int categoryID) {

        List<Room> list = new ArrayList<>();

        String sql = """
                SELECT
                    RoomID,
                    CategoryID,
                    RoomNumber,
                    RoomName,
                    Price,
                    Acreage,
                    Bed,
                    Area,
                    Description,
                    Status,
                    CreatedAt,
                    UpdatedAt
                FROM Room
                WHERE CategoryID = ?
                ORDER BY RoomID DESC
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, categoryID);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    list.add(mapRoom(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================================================
    // GET AVAILABLE ROOMS
    // =========================================================

    public List<Room> getAvailableRooms() {

        List<Room> list = new ArrayList<>();

        String sql = """
                SELECT
                    RoomID,
                    CategoryID,
                    RoomNumber,
                    RoomName,
                    Price,
                    Acreage,
                    Bed,
                    Area,
                    Description,
                    Status,
                    CreatedAt,
                    UpdatedAt
                FROM Room
                WHERE Status = N'Còn trống'
                ORDER BY RoomID DESC
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {
                list.add(mapRoom(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================================================
    // GET AVAILABLE ROOMS - PAGINATION
    // =========================================================

    public List<Room> getAvailableRooms(
            int page,
            int pageSize
    ) {

        List<Room> list = new ArrayList<>();

        if (page < 1) {
            page = 1;
        }

        if (pageSize <= 0) {
            pageSize = 6;
        }

        int offset = (page - 1) * pageSize;

        String sql = """
                SELECT
                    RoomID,
                    CategoryID,
                    RoomNumber,
                    RoomName,
                    Price,
                    Acreage,
                    Bed,
                    Area,
                    Description,
                    Status,
                    CreatedAt,
                    UpdatedAt
                FROM Room
                WHERE Status = N'Còn trống'
                ORDER BY RoomID DESC
                OFFSET ? ROWS
                FETCH NEXT ? ROWS ONLY
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, offset);
            ps.setInt(2, pageSize);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    list.add(mapRoom(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =========================================================
    // COUNT ALL ROOMS
    // =========================================================

    public int countRoom() {

        String sql = """
                SELECT COUNT(*)
                FROM Room
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // =========================================================
    // COUNT AVAILABLE ROOMS
    // =========================================================

    public int countAvailableRooms() {

        String sql = """
                SELECT COUNT(*)
                FROM Room
                WHERE Status = N'Còn trống'
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // =========================================================
    // FIND BY ROOM NUMBER
    // =========================================================

    public Room findByRoomNumber(String roomNumber) {

        if (roomNumber == null
                || roomNumber.trim().isEmpty()) {

            return null;
        }

        String sql = """
                SELECT
                    RoomID,
                    CategoryID,
                    RoomNumber,
                    RoomName,
                    Price,
                    Acreage,
                    Bed,
                    Area,
                    Description,
                    Status,
                    CreatedAt,
                    UpdatedAt
                FROM Room
                WHERE RoomNumber = ?
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    roomNumber.trim()
            );

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapRoom(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================================================
    // MAP RESULTSET -> ROOM
    // =========================================================

    private Room mapRoom(ResultSet rs) throws SQLException {

        Room room = new Room();

        room.setRoomID(
                rs.getInt("RoomID")
        );

        room.setCategoryID(
                rs.getInt("CategoryID")
        );

        room.setRoomNumber(
                rs.getString("RoomNumber")
        );

        room.setRoomName(
                rs.getString("RoomName")
        );

        room.setPrice(
                rs.getBigDecimal("Price")
        );

        room.setAcreage(
                rs.getBigDecimal("Acreage")
        );

        room.setBed(
                rs.getInt("Bed")
        );

        room.setArea(
                rs.getString("Area")
        );

        room.setDescription(
                rs.getString("Description")
        );

        room.setStatus(
                rs.getString("Status")
        );

        room.setCreatedAt(
                rs.getTimestamp("CreatedAt")
        );

        room.setUpdatedAt(
                rs.getTimestamp("UpdatedAt")
        );

        return room;
    }
}