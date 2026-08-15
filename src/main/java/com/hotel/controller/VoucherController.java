package com.hotel.controller;

import com.hotel.model.Voucher;
import com.hotel.service.VoucherService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

@WebServlet("/voucher")
public class VoucherController extends HttpServlet {

    private final VoucherService voucherService = new VoucherService();

    // ================================================================
    // GET
    // ================================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) action = "list";

        switch (action) {
            case "add"    -> showAddForm(request, response);
            case "edit"   -> showEditForm(request, response);
            case "delete" -> deleteVoucher(request, response);
            default       -> listVoucher(request, response);
        }
    }

    // ================================================================
    // POST
    // ================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "insert" -> insertVoucher(request, response);
            case "update" -> updateVoucher(request, response);
            // ----------------------------------------------------------
            // AJAX endpoint: POST /voucher?action=apply
            // Params : code, totalAmount
            // Returns: JSON { valid, promotionID, voucherName,
            //                 discount, finalAmount, message }
            // ----------------------------------------------------------
            case "apply"  -> applyVoucher(request, response);
            default       -> response.sendRedirect(request.getContextPath() + "/voucher");
        }
    }

    // ================================================================
    // AJAX – ÁP DỤNG VOUCHER
    // ================================================================
    private void applyVoucher(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String code     = request.getParameter("code");
        String totalStr = request.getParameter("totalAmount");

        // ── 1. Validate input ──────────────────────────────────────
        if (code == null || code.isBlank()) {
            json(response, false, "Vui lòng nhập mã voucher!", null, null, null);
            return;
        }
        if (totalStr == null || totalStr.isBlank()) {
            json(response, false, "Không xác định được tổng tiền!", null, null, null);
            return;
        }

        BigDecimal totalAmount;
        try {
            totalAmount = new BigDecimal(totalStr.trim());
        } catch (NumberFormatException e) {
            json(response, false, "Tổng tiền không hợp lệ!", null, null, null);
            return;
        }

        // ── 2. Tìm voucher theo code ───────────────────────────────
        Voucher voucher = voucherService.getVoucherByCode(code.trim().toUpperCase());

        if (voucher == null) {
            json(response, false, "Mã voucher không tồn tại!", null, null, null);
            return;
        }

        // ── 3. Kiểm tra trạng thái Active ─────────────────────────
        if (!"Active".equalsIgnoreCase(voucher.getStatus())) {
            json(response, false, "Mã voucher đã bị vô hiệu hóa!", null, null, null);
            return;
        }

        // ── 4. Kiểm tra ngày hiệu lực ─────────────────────────────
        Date today = new Date(System.currentTimeMillis());
        if (today.before(voucher.getStartDate())) {
            json(response, false, "Mã voucher chưa đến ngày sử dụng!", null, null, null);
            return;
        }
        if (today.after(voucher.getEndDate())) {
            json(response, false, "Mã voucher đã hết hạn sử dụng!", null, null, null);
            return;
        }

        // ── 5. Kiểm tra giới hạn lượt dùng ───────────────────────
        if (voucher.getUsageLimit() != null
                && voucher.getUsedCount() >= voucher.getUsageLimit()) {
            json(response, false, "Mã voucher đã được sử dụng hết lượt!", null, null, null);
            return;
        }

        // ── 6. Kiểm tra giá trị đơn tối thiểu ────────────────────
        if (voucher.getMinOrderAmount() != null
                && totalAmount.compareTo(voucher.getMinOrderAmount()) < 0) {
            String minStr = String.format("%,.0f VNĐ", voucher.getMinOrderAmount());
            json(response, false,
                    "Đơn hàng tối thiểu " + minStr + " mới áp dụng được voucher này!",
                    null, null, null);
            return;
        }

        // ── 7. Tính tiền giảm ─────────────────────────────────────
        BigDecimal discount    = voucherService.calculateDiscount(voucher, totalAmount);
        BigDecimal finalAmount = totalAmount.subtract(discount);

        // ── 8. Trả JSON thành công ────────────────────────────────
        json(response, true, "Áp dụng voucher thành công!", voucher, discount, finalAmount);
    }

    // ── Helper: viết JSON ra response ─────────────────────────────────
    private void json(HttpServletResponse response,
                      boolean valid,
                      String message,
                      Voucher voucher,
                      BigDecimal discount,
                      BigDecimal finalAmount) throws IOException {

        StringBuilder sb = new StringBuilder("{");
        sb.append("\"valid\":").append(valid).append(",");
        sb.append("\"message\":\"").append(escJson(message)).append("\"");

        if (valid && voucher != null) {
            sb.append(",\"promotionID\":").append(voucher.getPromotionID());
            sb.append(",\"voucherName\":\"").append(escJson(voucher.getName())).append("\"");
            sb.append(",\"discount\":").append(discount.toPlainString());
            sb.append(",\"finalAmount\":").append(finalAmount.toPlainString());
        }

        sb.append("}");
        response.getWriter().write(sb.toString());
    }

    private String escJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    // ================================================================
    // LIST
    // ================================================================
    private void listVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Voucher> voucherList = voucherService.getAllVouchers();
        request.setAttribute("voucherList", voucherList);
        request.getRequestDispatcher("/views/admin/voucher/list.jsp")
                .forward(request, response);
    }

    // ================================================================
    // SHOW ADD FORM
    // ================================================================
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("voucher", new Voucher());
        request.setAttribute("mode", "add");
        request.getRequestDispatcher("/views/admin/voucher/form.jsp")
                .forward(request, response);
    }

    // ================================================================
    // SHOW EDIT FORM
    // ================================================================
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Voucher voucher = voucherService.getVoucherById(id);
            if (voucher == null) {
                response.sendRedirect(request.getContextPath() + "/voucher");
                return;
            }
            request.setAttribute("voucher", voucher);
            request.setAttribute("mode", "edit");
            request.getRequestDispatcher("/views/admin/voucher/form.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/voucher");
        }
    }

    // ================================================================
    // INSERT
    // ================================================================
    private void insertVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Voucher voucher;
        try {
            voucher = readVoucherFromRequest(request);
        } catch (Exception e) {
            showFormError(request, response, new Voucher(), "add",
                    "Dữ liệu voucher không hợp lệ!");
            return;
        }

        if (voucherService.insertVoucher(voucher)) {
            response.sendRedirect(request.getContextPath()
                    + "/voucher?action=list&success=add");
        } else {
            showFormError(request, response, voucher, "add",
                    "Không thể thêm voucher. Mã voucher có thể đã tồn tại!");
        }
    }

    // ================================================================
    // UPDATE
    // ================================================================
    private void updateVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Voucher voucher;
        try {
            voucher = readVoucherFromRequest(request);
            voucher.setPromotionID(
                    Integer.parseInt(request.getParameter("promotionID")));
        } catch (Exception e) {
            showFormError(request, response, new Voucher(), "edit",
                    "Dữ liệu voucher không hợp lệ!");
            return;
        }

        if (voucherService.updateVoucher(voucher)) {
            response.sendRedirect(request.getContextPath()
                    + "/voucher?action=list&success=update");
        } else {
            showFormError(request, response, voucher, "edit",
                    "Không thể cập nhật voucher. Kiểm tra lại dữ liệu!");
        }
    }

    // ================================================================
    // DELETE (soft-delete → Status = Inactive)
    // ================================================================
    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            voucherService.deleteVoucher(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/voucher");
    }

    // ================================================================
    // HELPERS
    // ================================================================
    private void showFormError(HttpServletRequest request, HttpServletResponse response,
                               Voucher voucher, String mode, String error)
            throws ServletException, IOException {

        request.setAttribute("error", error);
        request.setAttribute("voucher", voucher);
        request.setAttribute("mode", mode);
        request.getRequestDispatcher("/views/admin/voucher/form.jsp")
                .forward(request, response);
    }

    private Voucher readVoucherFromRequest(HttpServletRequest request) {
        Voucher v = new Voucher();
        v.setCode(request.getParameter("code"));
        v.setName(request.getParameter("name"));
        v.setDescription(request.getParameter("description"));
        v.setDiscountType(request.getParameter("discountType"));
        v.setDiscountValue(new BigDecimal(request.getParameter("discountValue")));
        v.setMinOrderAmount(new BigDecimal(request.getParameter("minOrderAmount")));

        String maxDiscount = request.getParameter("maxDiscountAmount");
        v.setMaxDiscountAmount(
                maxDiscount == null || maxDiscount.isBlank()
                        ? null : new BigDecimal(maxDiscount));

        String usageLimit = request.getParameter("usageLimit");
        v.setUsageLimit(
                usageLimit == null || usageLimit.isBlank()
                        ? null : Integer.parseInt(usageLimit));

        v.setStartDate(Date.valueOf(request.getParameter("startDate")));
        v.setEndDate(Date.valueOf(request.getParameter("endDate")));

        String status = request.getParameter("status");
        v.setStatus(status == null || status.isBlank() ? "Active" : status);

        return v;
    }
}