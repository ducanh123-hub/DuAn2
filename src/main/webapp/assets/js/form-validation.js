/**
 * Universal Touched-Based Form Validation Module - Luxury Hotel
 */

function createFormValidator(formElement, rules) {
    if (!formElement) return null;

    // Tắt HTML5 default validation tooltips để dùng custom UI
    formElement.setAttribute("novalidate", "true");

    const touchedFields = new Set();

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

    function validateField(fieldName) {
        const rule = rules[fieldName];
        if (!rule) return true;

        const inputEl = formElement.querySelector(`[name='${fieldName}']`) || document.getElementById(fieldName);
        if (!inputEl) return true;

        const errorMsg = rule(inputEl, formElement);

        if (errorMsg) {
            if (touchedFields.has(fieldName)) {
                showError(inputEl, errorMsg);
            }
            return false;
        } else {
            clearError(inputEl);
            return true;
        }
    }

    // Đăng ký sự kiện blur và input/change cho từng field
    Object.keys(rules).forEach(fieldName => {
        const inputEl = formElement.querySelector(`[name='${fieldName}']`) || document.getElementById(fieldName);
        if (!inputEl) return;

        inputEl.addEventListener("blur", function () {
            touchedFields.add(fieldName);
            validateField(fieldName);
        });

        inputEl.addEventListener("input", function () {
            if (touchedFields.has(fieldName) || inputEl.classList.contains("is-invalid")) {
                validateField(fieldName);
            }

            // Nếu là password thì đồng thời re-validate confirmPassword nếu confirmPassword đã được touched
            if (fieldName === "password" && rules.confirmPassword && touchedFields.has("confirmPassword")) {
                validateField("confirmPassword");
            }
        });

        inputEl.addEventListener("change", function () {
            if (touchedFields.has(fieldName) || inputEl.classList.contains("is-invalid")) {
                validateField(fieldName);
            }
        });
    });

    // Sự kiện Submit form
    formElement.addEventListener("submit", function (e) {
        let isValid = true;
        let firstInvalidEl = null;

        Object.keys(rules).forEach(fieldName => {
            const inputEl = formElement.querySelector(`[name='${fieldName}']`) || document.getElementById(fieldName);

            // Kiểm tra xem field có đang hiển thị hay không (ví dụ trường ẩn của đặt hộ)
            if (inputEl && inputEl.offsetParent !== null) {
                touchedFields.add(fieldName);
                const isFieldValid = validateField(fieldName);

                if (!isFieldValid) {
                    isValid = false;
                    if (!firstInvalidEl) {
                        firstInvalidEl = inputEl;
                    }
                }
            }
        });

        if (!isValid) {
            e.preventDefault();
            e.stopPropagation();

            if (firstInvalidEl) {
                firstInvalidEl.scrollIntoView({ behavior: "smooth", block: "center" });
                firstInvalidEl.focus();
            }
            return false;
        }
    });

    return { validateField, touchedFields, showError, clearError };
}
