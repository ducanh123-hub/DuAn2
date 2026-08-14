package com.hotel.service;

import com.hotel.dao.RoomCategoryDAO;
import com.hotel.model.RoomCategory;

import java.math.BigDecimal;
import java.util.List;

/**
 * Service xử lý nghiệp vụ Danh mục phòng.
 * Bao gồm validate dữ liệu và kiểm tra ràng buộc trước khi xóa.
 */
public class RoomCategoryService {

    private final RoomCategoryDAO roomCategoryDAO = new RoomCategoryDAO();

    public List<RoomCategory> getAll() {
        return roomCategoryDAO.getAll();
    }

    public RoomCategory getById(int id) {
        return roomCategoryDAO.getById(id);
    }

    public List<RoomCategory> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return roomCategoryDAO.getAll();
        }
        return roomCategoryDAO.search(keyword);
    }

    /**
     * Thêm loại phòng mới với validate
     * @return null nếu thành công, chuỗi lỗi nếu thất bại
     */
    public String addCategory(RoomCategory category) {
        String error = validate(category, 0);
        if (error != null) return error;

        boolean ok = roomCategoryDAO.insert(category);
        return ok ? null : "Thêm loại phòng thất bại!";
    }

    /**
     * Cập nhật loại phòng với validate
     * @return null nếu thành công, chuỗi lỗi nếu thất bại
     */
    public String updateCategory(RoomCategory category) {
        if (category.getCategoryID() <= 0) return "ID loại phòng không hợp lệ!";
        String error = validate(category, category.getCategoryID());
        if (error != null) return error;

        boolean ok = roomCategoryDAO.update(category);
        return ok ? null : "Cập nhật loại phòng thất bại!";
    }

    /**
     * Xóa loại phòng — kiểm tra ràng buộc với bảng Room trước
     * @return null nếu thành công, chuỗi lỗi nếu thất bại
     */
    public String deleteCategory(int id) {
        if (roomCategoryDAO.isUsedByRoom(id)) {
            return "Không thể xóa loại phòng này vì đang có phòng sử dụng!";
        }
        boolean ok = roomCategoryDAO.delete(id);
        return ok ? null : "Xóa loại phòng thất bại!";
    }

    // ---- Phương thức gốc giữ lại để tương thích ----
    public boolean insert(RoomCategory category) {
        return roomCategoryDAO.insert(category);
    }

    public boolean update(RoomCategory category) {
        return roomCategoryDAO.update(category);
    }

    public boolean delete(int id) {
        return roomCategoryDAO.delete(id);
    }

    // ---- Validate nội bộ ----
    private String validate(RoomCategory c, int excludeId) {
        if (c.getCategoryName() == null || c.getCategoryName().trim().isEmpty()) {
            return "Tên loại phòng không được để trống!";
        }
        if (c.getCategoryName().trim().length() > 100) {
            return "Tên loại phòng không vượt quá 100 ký tự!";
        }
        if (c.getBasePrice() == null || c.getBasePrice().compareTo(BigDecimal.ZERO) <= 0) {
            return "Giá cơ bản phải lớn hơn 0!";
        }
        if (c.getMaxPeople() <= 0) {
            return "Sức chứa phải lớn hơn 0!";
        }
        if (roomCategoryDAO.existsByName(c.getCategoryName().trim(), excludeId)) {
            return "Tên loại phòng đã tồn tại!";
        }
        return null;
    }
}