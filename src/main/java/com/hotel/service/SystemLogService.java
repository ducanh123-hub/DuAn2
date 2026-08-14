package com.hotel.service;

import com.hotel.dao.SystemLogDAO;
import com.hotel.model.SystemLog;
import com.hotel.model.User;
import jakarta.servlet.http.HttpServletRequest;

import java.util.List;

/**
 * Service xử lý nhật ký hệ thống.
 * Cung cấp phương thức ghi log và tìm kiếm log.
 */
public class SystemLogService {

    private final SystemLogDAO systemLogDAO = new SystemLogDAO();

    public List<SystemLog> getAll() {
        return systemLogDAO.getAll();
    }

    public SystemLog getById(int id) {
        return systemLogDAO.getById(id);
    }

    public List<SystemLog> search(String keyword, String action,
                                   String fromDate, String toDate) {
        return systemLogDAO.search(keyword, action, fromDate, toDate);
    }

    public List<String> getDistinctActions() {
        return systemLogDAO.getDistinctActions();
    }

    public List<SystemLog> getByUserId(int userId) {
        return systemLogDAO.getByUserId(userId);
    }

    /**
     * Ghi nhận một hành động vào nhật ký hệ thống
     *
     * @param userId      ID người thực hiện (null nếu chưa đăng nhập)
     * @param action      Loại hành động (LOGIN, LOGOUT, ADD, UPDATE, DELETE, ...)
     * @param description Mô tả chi tiết hành động
     * @param ipAddress   Địa chỉ IP của người dùng
     */
    public void log(Integer userId, String action, String description, String ipAddress) {
        SystemLog logEntry = new SystemLog();
        logEntry.setUserID(userId);
        logEntry.setAction(action);
        logEntry.setDescription(description);
        logEntry.setIpAddress(ipAddress);
        systemLogDAO.insert(logEntry);
    }

    /**
     * Tiện ích — lấy IP từ request (hỗ trợ proxy)
     */
    public static String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    /**
     * Ghi log từ context của request (tự động lấy userID và IP)
     */
    public void logFromRequest(HttpServletRequest request,
                                String action, String description) {
        User user = null;
        jakarta.servlet.http.HttpSession session = request.getSession(false);
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
        Integer userId = (user != null) ? user.getUserID() : null;
        String ip = getClientIp(request);
        log(userId, action, description, ip);
    }
}
