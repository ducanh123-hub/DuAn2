package com.hotel.service;

import com.hotel.dao.SystemSettingDAO;
import com.hotel.model.SystemSetting;

/**
 * Service xử lý cấu hình hệ thống.
 * Lấy và cập nhật thông tin khách sạn, chính sách.
 */
public class SystemSettingService {

    private final SystemSettingDAO systemSettingDAO = new SystemSettingDAO();

    /**
     * Lấy cấu hình hệ thống hiện tại.
     * Nếu chưa có record nào, tự động khởi tạo mặc định.
     */
    public SystemSetting getSetting() {
        systemSettingDAO.initIfEmpty();
        return systemSettingDAO.get();
    }

    /**
     * Cập nhật cấu hình hệ thống với validate cơ bản
     */
    public boolean updateSetting(SystemSetting setting) {
        if (setting == null) {
            return false;
        }
        // Validate
        if (setting.getHotelName() == null || setting.getHotelName().trim().isEmpty()) {
            return false;
        }
        return systemSettingDAO.update(setting);
    }
}
