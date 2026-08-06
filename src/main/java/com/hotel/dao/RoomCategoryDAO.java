package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.RoomCategory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomCategoryDAO implements BaseDAO<RoomCategory> {

    @Override
    public List<RoomCategory> getAll() {

        List<RoomCategory> list = new ArrayList<>();

        String sql = "SELECT * FROM Room_Category";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                RoomCategory category = new RoomCategory();

                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setDescription(rs.getString("Description"));
                category.setBasePrice(rs.getBigDecimal("BasePrice"));
                category.setMaxPeople(rs.getInt("MaxPeople"));
                category.setStatus(rs.getString("Status"));
                category.setCreatedAt(rs.getTimestamp("CreatedAt"));

                list.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public RoomCategory getById(int id) {

        String sql = "SELECT * FROM Room_Category WHERE CategoryID=?";

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                RoomCategory category = new RoomCategory();

                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setDescription(rs.getString("Description"));
                category.setBasePrice(rs.getBigDecimal("BasePrice"));
                category.setMaxPeople(rs.getInt("MaxPeople"));
                category.setStatus(rs.getString("Status"));
                category.setCreatedAt(rs.getTimestamp("CreatedAt"));

                return category;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean insert(RoomCategory category) {

        String sql = """
                INSERT INTO Room_Category
                (
                    CategoryName,
                    Description,
                    BasePrice,
                    MaxPeople,
                    Status
                )
                VALUES(?,?,?,?,?)
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.setBigDecimal(3, category.getBasePrice());
            ps.setInt(4, category.getMaxPeople());
            ps.setString(5, category.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean update(RoomCategory category) {

        String sql = """
                UPDATE Room_Category
                SET
                    CategoryName=?,
                    Description=?,
                    BasePrice=?,
                    MaxPeople=?,
                    Status=?
                WHERE CategoryID=?
                """;

        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.setBigDecimal(3, category.getBasePrice());
            ps.setInt(4, category.getMaxPeople());
            ps.setString(5, category.getStatus());
            ps.setInt(6, category.getCategoryID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean delete(int id) {

        String sql = "DELETE FROM Room_Category WHERE CategoryID=?";

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
}