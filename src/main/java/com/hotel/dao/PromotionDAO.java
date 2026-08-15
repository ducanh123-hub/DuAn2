package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Voucher;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PromotionDAO implements BaseDAO<Voucher> {

    private Voucher mapResultSet(ResultSet rs) throws SQLException {
        Voucher v = new Voucher();
        v.setPromotionID(rs.getInt("PromotionID"));
        v.setCode(rs.getString("Code"));
        v.setName(rs.getString("Name"));
        v.setDescription(rs.getString("Description"));
        v.setDiscountType(rs.getString("DiscountType"));
        v.setDiscountValue(rs.getBigDecimal("DiscountValue"));
        v.setMinOrderAmount(rs.getBigDecimal("MinOrderAmount"));
        v.setMaxDiscountAmount(rs.getBigDecimal("MaxDiscountAmount"));
        v.setUsageLimit((Integer) rs.getObject("UsageLimit"));
        v.setUsedCount(rs.getInt("UsedCount"));
        v.setStartDate(rs.getDate("StartDate"));
        v.setEndDate(rs.getDate("EndDate"));
        v.setStatus(rs.getString("Status"));
        v.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return v;
    }

    @Override
    public List<Voucher> getAll() {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM Voucher ORDER BY CreatedAt DESC";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapResultSet(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Voucher getById(int id) {
        String sql = "SELECT * FROM Voucher WHERE PromotionID = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSet(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Voucher getByCode(String code) {
        String sql = "SELECT * FROM Voucher WHERE Code = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, code);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSet(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(Voucher v) {
        String sql = """
            INSERT INTO Voucher
            (Code, Name, Description, DiscountType, DiscountValue,
             MinOrderAmount, MaxDiscountAmount, UsageLimit,
             StartDate, EndDate, Status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, v.getCode());
            ps.setString(2, v.getName());
            ps.setString(3, v.getDescription());
            ps.setString(4, v.getDiscountType());
            ps.setBigDecimal(5, v.getDiscountValue());
            ps.setBigDecimal(6, v.getMinOrderAmount());
            ps.setBigDecimal(7, v.getMaxDiscountAmount());

            if (v.getUsageLimit() != null)
                ps.setInt(8, v.getUsageLimit());
            else
                ps.setNull(8, Types.INTEGER);

            ps.setDate(9, v.getStartDate());
            ps.setDate(10, v.getEndDate());
            ps.setString(11, v.getStatus() != null ? v.getStatus() : "Active");

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Voucher v) {
        String sql = """
            UPDATE Voucher SET
                Code = ?, Name = ?, Description = ?, DiscountType = ?,
                DiscountValue = ?, MinOrderAmount = ?, MaxDiscountAmount = ?,
                UsageLimit = ?, StartDate = ?, EndDate = ?, Status = ?
            WHERE PromotionID = ?
            """;

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, v.getCode());
            ps.setString(2, v.getName());
            ps.setString(3, v.getDescription());
            ps.setString(4, v.getDiscountType());
            ps.setBigDecimal(5, v.getDiscountValue());
            ps.setBigDecimal(6, v.getMinOrderAmount());
            ps.setBigDecimal(7, v.getMaxDiscountAmount());

            if (v.getUsageLimit() != null)
                ps.setInt(8, v.getUsageLimit());
            else
                ps.setNull(8, Types.INTEGER);

            ps.setDate(9, v.getStartDate());
            ps.setDate(10, v.getEndDate());
            ps.setString(11, v.getStatus());
            ps.setInt(12, v.getPromotionID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Voucher WHERE PromotionID = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}