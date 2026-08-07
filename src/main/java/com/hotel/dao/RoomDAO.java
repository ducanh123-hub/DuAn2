package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Room;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO implements BaseDAO<Room> {

    @Override
    public List<Room> getAll() {

        List<Room> list = new ArrayList<>();

        String sql = "SELECT * FROM Room";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Room room = new Room();

                room.setRoomID(rs.getInt("RoomID"));
                room.setCategoryID(rs.getInt("CategoryID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomName(rs.getString("RoomName"));
                room.setPrice(rs.getBigDecimal("Price"));
                room.setAcreage(rs.getBigDecimal("Acreage"));
                room.setBed(rs.getInt("Bed"));
                room.setArea(rs.getString("Area"));
                room.setDescription(rs.getString("Description"));
                room.setStatus(rs.getString("Status"));
                room.setCreatedAt(rs.getTimestamp("CreatedAt"));
                room.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

                list.add(room);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public Room getById(int id) {

        String sql = "SELECT * FROM Room WHERE RoomID=?";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Room room = new Room();

                room.setRoomID(rs.getInt("RoomID"));
                room.setCategoryID(rs.getInt("CategoryID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomName(rs.getString("RoomName"));
                room.setPrice(rs.getBigDecimal("Price"));
                room.setAcreage(rs.getBigDecimal("Acreage"));
                room.setBed(rs.getInt("Bed"));
                room.setArea(rs.getString("Area"));
                room.setDescription(rs.getString("Description"));
                room.setStatus(rs.getString("Status"));
                room.setCreatedAt(rs.getTimestamp("CreatedAt"));
                room.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

                return room;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean insert(Room room) {

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
            VALUES(?,?,?,?,?,?,?,?,?)
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

    @Override
    public boolean update(Room room) {

        String sql = """
            UPDATE Room
            SET
                CategoryID=?,
                RoomNumber=?,
                RoomName=?,
                Price=?,
                Acreage=?,
                Bed=?,
                Area=?,
                Description=?,
                Status=?,
                UpdatedAt=GETDATE()
            WHERE RoomID=?
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

    @Override
    public boolean delete(int id) {

        String sql = "DELETE FROM Room WHERE RoomID=?";

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

    public List<Room> searchByName(String keyword) {

        List<Room> list = new ArrayList<>();

        String sql = "SELECT * FROM Room WHERE RoomName LIKE ? OR RoomNumber LIKE ?";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Room room = new Room();

                room.setRoomID(rs.getInt("RoomID"));
                room.setCategoryID(rs.getInt("CategoryID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomName(rs.getString("RoomName"));
                room.setPrice(rs.getBigDecimal("Price"));
                room.setAcreage(rs.getBigDecimal("Acreage"));
                room.setBed(rs.getInt("Bed"));
                room.setArea(rs.getString("Area"));
                room.setDescription(rs.getString("Description"));
                room.setStatus(rs.getString("Status"));
                room.setCreatedAt(rs.getTimestamp("CreatedAt"));
                room.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

                list.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Room> getByCategory(int categoryID) {

        List<Room> list = new ArrayList<>();

        String sql = "SELECT * FROM Room WHERE CategoryID=?";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, categoryID);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Room room = new Room();

                room.setRoomID(rs.getInt("RoomID"));
                room.setCategoryID(rs.getInt("CategoryID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomName(rs.getString("RoomName"));
                room.setPrice(rs.getBigDecimal("Price"));
                room.setAcreage(rs.getBigDecimal("Acreage"));
                room.setBed(rs.getInt("Bed"));
                room.setArea(rs.getString("Area"));
                room.setDescription(rs.getString("Description"));
                room.setStatus(rs.getString("Status"));

                list.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Room> getAvailableRooms() {

        List<Room> list = new ArrayList<>();

        String sql = "SELECT * FROM Room WHERE Status='Available'";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Room room = new Room();

                room.setRoomID(rs.getInt("RoomID"));
                room.setCategoryID(rs.getInt("CategoryID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomName(rs.getString("RoomName"));
                room.setPrice(rs.getBigDecimal("Price"));
                room.setStatus(rs.getString("Status"));

                list.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public int countRoom() {

        String sql = "SELECT COUNT(*) FROM Room";

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
    public Room findByRoomNumber(String roomNumber) {

        String sql = "SELECT * FROM Room WHERE RoomNumber=?";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, roomNumber);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Room room = new Room();

                room.setRoomID(rs.getInt("RoomID"));
                room.setRoomNumber(rs.getString("RoomNumber"));

                return room;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

}