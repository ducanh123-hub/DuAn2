package com.hotel.dao;

import com.hotel.config.DBConnect;
import com.hotel.model.Contact;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO implements BaseDAO<Contact> {

    @Override
    public List<Contact> getAll() {
        List<Contact> list = new ArrayList<>();
        String sql = "SELECT * FROM Contact ORDER BY CreatedAt DESC";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Contact contact = new Contact();
                contact.setContactID(rs.getInt("ContactID"));
                int userId = rs.getInt("UserID");
                if (!rs.wasNull()) {
                    contact.setUserID(userId);
                }
                contact.setFullName(rs.getString("FullName"));
                contact.setEmail(rs.getString("Email"));
                contact.setPhone(rs.getString("Phone"));
                contact.setSubject(rs.getString("Subject"));
                contact.setMessage(rs.getString("Message"));
                contact.setStatus(rs.getString("Status"));
                contact.setCreatedAt(rs.getTimestamp("CreatedAt"));
                list.add(contact);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Contact getById(int id) {
        String sql = "SELECT * FROM Contact WHERE ContactID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Contact contact = new Contact();
                    contact.setContactID(rs.getInt("ContactID"));
                    int userId = rs.getInt("UserID");
                    if (!rs.wasNull()) {
                        contact.setUserID(userId);
                    }
                    contact.setFullName(rs.getString("FullName"));
                    contact.setEmail(rs.getString("Email"));
                    contact.setPhone(rs.getString("Phone"));
                    contact.setSubject(rs.getString("Subject"));
                    contact.setMessage(rs.getString("Message"));
                    contact.setStatus(rs.getString("Status"));
                    contact.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    return contact;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(Contact contact) {
        String sql = "INSERT INTO Contact (UserID, FullName, Email, Phone, Subject, Message, Status, CreatedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            if (contact.getUserID() != null) {
                ps.setInt(1, contact.getUserID());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setString(2, contact.getFullName());
            ps.setString(3, contact.getEmail());
            ps.setString(4, contact.getPhone());
            ps.setString(5, contact.getSubject());
            ps.setString(6, contact.getMessage());
            ps.setString(7, contact.getStatus() != null ? contact.getStatus() : "Chưa xử lý");
            ps.setTimestamp(8, contact.getCreatedAt() != null ? contact.getCreatedAt() : new Timestamp(System.currentTimeMillis()));
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Contact contact) {
        String sql = "UPDATE Contact SET UserID = ?, FullName = ?, Email = ?, Phone = ?, Subject = ?, Message = ?, Status = ? WHERE ContactID = ?";
        try (
                Connection con = DBConnect.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            if (contact.getUserID() != null) {
                ps.setInt(1, contact.getUserID());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setString(2, contact.getFullName());
            ps.setString(3, contact.getEmail());
            ps.setString(4, contact.getPhone());
            ps.setString(5, contact.getSubject());
            ps.setString(6, contact.getMessage());
            ps.setString(7, contact.getStatus());
            ps.setInt(8, contact.getContactID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Contact WHERE ContactID = ?";
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
