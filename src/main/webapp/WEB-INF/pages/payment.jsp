<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment | NPL Ticket Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { margin: 0; padding: 0; font-family: 'Poppins', sans-serif; background: #f4f6fa; }
        .main-content { margin: 0; padding: 30px 40px; min-height: calc(100vh - 60px - 60px); background: linear-gradient(to right, #eae6f9, #f5f7fa); }
        .main-content h1 { color: #5a2ebc; font-size: 28px; margin-bottom: 20px; }

        .alert { padding: 15px; border-radius: 12px; display: flex; align-items: center; width: 100%; max-width: 600px; margin: 0 auto 25px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); }
        .alert.success { background: #4caf50; color: white; }
        .alert.error { background: #f44336; color: white; }
        .alert svg { width: 20px; height: 20px; margin-right: 10px; }

        .payment-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); max-width: 600px; margin: 0 auto; }
        .payment-container h2 { font-size: 22px; color: #333; margin-bottom: 20px; }
        .payment-detail { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #eee; }
        .payment-detail label { font-weight: 600; color: #555; }
        .payment-detail span { color: #333; }

        .payment-form { margin-top: 20px; }
        .payment-form label { display: block; font-weight: 600; color: #555; margin-bottom: 8px; }
        .payment-form select, .payment-form input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px; margin-bottom: 15px; font-size: 14px; }
        .payment-form button { background: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; transition: background 0.3s; }
        .payment-form button.processing { background: #388E3C; cursor: not-allowed; }
        .payment-form button.processing i { margin-left: 5px; }

        .hidden { display: none; }

        /* Toast Notification Styles */
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #f44336;
            color: white;
            padding: 15px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            z-index: 1000;
            display: none;
            align-items: center;
            justify-content: space-between;
            max-width: 400px;
            opacity: 0;
            transition: opacity 0.3s ease, transform 0.3s ease;
            transform: translateY(-20px);
        }
        .toast.show {
            display: flex;
            opacity: 1;
            transform: translateY(0);
        }
        .toast .close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 18px;
            cursor: pointer;
            padding: 0 5px;
            margin-left: 10px;
        }
        .toast .close-btn:hover {
            color: #ddd;
        }
    </style>
</head>
<body>

<div class="main-content">
    <h1>Payment</h1>

    <c:if test="${not empty message}">
        <div class="alert ${messageType}">
            <svg viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="${messageType == 'success' ? 'M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z' : 'M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.707a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.707z'}" clip-rule="evenodd"/>
            </svg>
            <p>${message}</p>
        </div>
    </c:if>

    <div class="payment-container">
        <h2>Booking Details</h2>
        <div class="payment-detail">
            <label>Match:</label>
            <span>${booking.team1} vs ${booking.team2}</span>
        </div>
        <div class="payment-detail">
            <label>Date:</label>
            <span>${booking.date}</span>
        </div>
        <div class="payment-detail">
            <label>Venue:</label>
            <span>${booking.venue}</span>
        </div>
        <div class="payment-detail">
            <label>Tickets:</label>
            <span>${booking.tickets}</span>
        </div>
        <div class="payment-detail">
            <label>Amount:</label>
            <span>Rs. ${booking.tickets * 1000}</span>
        </div>

        <form class="payment-form" action="${pageContext.request.contextPath}/payment" method="POST" onsubmit="return handleSubmit(event)">
            <input type="hidden" name="bookingId" value="${booking.bookingId}">
            <label for="paymentMethod">Payment Method:</label>
            <select id="paymentMethod" name="paymentMethod" onchange="updatePaymentFields()" required>
                <option value="" disabled selected>Select Payment Method</option>
                <option value="Debit Card">Debit Card</option>
                <option value="Bank Transfer">Bank Transfer</option>
                <option value="FonePay">FonePay</option>
                <option value="Esewa">Esewa</option>
                <option value="Khalti">Khalti</option>
                <option value="ImePay">ImePay</option>
            </select>

            <!-- Debit Card Fields -->
            <div id="debitCardFields" class="hidden">
                <label for="debitCardNumber">Debit Card Number:</label>
                <input type="text" id="debitCardNumber" name="debitCardNumber" placeholder="Enter 16-digit card number" maxlength="16">
                <label for="securityCode">Security Code:</label>
                <input type="password" id="securityCode" name="securityCode" placeholder="Enter 3-digit security code" maxlength="3">
            </div>

            <!-- Bank Transfer Fields -->
            <div id="bankTransferFields" class="hidden">
                <label for="bankName">Name of Bank:</label>
                <input type="text" id="bankName" name="bankName" placeholder="Enter bank name">
                <label for="bankUsername">Username (Account Holder Name):</label>
                <input type="text" id="bankUsername" name="bankUsername" placeholder="Enter username">
                <label for="bankPassword">Password:</label>
                <input type="password" id="bankPassword" name="bankPassword" placeholder="Enter password (min 8 characters)">
            </div>

            <!-- FonePay and ImePay Fields -->
            <div id="fonePayFields" class="hidden">
                <label for="fonePayUsername">Username:</label>
                <input type="text" id="fonePayUsername" name="fonePayUsername" placeholder="Enter username">
                <label for="fonePayPassword">Password:</label>
                <input type="password" id="fonePayPassword" name="fonePayPassword" placeholder="Enter password (min 8 characters)">
            </div>

            <!-- Esewa and Khalti Fields -->
            <div id="esewaFields" class="hidden">
                <label for="esewaIdentifier">Email or Phone Number:</label>
                <input type="text" id="esewaIdentifier" name="esewaIdentifier" placeholder="Enter email or 10-digit phone number">
                <label for="esewaPassword">Password:</label>
                <input type="password" id="esewaPassword" name="esewaPassword" placeholder="Enter password (min 8 characters)">
            </div>

            <button type="submit" id="payButton">Pay Now</button>
        </form>
    </div>

    <!-- Toast Notification -->
    <div class="toast" id="toast">
        <span id="toastMessage"></span>
        <button class="close-btn" onclick="hideToast()">×</button>
    </div>
</div>

<script>
    function updatePaymentFields() {
        const paymentMethod = document.getElementById("paymentMethod").value;
        document.getElementById("debitCardFields").classList.add("hidden");
        document.getElementById("bankTransferFields").classList.add("hidden");
        document.getElementById("fonePayFields").classList.add("hidden");
        document.getElementById("esewaFields").classList.add("hidden");

        if (paymentMethod === "Debit Card") {
            document.getElementById("debitCardFields").classList.remove("hidden");
            setRequiredFields(["debitCardNumber", "securityCode"]);
        } else if (paymentMethod === "Bank Transfer") {
            document.getElementById("bankTransferFields").classList.remove("hidden");
            setRequiredFields(["bankName", "bankUsername", "bankPassword"]);
        } else if (paymentMethod === "FonePay" || paymentMethod === "ImePay") {
            document.getElementById("fonePayFields").classList.remove("hidden");
            setRequiredFields(["fonePayUsername", "fonePayPassword"]);
        } else if (paymentMethod === "Esewa" || paymentMethod === "Khalti") {
            document.getElementById("esewaFields").classList.remove("hidden");
            setRequiredFields(["esewaIdentifier", "esewaPassword"]);
        }
    }

    function setRequiredFields(fieldIds) {
        const allFields = ["debitCardNumber", "securityCode", "bankName", "bankUsername", "bankPassword", "fonePayUsername", "fonePayPassword", "esewaIdentifier", "esewaPassword"];
        allFields.forEach(field => {
            const element = document.getElementById(field);
            if (fieldIds.includes(field)) {
                element.setAttribute("required", "required");
            } else {
                element.removeAttribute("required");
            }
        });
    }

    function showToast(message) {
        const toast = document.getElementById("toast");
        const toastMessage = document.getElementById("toastMessage");
        toastMessage.textContent = message;
        toast.classList.add("show");
        setTimeout(hideToast, 3000); // Hide after 3 seconds
    }

    function hideToast() {
        const toast = document.getElementById("toast");
        toast.classList.remove("show");
    }

    function validateForm() {
        const paymentMethod = document.getElementById("paymentMethod").value;

        // Validate identifier field for all methods (first in form order)
        let identifierField;
        if (paymentMethod === "Debit Card") {
            identifierField = document.getElementById("debitCardNumber");
        } else if (paymentMethod === "Bank Transfer") {
            identifierField = document.getElementById("bankUsername");
        } else if (paymentMethod === "FonePay" || paymentMethod === "ImePay") {
            identifierField = document.getElementById("fonePayUsername");
        } else if (paymentMethod === "Esewa" || paymentMethod === "Khalti") {
            identifierField = document.getElementById("esewaIdentifier");
        }

        if (identifierField && !identifierField.value.trim()) {
            showToast("Please fill in the identifier field for " + paymentMethod + ".");
            return false;
        }

        // Validate email or phone number for Esewa and Khalti (before password)
        if (paymentMethod === "Esewa" || paymentMethod === "Khalti") {
            const identifier = document.getElementById("esewaIdentifier").value.trim();
            const isNumeric = /^\d+$/.test(identifier);
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (isNumeric) {
                if (identifier.length !== 10) {
                    showToast("Phone number must be exactly 10 digits.");
                    return false;
                }
            } else if (!emailRegex.test(identifier)) {
                showToast("Invalid email format. Please enter a valid email or 10-digit phone number.");
                return false;
            }
        }

        // Validate Debit Card specific fields
        if (paymentMethod === "Debit Card") {
            const cardNumber = document.getElementById("debitCardNumber").value;
            const securityCode = document.getElementById("securityCode").value;

            if (!/^\d{16}$/.test(cardNumber)) {
                showToast("Debit Card Number must be exactly 16 digits.");
                return false;
            }

            if (!/^\d{3}$/.test(securityCode)) {
                showToast("Security Code must be exactly 3 digits.");
                return false;
            }
        }

        // Validate password length for methods requiring passwords (last in form order)
        let passwordField;
        if (paymentMethod === "Bank Transfer") {
            passwordField = document.getElementById("bankPassword");
        } else if (paymentMethod === "FonePay" || paymentMethod === "ImePay") {
            passwordField = document.getElementById("fonePayPassword");
        } else if (paymentMethod === "Esewa" || paymentMethod === "Khalti") {
            passwordField = document.getElementById("esewaPassword");
        }

        if (passwordField && passwordField.value.length < 8) {
            showToast("Password must be at least 8 characters long for " + paymentMethod + ".");
            return false;
        }

        return true;
    }

    async function handleSubmit(event) {
        event.preventDefault();
        if (validateForm()) {
            const button = document.getElementById("payButton");
            button.innerHTML = "Processing <i class='fas fa-spinner fa-spin'></i>";
            button.classList.add("processing");
            button.disabled = true;

            // Introduce 2-second delay
            await new Promise(resolve => setTimeout(resolve, 2000));

            // Log form data and submit
            const form = document.querySelector(".payment-form");
            console.log("Form Data:", Object.fromEntries(new FormData(form)));
            form.submit();
        }
    }
</script>

<%@ include file="footer.jsp" %>
</body>
</html>