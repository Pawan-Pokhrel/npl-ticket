<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #fff;
        }

        .sidebar {
            position: fixed;
            top: 70px;
            left: 0;
            height: calc(100vh - 70px);
            width: 250px;
            background-color: #ffffff;
            border-right: 1px solid #e0e0e0;
            padding: 20px 0;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
        }

        .user-info {
            text-align: center;
            margin-bottom: 20px;
        }

        .user-info .avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
            overflow: hidden;
            border: 2px solid #3366ff;
        }

        .user-info .avatar i {
            font-size: 40px;
            color: #333;
        }

        .user-info .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .user-info h3 {
            font-size: 16px;
            color: #333;
            font-weight: 600;
        }

        .section {
            padding: 0 20px;
        }

        .section-title-nav {
            font-size: 12px;
            text-transform: uppercase;
            color: #999;
            margin: 20px 0 10px;
            font-weight: 500;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: #444;
            padding: 10px 12px;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.2s ease;
        }

        .nav-link i {
            font-size: 16px;
        }

        .nav-link:hover {
            background-color: #f0f4ff;
            color: #3366ff;
        }

        .bottom-links {
            padding: 0 20px 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .logout-btn {
            background-color: #ff4d4f;
            color: white;
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            font-weight: 500;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #d9363e;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div>
        <div class="user-info">
            <div class="avatar">
			    <c:choose>
			        <c:when test="${not empty sessionScope.image}">
			            <img src="${pageContext.request.contextPath}/${sessionScope.image}" alt="User Image">
			        </c:when>
			        <c:otherwise>
			            <i class="fas fa-user"></i>
			        </c:otherwise>
			    </c:choose>
			</div>
            <h3>
                <c:choose>
                    <c:when test="${not empty sessionScope.username}">
                        ${sessionScope.username}
                    </c:when>
                    <c:otherwise>
                        Guest
                    </c:otherwise>
                </c:choose>
            </h3>
        </div>

        <div class="section">
            <div class="section-title-nav">Main</div>
            <a href="${pageContext.request.contextPath}/" class="nav-link"><i class="fas fa-house"></i> Home</a>
            <a href="${pageContext.request.contextPath}/mybookings" class="nav-link"><i class="fas fa-ticket-alt"></i> My Bookings</a>
            <a href="${pageContext.request.contextPath}/events" class="nav-link"><i class="fas fa-calendar-day"></i> Match Events</a>
            <a href="${pageContext.request.contextPath}/about" class="nav-link"><i class="fas fa-info-circle"></i> About Us</a>
        </div>

        <div class="section">
            <div class="section-title-nav">Account</div>
            <a href="${pageContext.request.contextPath}/profile" class="nav-link"><i class="fas fa-user-cog"></i> Profile Settings</a>
        </div>
    </div>

    <div class="bottom-links">
        <c:choose>
            <c:when test="${not empty sessionScope.username}">
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="logout-btn"><i class="fas fa-sign-in-alt"></i> Login</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>

