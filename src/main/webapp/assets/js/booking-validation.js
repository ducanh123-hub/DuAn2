/**
 * Validate Form Đặt Phòng - Luxury Hotel
 * Per-field validation: Kiểm tra từng trường độc lập, hiển thị lỗi ngay bên dưới input.
 */
document.addEventListener("DOMContentLoaded", function () {
    const bookingForm = document.getElementById("bookingForm");
    if (!bookingForm) return;

    // Tắt HTML5 default validation tooltips để sử dụng custom error UI
    bookingForm.setAttribute("novalidate", "true");

    const fields = {
        fullName: document.getElementById("fullName"),
        phone: document.getElementById("phone"),
        email: document.getElementById("email"),
        guestName: document.getElementById("guestName"),
        guestPhone: document.getElementById("guestPhone"),
        guestEmail: document.getElementById("guestEmail"),
        checkIn: document.getElementById("checkIn"),
        checkOut: document.getElementById("checkOut"),
        adults: document.getElementById("adults"),
        children: document.getElementById("children"),
        note: document.getElementById("note"),
        isBookingForOthers: document.getElementById("isBookingForOthers")
    };

    /**
     * Hiển thị thông báo lỗi ngay dưới input
     */
    function showError(inputEl, message) {
        if (!inputEl) return;
        inputEl.classList.add("is-invalid");
        inputEl.style.setProperty("border-color", "#dc3545", "important");

        let parentNode = inputEl.parentNode;
        if (parentNode.classList.contains("input-group")) {
            parentNode = parentNode.parentNode;
        }

        let feedback = parentNode.querySelector("#" + inputEl.name + "Error")
            || parentNode.querySelector("#" + inputEl.id + "Error")
            || parentNode.querySelector(".validation-error, .invalid-feedback");

        if (!feedback) {
            feedback = document.createElement("div");
            feedback.className = "validation-error invalid-feedback";
            if (inputEl.id || inputEl.name) {
                feedback.id = (inputEl.id || inputEl.name) + "Error";
            }
            parentNode.appendChild(feedback);
        }
        feedback.textContent = message;
        feedback.style.color = "#dc3545";
        feedback.style.fontSize = "13px";
        feedback.style.marginTop = "4px";
        feedback.style.display = "block";
    }

    /**
     * Xóa viền đỏ và thông báo lỗi khi input hợp lệ
     */
    function clearError(inputEl) {
        if (!inputEl) return;
        inputEl.classList.remove("is-invalid");
        inputEl.style.removeProperty("border-color");

        let parentNode = inputEl.parentNode;
        if (parentNode.classList.contains("input-group")) {
            parentNode = parentNode.parentNode;
        }

        const feedback = parentNode.querySelector("#" + inputEl.name + "Error")
            || parentNode.querySelector("#" + inputEl.id + "Error")
            || parentNode.querySelector(".validation-error, .invalid-feedback");

        if (feedback) {
            feedback.textContent = "";
            feedback.style.display = "none";
        }
    }

    /**
     * 1. VALIDATE HỌ VÀ TÊN
     */
    function validateFullName() {
        const isOthers = fields.isBookingForOthers && fields.isBookingForOthers.checked;
        const targetInput = (isOthers && fields.guestName) ? fields.guestName : fields.fullName;
        if (!targetInput) return true;

        const val = targetInput.value.trim();

        if (!val) {
            showError(targetInput, "Họ và tên là phần bắt buộc");
            return false;
        }

        // Tên hợp lệ: Chữ tiếng Việt/Latin và khoảng trắng, không chứa số/ký tự đặc biệt
        const nameRegex = /^[a-zA-ZàáảãạâầấẩẫậăằắẳẵặèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđÀÁẢÃẠÂẦẤẨẪẬĂẰẮẲẴẶÈÉẺẼẸÊỀẾỂỄỆÌÍỈĨỊÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢÙÚỦŨỤƯỪỨỬỮỰỲÝỶỸỴĐ\s]+$/;
        if (!nameRegex.test(val)) {
            showError(targetInput, "Họ và tên không hợp lệ");
            return false;
        }

        clearError(targetInput);
        return true;
    }

    /**
     * 2. VALIDATE SỐ ĐIỆN THOẠI
     */
    function validatePhone() {
        const isOthers = fields.isBookingForOthers && fields.isBookingForOthers.checked;
        const targetInput = (isOthers && fields.guestPhone) ? fields.guestPhone : fields.phone;
        if (!targetInput) return true;

        const val = targetInput.value.trim();

        if (!val) {
            showError(targetInput, "Số điện thoại là phần bắt buộc");
            return false;
        }

        // SĐT Việt Nam: 10 số (03, 05, 07, 08, 09...) hoặc +84...
        const phoneRegex = /^(0|\+84)[3|5|7|8|9]\d{8}$/;
        if (!phoneRegex.test(val)) {
            showError(targetInput, "Số điện thoại không hợp lệ");
            return false;
        }

        clearError(targetInput);
        return true;
    }

    /**
     * 3. VALIDATE EMAIL
     */
    function validateEmail() {
        const isOthers = fields.isBookingForOthers && fields.isBookingForOthers.checked;
        const targetInput = (isOthers && fields.guestEmail && fields.guestEmail.value.trim()) ? fields.guestEmail : fields.email;
        if (!targetInput) return true;

        const val = targetInput.value.trim();

        if (!val) {
            if (targetInput === fields.email) {
                showError(targetInput, "Email là phần bắt buộc");
                return false;
            } else {
                clearError(targetInput);
                return true;
            }
        }

        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(val)) {
            showError(targetInput, "Email không đúng định dạng");
            return false;
        }

        clearError(targetInput);
        return true;
    }

    /**
     * 4. VALIDATE NGÀY NHẬN PHÒNG
     */
    function validateCheckIn() {
        if (!fields.checkIn) return true;
        const val = fields.checkIn.value;

        if (!val) {
            showError(fields.checkIn, "Ngày nhận phòng là phần bắt buộc");
            if (typeof window.calculateTotal === "function") window.calculateTotal();
            return false;
        }

        // Không cho chọn ngày trong quá khứ (so sánh YYYY-MM-DD)
        const now = new Date();
        const todayStr = now.getFullYear() + "-"
            + String(now.getMonth() + 1).padStart(2, "0") + "-"
            + String(now.getDate()).padStart(2, "0");

        if (val < todayStr) {
            showError(fields.checkIn, "Ngày nhận phòng không được ở quá khứ");
            if (typeof window.calculateTotal === "function") window.calculateTotal();
            return false;
        }

        clearError(fields.checkIn);

        // Nếu ngày trả phòng đã được chọn thì re-validate ngày trả phòng
        if (fields.checkOut && fields.checkOut.value) {
            validateCheckOut();
        }

        if (typeof window.calculateTotal === "function") window.calculateTotal();
        return true;
    }

    /**
     * 5. VALIDATE NGÀY TRẢ PHÒNG
     */
    function validateCheckOut() {
        if (!fields.checkOut) return true;
        const val = fields.checkOut.value;

        if (!val) {
            showError(fields.checkOut, "Ngày trả phòng là phần bắt buộc");
            if (typeof window.calculateTotal === "function") window.calculateTotal();
            return false;
        }

        if (fields.checkIn && fields.checkIn.value) {
            if (val <= fields.checkIn.value) {
                showError(fields.checkOut, "Ngày trả phòng phải sau ngày nhận phòng");
                if (typeof window.calculateTotal === "function") window.calculateTotal();
                return false;
            }
        }

        clearError(fields.checkOut);
        if (typeof window.calculateTotal === "function") window.calculateTotal();
        return true;
    }

    /**
     * 6. VALIDATE SỐ LƯỢNG NGƯỜI LỚN
     */
    function validateAdults() {
        if (!fields.adults) return true;
        const val = fields.adults.value.trim();

        if (!val) {
            showError(fields.adults, "Số lượng người lớn là phần bắt buộc");
            return false;
        }

        if (isNaN(val) || !/^-?\d+$/.test(val)) {
            showError(fields.adults, "Số lượng người lớn phải là số");
            return false;
        }

        const num = parseInt(val, 10);
        if (num <= 0) {
            showError(fields.adults, "Số lượng người lớn phải lớn hơn 0");
            return false;
        }

        clearError(fields.adults);
        return true;
    }

    /**
     * 7. VALIDATE SỐ LƯỢNG TRẺ EM
     */
    function validateChildren() {
        if (!fields.children) return true;
        const val = fields.children.value.trim();

        if (val === "") {
            clearError(fields.children);
            return true;
        }

        if (isNaN(val) || !/^-?\d+$/.test(val)) {
            showError(fields.children, "Số lượng trẻ em phải là số");
            return false;
        }

        const num = parseInt(val, 10);
        if (num < 0) {
            showError(fields.children, "Số lượng trẻ em không được nhỏ hơn 0");
            return false;
        }

        clearError(fields.children);
        return true;
    }

    /**
     * 8. VALIDATE YÊU CẦU ĐẶC BIỆT / GHI CHÚ
     */
    function validateNote() {
        if (!fields.note) return true;
        const val = fields.note.value;

        if (val.length > 500) {
            showError(fields.note, "Yêu cầu đặc biệt không được vượt quá 500 ký tự");
            return false;
        }

        clearError(fields.note);
        return true;
    }

    // Đăng ký sự kiện blur (rời ô) và input/change (khi gõ/sửa lại)
    const ruleList = [
        { el: fields.fullName, fn: validateFullName },
        { el: fields.phone, fn: validatePhone },
        { el: fields.email, fn: validateEmail },
        { el: fields.guestName, fn: validateFullName },
        { el: fields.guestPhone, fn: validatePhone },
        { el: fields.guestEmail, fn: validateEmail },
        { el: fields.checkIn, fn: validateCheckIn, events: ["change", "blur"] },
        { el: fields.checkOut, fn: validateCheckOut, events: ["change", "blur"] },
        { el: fields.adults, fn: validateAdults, events: ["input", "change", "blur"] },
        { el: fields.children, fn: validateChildren, events: ["input", "change", "blur"] },
        { el: fields.note, fn: validateNote, events: ["input", "change", "blur"] }
    ];

    ruleList.forEach(({ el, fn, events }) => {
        if (!el) return;
        const evts = events || ["blur", "input"];
        evts.forEach(evt => {
            el.addEventListener(evt, fn);
        });
    });

    if (fields.isBookingForOthers) {
        fields.isBookingForOthers.addEventListener("change", function () {
            if (!this.checked) {
                clearError(fields.guestName);
                clearError(fields.guestPhone);
                clearError(fields.guestEmail);
            }
            validateFullName();
            validatePhone();
            validateEmail();
        });
    }

    /**
     * SUBMIT FORM: Validate tất cả các trường
     */
    bookingForm.addEventListener("submit", function (e) {
        let isValid = true;
        let firstInvalidEl = null;

        const isOthers = fields.isBookingForOthers && fields.isBookingForOthers.checked;

        const checkList = [
            { el: isOthers ? fields.guestName : fields.fullName, valid: validateFullName() },
            { el: isOthers ? fields.guestPhone : fields.phone, valid: validatePhone() },
            { el: isOthers ? fields.guestEmail : fields.email, valid: validateEmail() },
            { el: fields.checkIn, valid: validateCheckIn() },
            { el: fields.checkOut, valid: validateCheckOut() },
            { el: fields.adults, valid: validateAdults() },
            { el: fields.children, valid: validateChildren() },
            { el: fields.note, valid: validateNote() }
        ];

        checkList.forEach(item => {
            if (!item.valid) {
                isValid = false;
                if (!firstInvalidEl && item.el) {
                    firstInvalidEl = item.el;
                }
            }
        });

        if (!isValid) {
            e.preventDefault();
            e.stopPropagation();

            const submitBtn = document.getElementById("submitButton");
            if (submitBtn) {
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fa-solid fa-circle-check me-1"></i> Xác nhận đặt phòng';
            }

            if (firstInvalidEl) {
                firstInvalidEl.focus();
            }
            return false;
        }
    });
});
