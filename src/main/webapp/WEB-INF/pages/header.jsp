<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NPL Ticket Reservation - Header</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            margin: 0;
            padding: 0;
        }

        .top-header {
            height: 70px;
            width: 100%;
            background: #ffffff;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 24px;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-container img {
            width: 48px;
            height: 48px;
            object-fit: contain;
        }

        .logo-container span {
            font-size: 20px;
            font-weight: 700;
            color: #5d3fd3;
        }

        .user-container {
            position: relative;
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
        }

        .user-container img {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e0e0e0;
            transition: transform 0.3s ease;
        }

        .user-container img:hover {
            transform: scale(1.05);
        }

        .user-container span {
            font-size: 15px;
            color: #333;
            font-weight: 500;
        }

        .user-container i {
            font-size: 14px;
            color: #666;
        }

        .user-dropdown {
            display: none;
            position: absolute;
            top: 60px;
            right: 0;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1);
            min-width: 160px;
            z-index: 999;
        }

        .user-dropdown a {
            display: block;
            padding: 12px 16px;
            color: #333;
            text-decoration: none;
            transition: background 0.2s ease;
            font-size: 14px;
        }

        .user-dropdown a:hover {
            background-color: #f4f4f4;
        }

        .mobile-toggle {
            display: none;
            font-size: 24px;
            cursor: pointer;
            color: #5d3fd3;
        }

        @media (max-width: 768px) {
            .top-header {
                flex-direction: column;
                align-items: flex-start;
                height: auto;
                padding: 16px;
                gap: 12px;
            }

            .logo-container {
                justify-content: space-between;
                width: 100%;
            }

            .user-container {
                width: 100%;
                justify-content: space-between;
            }

            .mobile-toggle {
                display: block;
            }

            .user-dropdown {
                top: 52px;
                right: 12px;
            }
        }
    </style>
</head>
<body>

<!-- Top Header -->
<div class="top-header">
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/images/NPL-text.png" alt="NPL Logo">
        <span>Ticket System</span>
        <i class="fas fa-bars mobile-toggle" id="menuToggle"></i>
    </div>

    <div class="user-container" id="userToggle">
        <span>Welcome, <strong>${sessionScope.username != null ? sessionScope.username : 'Guest'}</strong></span>
        <img src="${pageContext.request.contextPath}/images/default-user.png" alt="User Profile">
        <i class="fas fa-chevron-down"></i>

        <div class="user-dropdown" id="userDropdown">
            <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> Profile</a>
            <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
</div>

<script>
    // Dropdown toggle
    const userToggle = document.getElementById('userToggle');
    const userDropdown = document.getElementById('userDropdown');

    userToggle.addEventListener('click', () => {
        userDropdown.style.display = userDropdown.style.display === 'block' ? 'none' : 'block';
    });

    // Close dropdown if clicked outside
    document.addEventListener('click', (e) => {
        if (!userToggle.contains(e.target)) {
            userDropdown.style.display = 'none';
        }
    });

    // Optional: Future menu toggle for mobile
    const menuToggle = document.getElementById('menuToggle');
    menuToggle?.addEventListener('click', () => {
        alert("Future sidebar toggle functionality can be implemented here.");
    });
</script>

</body>
</html>
