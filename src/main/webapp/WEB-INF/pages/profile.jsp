<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile | NPL Ticket Reservation</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #f0f2f5, #e6e9f0);
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .dashboard-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 30px;
            overflow-y: auto;
        }
        .dashboard-card {
            background: #ffffff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
            width: 100%;
            max-width: 1200px;
            min-height: calc(100vh - 100px);
        }
        .dashboard-header {
            grid-column: span 2;
            text-align: center;
            margin-bottom: 30px;
        }
        .dashboard-header h1 {
            font-size: 36px;
            font-weight: 700;
            color: #5a2ebc;
            letter-spacing: 1px;
        }
        .dashboard-header p {
            font-size: 16px;
            color: #666;
            font-weight: 500;
        }
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            display: none;
            align-items: center;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            position: fixed;
            top: 50px;
            left: calc(50vw - 200px);
            z-index: 1000;
        }
        .alert.show {
            display: flex;
        }
        .alert.success {
            background: #4caf50;
            color: white;
        }
        .alert.error {
            background: #f44336;
            color: white;
        }
        .alert svg {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }
        .alert .close-btn {
            margin-left: auto;
            cursor: pointer;
            font-size: 18px;
            color: white;
        }
        .alert .close-btn:hover {
            color: #ddd;
        }
        .section-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }
        .section-title {
            font-size: 24px;
            font-weight: 600;
            color: #5a2ebc;
            margin-bottom: 20px;
            text-align: left;
        }
        .profile-section {
            padding: 25px;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        }
        .profile-section.edit-mode {
            display: none;
        }
        .profile-section.form-mode {
            display: block;
        }
        .profile-picture {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 20px;
        }
        .profile-picture img {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #5a2ebc;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .profile-picture img:hover {
            transform: scale(1.05);
        }
        .profile-picture .fallback {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 4px solid #5a2ebc;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .profile-picture .fallback i {
            font-size: 60px;
            color: #5a2ebc;
        }
        .edit-icon {
            position: absolute;
            bottom: 10px;
            right: 10px;
            width: 36px;
            height: 36px;
            background: #5a2ebc;
            border: 2px solid #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .edit-icon:hover {
            background: #4527a0;
        }
        .edit-icon i {
            color: white;
            font-size: 16px;
        }
        .profile-info h3 {
            font-size: 32px;
            font-weight: 700;
            color: #5a2ebc;
            margin-bottom: 20px;
        }
        .profile-info p {
            font-size: 18px;
            color: #555;
            margin-bottom: 12px;
            line-height: 1.5;
        }
        .profile-info p span {
            font-weight: 600;
            color: #5a2ebc;
            margin-right: 10px;
        }
        .edit-btn, .save-btn, .cancel-btn {
            padding: 10px 25px;
            border: none;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .edit-btn {
            background: #5a2ebc;
            color: white;
        }
        .edit-btn:hover {
            background: #4527a0;
        }
        .save-btn {
            background: #5a2ebc;
            color: white;
        }
        .save-btn:hover {
            background: #4527a0;
        }
        .cancel-btn {
            background: #e0e0e0;
            color: #333;
            margin-left: 15px;
        }
        .cancel-btn:hover {
            background: #d0d0d0;
        }
        .profile-form {
            display: none;
        }
        .profile-form.active {
            display: block;
        }
        .profile-form input {
            width: 100%;
            max-width: 350px;
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        .profile-form input:focus {
            border-color: #5a2ebc;
            outline: none;
        }
        .profile-form input[type="file"] {
            padding: 10px 0;
        }
        .profile-form .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        .avatar-container {
            position: relative;
            margin-bottom: 20px;
            width: 150px;
            height: 150px;
        }
        .profile-avatar {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 50px;
            color: #5a2ebc;
            border: 3px solid #5a2ebc;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }
        .upload-icon {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 35px;
            height: 35px;
            background: #5a2ebc;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: white;
            font-size: 18px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }
        .upload-icon:hover {
            background: #4527a0;
        }
        .file-input {
            display: none;
        }
        .booking-card, .ticket-card, .match-card {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .booking-card:hover, .ticket-card:hover, .match-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        }
        .booking-card h4, .ticket-card h4, .match-card h4 {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        .booking-card p, .ticket-card p, .match-card p {
            font-size: 14px;
            color: #666;
            margin-bottom: 8px;
        }
        .booking-card .status, .ticket-card .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 12px;
            font-size: 12px;
            color: white;
        }
        .status-confirmed {
            background: #4caf50;
        }
        .status-pending {
            background: #ff9800;
        }
        .status-cancelled {
            background: #f44336;
        }
        .action-btn {
            padding: 8px 15px;
            background: #5a2ebc;
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 13px;
            cursor: pointer;
            margin-right: 10px;
            transition: background 0.3s ease;
        }
        .action-btn:hover {
            background: #4527a0;
        }
        .action-btn.cancel {
            background: #f44336;
        }
        .action-btn.cancel:hover {
            background: #d32f2f;
        }
        .no-data {
            text-align: center;
            color: #666;
            font-size: 16px;
            padding: 20px;
        }
        /* Enhanced Responsive Adjustments */
        @media (max-width: 1200px) {
            .dashboard-card {
                gap: 20px;
                padding: 20px;
                max-width: 1000px;
            }
            .dashboard-header h1 {
                font-size: 32px;
            }
            .section-title {
                font-size: 22px;
            }
            .profile-info h3 {
                font-size: 28px;
            }
            .profile-info p {
                font-size: 16px;
            }
            .booking-card h4, .ticket-card h4, .match-card h4 {
                font-size: 16px;
            }
            .booking-card p, .ticket-card p, .match-card p {
                font-size: 13px;
            }
        }
        @media (max-width: 1024px) {
            .dashboard-container {
                padding: 20px;
            }
            .dashboard-card {
                grid-template-columns: 1fr; /* Stack profile and sections vertically */
                grid-template-rows: auto auto; /* Ensure proper row distribution */
                gap: 20px;
                padding: 20px;
            }
            .dashboard-header {
                grid-column: span 1; /* Adjust for single column */
            }
            .profile-section {
                padding: 20px;
            }
            .profile-picture img, .profile-picture .fallback {
                width: 150px;
                height: 150px;
            }
            .profile-picture .fallback i {
                font-size: 50px;
            }
            .avatar-container {
                width: 120px;
                height: 120px;
            }
            .profile-avatar {
                font-size: 40px;
            }
            .upload-icon {
                width: 30px;
                height: 30px;
                font-size: 16px;
            }
            .section-card {
                padding: 15px;
            }
        }
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 15px;
            }
            .dashboard-card {
                padding: 15px;
                gap: 15px;
            }
            .dashboard-header h1 {
                font-size: 28px;
            }
            .dashboard-header p {
                font-size: 14px;
            }
            .section-title {
                font-size: 20px;
            }
            .profile-info h3 {
                font-size: 24px;
            }
            .profile-info p {
                font-size: 14px;
            }
            .booking-card, .ticket-card, .match-card {
                padding: 15px;
            }
            .booking-card h4, .ticket-card h4, .match-card h4 {
                font-size: 15px;
            }
            .booking-card p, .ticket-card p, .match-card p {
                font-size: 12px;
            }
            .action-btn {
                padding: 6px 12px;
                font-size: 12px;
            }
        }
        @media (max-width: 640px) {
            .dashboard-header h1 {
                font-size: 24px;
            }
            .dashboard-header p {
                font-size: 13px;
            }
            .section-title {
                font-size: 18px;
            }
            .profile-section {
                padding: 15px;
            }
            .profile-info h3 {
                font-size: 20px;
            }
            .profile-info p {
                font-size: 13px;
            }
            .profile-picture img, .profile-picture .fallback {
                width: 120px;
                height: 120px;
            }
            .profile-picture .fallback i {
                font-size: 40px;
            }
            .avatar-container {
                width: 100px;
                height: 100px;
            }
            .profile-avatar {
                font-size: 30px;
            }
            .upload-icon {
                width: 25px;
                height: 25px;
                font-size: 14px;
            }
            .profile-form input {
                max-width: 100%;
                padding: 10px;
                font-size: 13px;
            }
            .edit-btn, .save-btn, .cancel-btn {
                padding: 8px 20px;
                font-size: 13px;
            }
            .booking-card, .ticket-card, .match-card {
                padding: 12px;
            }
            .booking-card h4, .ticket-card h4, .match-card h4 {
                font-size: 14px;
            }
            .booking-card p, .ticket-card p, .match-card p {
                font-size: 11px;
            }
            .action-btn {
                padding: 5px 10px;
                font-size: 11px;
            }
            .alert {
                left: 15px;
                right: 15px;
                width: auto;
                max-width: none;
                padding: 10px 15px;
                font-size: 14px;
            }
            .alert svg {
                width: 18px;
                height: 18px;
            }
            .alert .close-btn {
                font-size: 16px;
            }
        }
        @media (max-width: 480px) {
            .dashboard-container {
                padding: 10px;
            }
            .dashboard-card {
                padding: 10px;
                gap: 10px;
            }
            .dashboard-header h1 {
                font-size: 20px;
            }
            .dashboard-header p {
                font-size: 12px;
            }
            .section-title {
                font-size: 16px;
                margin-bottom: 15px;
            }
            .profile-section {
                padding: 10px;
            }
            .profile-info h3 {
                font-size: 18px;
                margin-bottom: 15px;
            }
            .profile-info p {
                font-size: 12px;
                margin-bottom: 8px;
            }
            .profile-picture img, .profile-picture .fallback {
                width: 100px;
                height: 100px;
            }
            .profile-picture .fallback i {
                font-size: 30px;
            }
            .avatar-container {
                width: 80px;
                height: 80px;
            }
            .profile-avatar {
                font-size: 25px;
            }
            .upload-icon {
                width: 20px;
                height: 20px;
                font-size: 12px;
            }
            .profile-form input {
                padding: 8px;
                font-size: 12px;
            }
            .edit-btn, .save-btn, .cancel-btn {
                padding: 6px 15px;
                font-size: 12px;
            }
            .booking-card, .ticket-card, .match-card {
                padding: 10px;
                margin-bottom: 10px;
            }
            .booking-card h4, .ticket-card h4, .match-card h4 {
                font-size: 13px;
            }
            .booking-card p, .ticket-card p, .match-card p {
                font-size: 10px;
            }
            .action-btn {
                padding: 4px 8px;
                font-size: 10px;
                margin-right: 5px;
            }
            .no-data {
                font-size: 14px;
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="dashboard-card">
            <div class="dashboard-header">
                <h1>User Dashboard</h1>
                <p>Manage your profile and track your bookings and tickets</p>
            </div>

            <div class="alert ${not empty message ? messageType : ''} ${not empty message ? 'show' : ''}">
                <svg viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="${messageType == 'success' ? 'M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z' : 'M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.707a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.707z'}" clip-rule="evenodd"/>
                </svg>
                <p>${message}</p>
                <span class="close-btn" onclick="this.parentElement.classList.remove('show')">×</span>
            </div>

            <div class="profile-section" id="profileSection">
                <div class="profile-picture">
                    <c:choose>
                        <c:when test="${not empty sessionScope.image}">
                            <img src="${pageContext.request.contextPath}/${sessionScope.image}" alt="Profile Picture">
                        </c:when>
                        <c:otherwise>
                            <div class="fallback">
                                <i class="fas fa-user"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="profile-info">
                    <h3>${user.getFullName() != null ? user.getFullName() : 'Guest'}</h3>
                    <p><span>Email:</span> ${user.email}</p>
                    <p><span>Phone:</span> ${user.phoneNumber}</p>
                    <p><span>Address:</span> ${user.getAddress() != null ? user.address : 'Not provided'}</p>
                    <p><span>Joined:</span> ${user.createdAt}</p>
                    <button class="edit-btn" onclick="toggleEdit()">Edit Profile</button>
                </div>
            </div>

            <div class="profile-section profile-form" id="profileForm">
                <form action="${pageContext.request.contextPath}/profile" method="POST" enctype="multipart/form-data" id="profileFormElement">
                    <div class="avatar-container">
                        <div class="profile-avatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.image}">
                                    <img src="${pageContext.request.contextPath}/${sessionScope.image}" alt="Profile Picture">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-user"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <span class="upload-icon"><i class="fas fa-camera"></i></span>
                        <input type="file" id="image" name="image" class="file-input" accept="image/*" onchange="validateFileSize(this)">
                    </div>
                    <input type="text" name="fullName" value="${user.fullName}" required placeholder="Full Name">
                    <input type="email" name="email" value="${user.email}" required placeholder="Email">
                    <input type="text" name="phoneNumber" value="${user.phoneNumber}" required placeholder="Phone Number">
                    <input type="text" name="address" value="${user.getAddress()}" placeholder="Address">
                    <div class="btn-group">
                        <button type="submit" class="save-btn">Save Changes</button>
                        <button type="button" class="cancel-btn" onclick="toggleEdit()">Cancel</button>
                    </div>
                </form>
            </div>

            <div class="section-card">
                <h3 class="section-title">My Bookings</h3>
                <c:choose>
                    <c:when test="${not empty bookings}">
                        <c:forEach var="booking" items="${bookings}">
                            <div class="booking-card">
                                <h4>${booking.matchName}</h4>
                                <p><strong>Date:</strong> ${booking.date}</p>
                                <p><strong>Venue:</strong> ${booking.venue}</p>
                                <p><strong>Tickets:</strong> ${booking.ticketQuantity}</p>
                                <p><strong>Status:</strong> <span class="status status-${booking.status.toLowerCase()}">${booking.status}</span></p>
                                <div>
                                    <a href="${pageContext.request.contextPath}/booking/${booking.id}" class="action-btn">View Details</a>
                                    <c:if test="${booking.status == 'Pending'}">
                                        <a href="${pageContext.request.contextPath}/payment?bookingId=${booking.id}" class="action-btn">Confirm</a>
                                        <button type="button" class="action-btn cancel" onclick="cancelBooking(${booking.id})">Cancel</button>
                                        <form id="cancel-form-${booking.id}" action="${pageContext.request.contextPath}/mybookings" method="POST" style="display:none;">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="bookingId" value="${booking.id}">
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="no-data">No bookings found. <a href="${pageContext.request.contextPath}/book-tickets">Book now!</a></p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section-card">
                <h3 class="section-title">My Tickets</h3>
                <c:choose>
                    <c:when test="${not empty tickets}">
                        <c:forEach var="ticket" items="${tickets}">
                            <div class="ticket-card">
                                <h4>${ticket.matchName}</h4>
                                <p><strong>Date:</strong> ${ticket.date}</p>
                                <p><strong>Seat:</strong> ${ticket.seat}</p>
                                <p><strong>Status:</strong> <span class="status status-${ticket.status.toLowerCase()}">${ticket.status}</span></p>
                                <div>
                                    <a href="${pageContext.request.contextPath}/ticket/${ticket.id}" class="action-btn">View Ticket</a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="no-data">No tickets found.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section-card">
                <h3 class="section-title">Matches Attended</h3>
                <c:choose>
                    <c:when test="${not empty matchesAttended}">
                        <c:forEach var="match" items="${matchesAttended}">
                            <div class="match-card">
                                <h4>${match.teams}</h4>
                                <p><strong>Date:</strong> ${match.date}</p>
                                <p><strong>Venue:</strong> ${match.venue}</p>
                                <p><strong>Result:</strong> ${match.result}</p>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="no-data">No matches attended.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

<script>
    function toggleEdit() {
        const profileSection = document.getElementById('profileSection');
        const profileForm = document.getElementById('profileForm');
        profileForm.classList.toggle('active');
        profileSection.classList.toggle('edit-mode');
    }

    function validateFileSize(input) {
        const file = input.files[0];
        const avatar = document.querySelector('.profile-avatar');
        const maxSize = 10 * 1024 * 1024; // 10MB

        if (file) {
            if (file.size > maxSize) {
                showError('File size exceeds 10MB limit.');
                input.value = '';
                avatar.innerHTML = '<i class="fas fa-user"></i>';
                return;
            }
            const reader = new FileReader();
            reader.onload = (event) => {
                avatar.innerHTML = '';
                const img = document.createElement('img');
                img.src = event.target.result;
                img.style.width = '100%';
                img.style.height = '100%';
                img.style.objectFit = 'cover';
                img.style.borderRadius = '50%';
                avatar.appendChild(img);
            };
            reader.readAsDataURL(file);
        } else {
            avatar.innerHTML = '<i class="fas fa-user"></i>';
        }
    }

    function showError(message) {
        const alertDiv = document.querySelector('.alert');
        const alertMessage = alertDiv.querySelector('p');
        alertDiv.classList.remove('success');
        alertDiv.classList.add('error');
        alertMessage.textContent = message;
        alertDiv.classList.add('show');
        setTimeout(() => alertDiv.classList.remove('show'), 5000);
    }

    function cancelBooking(bookingId) {
        if (confirm('Are you sure you want to cancel this booking?')) {
            const form = document.getElementById(`cancel-form-${bookingId}`);
            if (form) form.submit();
        }
    }

    const uploadIcon = document.querySelector('.upload-icon');
    const fileInput = document.querySelector('.file-input');
    if (uploadIcon && fileInput) {
        uploadIcon.addEventListener('click', () => fileInput.click());
    }

    document.addEventListener('DOMContentLoaded', () => {
        const alert = document.querySelector('.alert');
        if (alert && alert.classList.contains('show')) {
            setTimeout(() => alert.classList.remove('show'), 5000);
        }
    });
</script>
</body>
</html>