package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Permission;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PermissionDAO implements BaseDAO<Permission> {

    @Override
    public List<Permission> getAll() {
        List<Permission> list = new ArrayList<>();
        String sql = "SELECT * FROM Permission";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Permission permission = new Permission();
                permission.setPermissionID(rs.getInt("PermissionID"));
                permission.setPermissionName(rs.getString("PermissionName"));
                permission.setPermissionCode(rs.getString("PermissionCode"));
                permission.setDescription(rs.getString("Description"));
                permission.setStatus(rs.getString("Status"));
                list.add(permission);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Permission getById(int id) {
        String sql = "SELECT * FROM Permission WHERE PermissionID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Permission permission = new Permission();
                    permission.setPermissionID(rs.getInt("PermissionID"));
                    permission.setPermissionName(rs.getString("PermissionName"));
                    permission.setPermissionCode(rs.getString("PermissionCode"));
                    permission.setDescription(rs.getString("Description"));
                    permission.setStatus(rs.getString("Status"));
                    return permission;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(Permission permission) {
        String sql = "INSERT INTO Permission (PermissionName, PermissionCode, Description, Status) VALUES (?, ?, ?, ?)";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, permission.getPermissionName());
            ps.setString(2, permission.getPermissionCode());
            ps.setString(3, permission.getDescription());
            ps.setString(4, permission.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Permission permission) {
        String sql = "UPDATE Permission SET PermissionName = ?, PermissionCode = ?, Description = ?, Status = ? WHERE PermissionID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, permission.getPermissionName());
            ps.setString(2, permission.getPermissionCode());
            ps.setString(3, permission.getDescription());
            ps.setString(4, permission.getStatus());
            ps.setInt(5, permission.getPermissionID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Permission WHERE PermissionID = ?";
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
