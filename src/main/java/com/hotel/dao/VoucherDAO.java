package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Voucher;
import java.sql.*;
import java.util.*;

public class VoucherDAO implements BaseDAO<Voucher> {

    // ================================================================
    // MAP RESULTSET -> VOUCHER
    // ================================================================
    private Voucher mapRow(ResultSet rs) throws SQLException {
        Voucher v = new Voucher();
        v.setPromotionID(rs.getInt("PromotionID"));
        v.setCode(rs.getString("Code"));
        v.setName(rs.getString("Name"));
        v.setDescription(rs.getString("Description"));
        v.setDiscountType(rs.getString("DiscountType"));
        v.setDiscountValue(rs.getBigDecimal("DiscountValue"));
        v.setMinOrderAmount(rs.getBigDecimal("MinOrderAmount"));
        v.setMaxDiscountAmount(rs.getBigDecimal("MaxDiscountAmount"));
        int usageLimit = rs.getInt("UsageLimit");
        v.setUsageLimit(rs.wasNull() ? null : usageLimit);
        v.setUsedCount(rs.getInt("UsedCount"));
        v.setStartDate(rs.getDate("StartDate"));
        v.setEndDate(rs.getDate("EndDate"));
        v.setStatus(rs.getString("Status"));
        v.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return v;
    }

    // ================================================================
    // GET ALL
    // ================================================================
    @Override
    public List<Voucher> getAll() {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM Voucher ORDER BY CreatedAt DESC";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ================================================================
    // GET BY ID
    // ================================================================
    @Override
    public Voucher getById(int id) {
        String sql = "SELECT * FROM Voucher WHERE PromotionID = ?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================================================================
    // GET BY CODE
    // ================================================================
    public Voucher getByCode(String code) {
        String sql = "SELECT * FROM Voucher WHERE UPPER(Code) = UPPER(?)";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================================================================
    // GET ACTIVE VOUCHERS
    // Điều kiện: Active + trong hạn + còn lượt dùng
    // ================================================================
    public List<Voucher> getActiveVouchers() {
        List<Voucher> list = new ArrayList<>();
        String sql = """
                SELECT * FROM Voucher
                WHERE Status = N'Active'
                  AND StartDate <= CAST(GETDATE() AS DATE)
                  AND EndDate   >= CAST(GETDATE() AS DATE)
                  AND (UsageLimit IS NULL OR UsedCount < UsageLimit)
                ORDER BY CreatedAt DESC
                """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ================================================================
    // EXISTS BY CODE (dùng khi INSERT – kiểm tra trùng mã)
    // ================================================================
    public boolean existsByCode(String code) {
        String sql = "SELECT COUNT(*) FROM Voucher WHERE UPPER(Code) = UPPER(?)";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================================================================
    // EXISTS BY CODE EXCEPT ID (dùng khi UPDATE – tránh trùng mã
    // với voucher khác)
    // ================================================================
    public boolean existsByCodeExceptId(String code, int promotionID) {
        String sql = "SELECT COUNT(*) FROM Voucher "
                + "WHERE UPPER(Code) = UPPER(?) AND PromotionID <> ?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            ps.setInt(2, promotionID);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================================================================
    // INSERT
    // ================================================================
    @Override
    public boolean insert(Voucher v) {
        String sql = """
                INSERT INTO Voucher
                (Code, Name, Description, DiscountType, DiscountValue,
                 MinOrderAmount, MaxDiscountAmount, UsageLimit, UsedCount,
                 StartDate, EndDate, Status)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ?, ?)
                """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, v.getCode().trim().toUpperCase());
            ps.setString(2, v.getName());
            ps.setString(3, v.getDescription());
            ps.setString(4, v.getDiscountType());
            ps.setBigDecimal(5, v.getDiscountValue());
            ps.setBigDecimal(6, v.getMinOrderAmount());

            if (v.getMaxDiscountAmount() == null)
                ps.setNull(7, Types.DECIMAL);
            else
                ps.setBigDecimal(7, v.getMaxDiscountAmount());

            if (v.getUsageLimit() == null)
                ps.setNull(8, Types.INTEGER);
            else
                ps.setInt(8, v.getUsageLimit());

            ps.setDate(9,  v.getStartDate());
            ps.setDate(10, v.getEndDate());
            ps.setString(11, v.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================================================================
    // UPDATE
    // ================================================================
    @Override
    public boolean update(Voucher v) {
        String sql = """
                UPDATE Voucher SET
                    Code             = ?,
                    Name             = ?,
                    Description      = ?,
                    DiscountType     = ?,
                    DiscountValue    = ?,
                    MinOrderAmount   = ?,
                    MaxDiscountAmount = ?,
                    UsageLimit       = ?,
                    StartDate        = ?,
                    EndDate          = ?,
                    Status           = ?
                WHERE PromotionID = ?
                """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, v.getCode().trim().toUpperCase());
            ps.setString(2, v.getName());
            ps.setString(3, v.getDescription());
            ps.setString(4, v.getDiscountType());
            ps.setBigDecimal(5, v.getDiscountValue());
            ps.setBigDecimal(6, v.getMinOrderAmount());

            if (v.getMaxDiscountAmount() == null)
                ps.setNull(7, Types.DECIMAL);
            else
                ps.setBigDecimal(7, v.getMaxDiscountAmount());

            if (v.getUsageLimit() == null)
                ps.setNull(8, Types.INTEGER);
            else
                ps.setInt(8, v.getUsageLimit());

            ps.setDate(9,  v.getStartDate());
            ps.setDate(10, v.getEndDate());
            ps.setString(11, v.getStatus());
            ps.setInt(12, v.getPromotionID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================================================================
    // DELETE (soft-delete: Status -> Inactive)
    // ================================================================
    @Override
    public boolean delete(int id) {
        String sql = "UPDATE Voucher SET Status = N'Inactive' WHERE PromotionID = ?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================================================================
    // INCREASE USED COUNT
    // Chỉ tăng nếu còn trong giới hạn UsageLimit
    // ================================================================
    public boolean increaseUsedCount(int promotionID) {
        String sql = """
                UPDATE Voucher
                SET UsedCount = UsedCount + 1
                WHERE PromotionID = ?
                  AND (UsageLimit IS NULL OR UsedCount < UsageLimit)
                """;
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, promotionID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}