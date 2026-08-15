package com.hotel.service;

import com.hotel.dao.PromotionDAO;
import com.hotel.model.Voucher;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

/**
 * Service xử lý nghiệp vụ Quản lý khuyến mãi / voucher.
 * Validate mã, ngày, mức giảm.
 */
public class PromotionService {

    private final PromotionDAO promotionDAO = new PromotionDAO();

    public List<Voucher> getAll() {
        return promotionDAO.getAll();
    }

    public Voucher getById(int id) {
        return promotionDAO.getById(id);
    }

    public Voucher getByCode(String code) {
        return promotionDAO.getByCode(code);
    }

    /**
     * Tạo khuyến mãi mới với validate
     * @return null nếu OK, chuỗi lỗi nếu có lỗi
     */
    public String addPromotion(Voucher voucher) {
        String error = validate(voucher, 0);
        if (error != null) return error;
        boolean ok = promotionDAO.insert(voucher);
        return ok ? null : "Thêm khuyến mãi thất bại!";
    }

    /**
     * Cập nhật khuyến mãi với validate
     * @return null nếu OK, chuỗi lỗi nếu có lỗi
     */
    public String updatePromotion(Voucher voucher) {
        if (voucher.getPromotionID() <= 0) return "ID không hợp lệ!";
        String error = validate(voucher, voucher.getPromotionID());
        if (error != null) return error;
        boolean ok = promotionDAO.update(voucher);
        return ok ? null : "Cập nhật khuyến mãi thất bại!";
    }

    /**
     * Xóa khuyến mãi
     */
    public boolean delete(int id) {
        return promotionDAO.delete(id);
    }

    // ---- Validate nội bộ ----
    private String validate(Voucher v, int excludeId) {
        if (v.getCode() == null || v.getCode().trim().isEmpty()) {
            return "Mã giảm giá không được để trống!";
        }
        if (v.getName() == null || v.getName().trim().isEmpty()) {
            return "Tên chương trình không được để trống!";
        }
        if (v.getDiscountValue() == null || v.getDiscountValue().compareTo(BigDecimal.ZERO) <= 0) {
            return "Mức giảm phải lớn hơn 0!";
        }
        if ("percent".equalsIgnoreCase(v.getDiscountType())
                && v.getDiscountValue().compareTo(new BigDecimal("100")) > 0) {
            return "Mức giảm theo % không được vượt quá 100%!";
        }
        if (v.getStartDate() == null || v.getEndDate() == null) {
            return "Ngày bắt đầu và ngày kết thúc không được để trống!";
        }
        if (v.getStartDate().compareTo(v.getEndDate()) > 0) {
            return "Ngày bắt đầu không được sau ngày kết thúc!";
        }
        // Kiểm tra trùng mã, ngoại trừ chính nó khi update
        Voucher existing = promotionDAO.getByCode(v.getCode().trim().toUpperCase());

        if (existing != null && existing.getPromotionID() != excludeId) {
            return "Mã giảm giá đã tồn tại!";
        }

        return null;
    }
}
