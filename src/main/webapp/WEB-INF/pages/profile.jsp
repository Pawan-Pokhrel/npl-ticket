<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<%@ include file="user-navbar.jsp" %>

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
            background: linear-gradient(to right, #eae6f9, #f5f7fa);
            color: #333;
            display: flex;
            flex-direction: column;
        }
        .dashboard-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            overflow-y: auto;
        }
        .dashboard-card {
            background: linear-gradient(135deg, #e2e0f5, #f0ecfa);
            padding: 20px;
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 40px;
            width: calc(100vw - 250px);
            max-width: 100%;
            height: calc(100vh - 70px);
            overflow: hidden;
            margin-left: 250px;
        }
        .dashboard-header {
            text-align: center;
            grid-column: span 2;
            margin-bottom: 30px;
        }
        .dashboard-header h1 {
            font-size: 32px;
            font-weight: 700;
            color: #7e3ff2;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }
        .dashboard-header p {
            font-size: 16px;
            color: #666;
            font-weight: 500;
        }
        .alert {
            padding: 15px;
            border-radius: 12px;
            display: none;
            align-items: center;
            width: 100%;
            max-width: 600px;
            grid-column: span 2;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: absolute;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
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
            font-size: 16px;
            line-height: 20px;
            color: white;
        }
        .alert .close-btn:hover {
            color: #ddd;
        }
        .section-card {
            background: #f0ecfa;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 6px 18px rgba(122, 82, 255, 0.1);
        }
        .section-title {
            font-size: 22px;
            font-weight: 600;
            color: #7e3ff2;
            margin-bottom: 20px;
            text-align: left;
        }
        .profile-section {
            padding: 30px;
            background: linear-gradient(135deg, #e2e0f5, #f0ecfa);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(122, 82, 255, 0.1);
            position: relative;
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
            margin-bottom: 25px;
            position: relative;
            width: fit-content;
        }
        .profile-picture img {
            width: 250px;
            height: 250px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #a08be0;
            box-shadow: 0 0 20px rgba(160, 139, 224, 0.3);
        }
        .profile-picture .fallback {
            width: 250px;
            height: 250px;
            border-radius: 50%;
            background: #f0ecfa;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 5px solid #a08be0;
            box-shadow: 0 0 20px rgba(160, 139, 224, 0.3);
        }
        .profile-picture .fallback i {
            font-size: 80px;
            color: #7e3ff2;
        }
        .edit-icon {
            position: absolute;
            bottom: 10px;
            right: 14px;
            width: 40px;
            height: 40px;
            background: #7e3ff2;
            border: 3px solid #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .profile-form:not(.active) .edit-icon {
            display: none;
        }
        .edit-icon i {
            color: white;
            font-size: 18px;
        }
        .profile-info, .profile-form {
            text-align: left;
            max-width: 100%;
        }
        .profile-info h3 {
            font-size: 40px;
            font-weight: 700;
            background: linear-gradient(90deg, #7e3ff2, #a08be0);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 25px;
        }
        .profile-info p {
            font-size: 20px;
            color: #666;
            margin-bottom: 15px;
            line-height: 1.6;
        }
        .profile-info p span {
            font-weight: 600;
            color: #7e3ff2;
            margin-right: 12px;
        }
        .edit-btn {
            padding: 12px 30px;
            background: #7e3ff2;
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }
        .save-btn, .cancel-btn {
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }
        .save-btn {
            background: #7e3ff2;
            color: white;
        }
        .cancel-btn {
            background: #e0e0e0;
            color: #333;
            margin-left: 20px;
        }
        .profile-form {
            display: none;
        }
        .profile-form.active {
            display: block;
        }
        .profile-form input {
            width: 100%;
            max-width: 400px;
            padding: 12px 18px;
            margin: 10px 0;
            border: 2px solid #ccc;
            border-radius: 12px;
            font-size: 16px;
        }
        .profile-form input:focus {
            border-color: #7e3ff2;
            outline: none;
        }
        .profile-form input[type="file"] {
            padding: 12px 0;
        }
        .profile-form .btn-group {
            display: flex;
            justify-content: flex-start;
            gap: 20px;
            margin-top: 20px;
        }
        .item {
            background: #f0ecfa;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 15px;
            box-shadow: 0 4px 12px rgba(122, 82, 255, 0.1);
        }
        .item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
        }
        .item-header p {
            font-size: 17px;
            font-weight: 500;
            color: #333;
        }
        .item-header span {
            font-size: 14px;
            color: #7e3ff2;
            font-weight: 500;
        }
        .item-details {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.4s ease;
        }
        .item-details.open {
            max-height: 200px;
        }
        .item-details p {
            font-size: 15px;
            color: #666;
            margin-top: 10px;
            line-height: 1.6;
        }
        .item-details a {
            color: #3366ff;
            text-decoration: none;
            font-weight: 600;
        }
        .action-btn {
            padding: 8px 15px;
            background: #7e3ff2;
            color: white;
            border: none;
            border-radius: 18px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
        }
        .avatar-container {
            position: relative;
            margin-bottom: 20px;
            width: 230px;
            height: 230px;
            transition: transform 0.3s ease;
        }
        .avatar-container:hover {
            transform: scale(1.05);
        }
        .profile-avatar {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
            color: #7e3ff2;
            border: 4px solid #7e3ff2;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
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
            bottom: 8px;
            right: 8px;
            width: 40px;
            height: 40px;
            background: #7e3ff2;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: white;
            font-size: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            transition: background 0.3s ease;
        }
        .upload-icon:hover {
            background: #5a2ebc;
        }
        .file-input {
            display: none;
        }
        @media (max-width: 1024px) {
            .dashboard-container {
                margin-left: 0;
                width: 100vw;
                padding: 30px 15px;
            }
            .dashboard-card {
                grid-template-columns: 1fr;
                padding: 25px;
            }
            .profile-picture img, .profile-picture .fallback {
                width: 180px;
                height: 180px;
            }
            .profile-picture .fallback i {
                font-size: 70px;
            }
            .edit-icon {
                width: 35px;
                height: 35px;
            }
            .edit-icon i {
                font-size: 16px;
            }
            .profile-form input {
                max-width: 100%;
            }
            .avatar-container {
                width: 150px;
                height: 150px;
            }
            .profile-avatar {
                font-size: 50px;
            }
            .upload-icon {
                width: 35px;
                height: 35px;
                font-size: 18px;
            }
        }
        @media (max-width: 640px) {
            .dashboard-header h1 {
                font-size: 24px;
            }
            .section-title {
                font-size: 20px;
            }
            .profile-info h3 {
                font-size: 32px;
            }
            .profile-info p {
                font-size: 18px;
            }
            .profile-picture img, .profile-picture .fallback {
                width: 150px;
                height: 150px;
            }
            .profile-picture .fallback i {
                font-size: 60px;
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
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="dashboard-card">
            <div class="alert ${not empty message ? messageType : ''} ${not empty message ? 'show' : ''}">
                <svg viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="${messageType == 'success' ? 'M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z' : 'M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.707a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.707z'}" clip-rule="evenodd"/>
                </svg>
                <p>${message}</p>
                <span class="close-btn" onclick="this.parentElement.classList.remove('show')">&times;</span>
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
                            <div class="item">
                                <div class="item-header" onclick="toggleDetails(this)">
                                    <p>${booking.matchName}</p>
                                    <span>${booking.status}</span>
                                </div>
                                <div class="item-details">
                                    <p><strong>Date:</strong> ${booking.date}</p>
                                    <p><strong>Venue:</strong> ${booking.venue}</p>
                                    <p><a href="${pageContext.request.contextPath}/booking/${booking.id}">View Details</a></p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="text-align: center; color: #666;">No bookings found.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section-card">
                <h3 class="section-title">My Tickets</h3>
                <c:choose>
                    <c:when test="${not empty tickets}">
                        <c:forEach var="ticket" items="${tickets}">
                            <div class="item">
                                <div class="item-header" onclick="toggleDetails(this)">
                                    <p>${ticket.matchName}</p>
                                    <span>${ticket.status}</span>
                                </div>
                                <div class="item-details">
                                    <p><strong>Date:</strong> ${ticket.date}</p>
                                    <p><strong>Seat:</strong> ${ticket.seat}</p>
                                    <p><a href="${pageContext.request.contextPath}/ticket/${ticket.id}">View Ticket</a></p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="text-align: center; color: #666;">No tickets found.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section-card">
                <h3 class="section-title">Matches Attended</h3>
                <c:choose>
                    <c:when test="${not empty matchesAttended}">
                        <c:forEach var="match" items="${matchesAttended}">
                            <div class="item">
                                <div class="item-header" onclick="toggleDetails(this)">
                                    <p>${match.teams}</p>
                                    <span>${match.date}</span>
                                </div>
                                <div class="item-details">
                                    <p><strong>Venue:</strong> ${match.venue}</p>
                                    <p><strong>Result:</strong> ${match.result}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="text-align: center; color: #666;">No matches attended.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

<script>
    function toggleEdit() {
        const profileSection = document.getElementById('profileSection');
        const profileForm = document.getElementById('profileForm');

        if (profileForm.classList.contains('active')) {
            profileForm.classList.remove('active');
            profileSection.classList.remove('edit-mode');
            profileSection.classList.add('form-mode');
        } else {
            profileForm.classList.add('active');
            profileSection.classList.remove('form-mode');
            profileSection.classList.add('edit-mode');
        }
    }

    function toggleDetails(header) {
        const details = header.nextElementSibling;
        details.classList.toggle('open');
    }

    function validateFileSize(input) {
        const file = input.files[0];
        const avatar = document.querySelector('.profile-avatar');
        const maxSize = 10 * 1024 * 1024; // 10MB in bytes

        if (file) {
            if (file.size > maxSize) {
                showError('File size exceeds 10MB limit. Please select a smaller file.');
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
        console.log('Showing error: ' + message);
        setTimeout(() => {
            alertDiv.classList.remove('show');
            console.log('Error hidden');
        }, 5000);
    }

    const uploadIcon = document.querySelector('.upload-icon');
    const fileInput = document.querySelector('.file-input');

    if (uploadIcon && fileInput) {
        uploadIcon.addEventListener('click', () => {
            fileInput.click();
        });
    }

    // Auto-hide alert after 5 seconds if it exists
    document.addEventListener('DOMContentLoaded', () => {
        const alert = document.querySelector('.alert');
        if (alert.classList.contains('show')) {
            console.log('Alert found with message: ' + alert.querySelector('p').textContent);
            setTimeout(() => {
                alert.classList.remove('show');
                console.log('Alert hidden');
            }, 5000);
        } else {
            console.log('No alert visible on page load');
        }
    });
</script>
</body>
</html>