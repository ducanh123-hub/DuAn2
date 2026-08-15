package com.hotel.service;

import com.hotel.dao.VoucherDAO;
import com.hotel.model.Voucher;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

public class VoucherService {

    private final VoucherDAO voucherDAO = new VoucherDAO();

    // ================================================================
    // GET ALL
    // ================================================================
    public List<Voucher> getAllVouchers() {
        return voucherDAO.getAll();
    }

    // ================================================================
    // GET BY ID
    // ================================================================
    public Voucher getVoucherById(int id) {
        return voucherDAO.getById(id);
    }

    // ================================================================
    // GET BY CODE
    // Tự động trim + uppercase trước khi tìm
    // ================================================================
    public Voucher getVoucherByCode(String code) {
        if (code == null || code.isBlank()) return null;
        return voucherDAO.getByCode(code.trim().toUpperCase());
    }

    // ================================================================
    // GET ACTIVE VOUCHERS
    // ================================================================
    public List<Voucher> getActiveVouchers() {
        return voucherDAO.getActiveVouchers();
    }

    // ================================================================
    // INSERT
    // ================================================================
    public boolean insertVoucher(Voucher voucher) {
        if (!validateVoucher(voucher)) return false;
        voucher.setCode(voucher.getCode().trim().toUpperCase());
        if (voucherDAO.existsByCode(voucher.getCode())) return false;
        return voucherDAO.insert(voucher);
    }

    // ================================================================
    // UPDATE
    // ================================================================
    public boolean updateVoucher(Voucher voucher) {
        if (!validateVoucher(voucher)) return false;
        voucher.setCode(voucher.getCode().trim().toUpperCase());
        if (voucherDAO.existsByCodeExceptId(voucher.getCode(), voucher.getPromotionID()))
            return false;
        return voucherDAO.update(voucher);
    }

    // ================================================================
    // DELETE (soft-delete)
    // ================================================================
    public boolean deleteVoucher(int id) {
        return voucherDAO.delete(id);
    }

    // ================================================================
    // INCREASE USED COUNT
    // Gọi sau khi booking INSERT thành công
    // ================================================================
    public boolean increaseUsedCount(int promotionID) {
        return voucherDAO.increaseUsedCount(promotionID);
    }

    // ================================================================
    // TÍNH TIỀN GIẢM GIÁ
    //
    // Logic:
    //   Percent : discount = orderAmount × discountValue / 100
    //   Fixed   : discount = discountValue
    //
    // Sau đó:
    //   - Nếu discount > maxDiscountAmount  → cap lại bằng maxDiscountAmount
    //   - Nếu discount > orderAmount        → cap lại bằng orderAmount (không âm)
    //   - Làm tròn xuống đến đơn vị VNĐ (scale 0)
    // ================================================================
    public BigDecimal calculateDiscount(Voucher voucher, BigDecimal orderAmount) {

        if (voucher == null || orderAmount == null
                || orderAmount.compareTo(BigDecimal.ZERO) <= 0) {
            return BigDecimal.ZERO;
        }

        // Kiểm tra trạng thái
        if (!"Active".equalsIgnoreCase(voucher.getStatus())) {
            return BigDecimal.ZERO;
        }

        // Kiểm tra giá trị đơn tối thiểu
        if (voucher.getMinOrderAmount() != null
                && orderAmount.compareTo(voucher.getMinOrderAmount()) < 0) {
            return BigDecimal.ZERO;
        }

        BigDecimal discount;

        if ("Percent".equalsIgnoreCase(voucher.getDiscountType())) {
            // Phần trăm
            discount = orderAmount
                    .multiply(voucher.getDiscountValue())
                    .divide(new BigDecimal("100"), 0, RoundingMode.DOWN);
        } else {
            // Fixed – giảm số tiền cố định
            discount = voucher.getDiscountValue().setScale(0, RoundingMode.DOWN);
        }

        // Cap theo maxDiscountAmount
        if (voucher.getMaxDiscountAmount() != null
                && discount.compareTo(voucher.getMaxDiscountAmount()) > 0) {
            discount = voucher.getMaxDiscountAmount().setScale(0, RoundingMode.DOWN);
        }

        // Không được giảm nhiều hơn tổng đơn hàng
        if (discount.compareTo(orderAmount) > 0) {
            discount = orderAmount.setScale(0, RoundingMode.DOWN);
        }

        return discount;
    }

    // ================================================================
    // VALIDATE VOUCHER (dùng cho cả insert & update)
    // ================================================================
    private boolean validateVoucher(Voucher voucher) {
        if (voucher == null) return false;

        // Code & Name bắt buộc
        if (voucher.getCode() == null || voucher.getCode().isBlank()) return false;
        if (voucher.getName() == null || voucher.getName().isBlank()) return false;

        // DiscountType phải là Percent hoặc Fixed
        String type = voucher.getDiscountType();
        if (type == null
                || (!type.equalsIgnoreCase("Percent")
                && !type.equalsIgnoreCase("Fixed"))) {
            return false;
        }

        // DiscountValue >= 0
        if (voucher.getDiscountValue() == null
                || voucher.getDiscountValue().compareTo(BigDecimal.ZERO) < 0) {
            return false;
        }

        // Percent không được vượt quá 100
        if ("Percent".equalsIgnoreCase(type)
                && voucher.getDiscountValue().compareTo(new BigDecimal("100")) > 0) {
            return false;
        }

        // MinOrderAmount >= 0
        if (voucher.getMinOrderAmount() == null
                || voucher.getMinOrderAmount().compareTo(BigDecimal.ZERO) < 0) {
            return false;
        }

        // MaxDiscountAmount (nếu có) >= 0
        if (voucher.getMaxDiscountAmount() != null
                && voucher.getMaxDiscountAmount().compareTo(BigDecimal.ZERO) < 0) {
            return false;
        }

        // UsageLimit (nếu có) >= 0
        if (voucher.getUsageLimit() != null && voucher.getUsageLimit() < 0) {
            return false;
        }

        // Ngày bắt buộc & EndDate >= StartDate
        if (voucher.getStartDate() == null || voucher.getEndDate() == null) {
            return false;
        }
        if (voucher.getEndDate().before(voucher.getStartDate())) {
            return false;
        }

        return true;
    }
}