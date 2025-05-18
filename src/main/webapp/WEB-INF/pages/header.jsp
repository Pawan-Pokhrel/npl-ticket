<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-Avb2QiuDEEvB4bZJYdft2mNjVShBftLdPG8FJ0V7irTLQ8Uo0qcPxh4Plq7G5tGm0rU+1SPhVotteLpBERet7yg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    .top-header {
        height: 80px;
        width: 100%;
        background: linear-gradient(135deg, rgba(106, 90, 205, 0.85), rgba(72, 61, 139, 0.85));
        backdrop-filter: blur(8px);
        -webkit-backdrop-filter: blur(8px);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 40px;
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .header-left {
        display: flex;
        align-items: center;
        gap: 20px;
        cursor: pointer; /* Indicate clickable area */
    }
    
    .header-left i {
    	display: none;
    }

    .logo-container {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .logo-container img {
        width: 50px;
        height: 50px;
        object-fit: contain;
        transition: transform 0.3s ease;
    }

    .logo-container img:hover {
        transform: rotate(360deg) scale(1.1);
    }

    .logo-container span {
        font-size: 24px;
        font-weight: 700;
        color: #ffffff;
        text-transform: uppercase;
        letter-spacing: 2px;
    }

    .search-bar {
        display: flex;
        align-items: center;
        background: rgba(255, 255, 255, 0.9);
        border-radius: 25px;
        padding: 8px 15px;
        width: 250px;
        border: 1px solid #d3d3fa;
        transition: box-shadow 0.3s ease;
    }

    .search-bar:hover {
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .search-bar input {
        border: none;
        background: transparent;
        color: #333;
        font-size: 14px;
        width: 100%;
        outline: none;
    }

    .search-bar input::placeholder {
        color: #666;
    }

    .search-bar i {
        color: #6a5acd;
        font-size: 16px;
        margin-right: 10px;
    }

    .header-right {
        display: flex;
        align-items: center;
        gap: 30px;
    }

    .nav-links {
        display: flex;
        gap: 20px;
        align-items: center;
    }

    .nav-links a {
        text-decoration: none;
        color: #ffffff;
        font-size: 16px;
        font-weight: 600;
        padding: 10px 15px;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .nav-links a:hover, .nav-links a.active {
        background: rgba(255, 255, 255, 0.2);
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .nav-links a.active {
        color: #ffd700; /* Yellow text for active state */
    }

    .user-container {
        display: flex;
        align-items: center;
        gap: 15px;
        position: relative;
        cursor: pointer;
    }

    .user-container img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #ffffff;
        transition: transform 0.3s ease;
    }

    .user-container img:hover {
        transform: scale(1.1);
    }

    .user-container span {
        font-size: 16px;
        color: #ffffff;
        font-weight: 600;
    }

    .user-container i {
        font-size: 14px;
        color: #ffffff;
    }

    .user-dropdown {
        display: none;
        position: absolute;
        top: 50px;
        right: 0;
        background: rgba(72, 61, 139, 0.95);
        border: 1px solid #d3d3fa;
        border-radius: 8px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        min-width: 160px;
        z-index: 999;
    }

    .user-dropdown a {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 12px 16px;
        color: #ffffff;
        text-decoration: none;
        transition: background 0.2s ease;
        font-size: 14px;
    }

    .user-dropdown a:hover {
        background: rgba(255, 255, 255, 0.2);
    }

    .mobile-toggle {
        display: none;
        font-size: 24px;
        cursor: pointer;
        color: #ffffff;
    }

    @media (max-width: 1365px) {
        .user-container span {
            display: none; /* Hide the "Welcome, [username]" text */
        }

        .user-container {
            gap: 5px; /* Reduce gap since text is hidden */
        }
    }

    @media (max-width: 1140px) {
        .nav-links {
            gap: 10px; /* Reduce gap between nav links */
        }

        .logo-container span {
            font-size: 20px; /* Reduce Ticket System text size */
        }
    }

    @media (max-width: 990px) {
        .logo-container span {
            display: none; /* Remove Ticket System text */
        }
    }

    @media (max-width: 768px) {
        .top-header {
            padding: 10px 20px;
            height: auto;
            gap: calc(100vw - 200px);
            position: relative;
        }

        .header-left, .header-right {
            width: 100%;
            flex-direction: column;
            align-items: center;
        }
        
        .header-left i {
        	display: block;
        }

        .search-bar {
            width: 100%;
            max-width: 300px;
            margin: 10px 0;
        }

        .nav-links {
            display: none;
            flex-direction: column;
            gap: 10px;
            width: 100%;
            background: rgba(72, 61, 139, 0.95);
            padding: 15px;
            position: absolute;
            top: 100%;
            left: 0;
            border-radius: 0 0 8px 8px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            transform: translateY(-10px);
            opacity: 0;
            transition: transform 0.3s ease, opacity 0.3s ease;
            z-index: 999;
        }

        .nav-links.active {
            display: flex;
            transform: translateY(0);
            opacity: 1;
        }

        .nav-links a {
            width: 100%;
            text-align: center;
        }

        .user-container {
            margin-top: 10px;
        }

        .mobile-toggle {
            display: block;
            margin-left: auto;
        }

        .user-dropdown {
            top: 50px;
            right: 0;
        }
    }

    @media (min-width: 769px) and (max-width: 1040px) {
        .top-header {
            padding: 0 20px;
        }

        .search-bar {
            width: 200px;
        }

        .nav-links {
            gap: 10px;
        }

        .nav-links a {
            font-size: 14px;
            padding: 8px 12px;
        }
    }

    @media (min-width: 769px) {
        .mobile-toggle {
            display: none;
        }

        .nav-links {
            display: flex;
        }
    }

    .debug-info {
        display: none; /* Uncomment 'display: block' to show debugging info */
        position: fixed;
        bottom: 10px;
        left: 10px;
        background: rgba(0, 0, 0, 0.7);
        color: white;
        padding: 10px;
        border-radius: 5px;
        font-size: 12px;
        z-index: 10000;
    }
</style>

<div class="top-header">
    <div class="header-left" onclick="window.location.href='${pageContext.request.contextPath}/'">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/images/NPL-text.png" alt="NPL Logo">
            <span>Ticket System</span>
            <i class="fas fa-bars mobile-toggle" id="menuToggle"></i>
        </div>
    </div>

    <div class="header-right">
        <div class="nav-links" id="navLinks">
            <c:set var="currentPath" value="${pageContext.request.requestURI}" />
            <!-- Check if the user role is admin using the role cookie -->
            <c:choose>
                <c:when test="${cookie.role.value == 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/" class="${currentPath.contains('/admin/') ? 'active' : ''}">Admin Portal</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/" class="${currentPath.contains('/index.jsp') || currentPath.endsWith('/') ? 'active' : ''}">Home</a>
                </c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath}/book-tickets" class="${currentPath.contains('/bookTicket') ? 'active' : ''}">Book Tickets</a>
            <a href="${pageContext.request.contextPath}/mybookings" class="${currentPath.contains('/myBookings') || currentPath.contains('/mybookings.jsp') ? 'active' : ''}">My Bookings</a>
            <a href="${pageContext.request.contextPath}/events" class="${currentPath.contains('/events') ? 'active' : ''}">Match Events</a>
            <a href="${pageContext.request.contextPath}/about" class="${currentPath.contains('/about') ? 'active' : ''}">About Us</a>
        </div>

        <div class="user-container" id="userToggle">
            <span>Welcome, <strong>${sessionScope.username != null ? sessionScope.username : 'Guest'}</strong></span>
            <c:choose>
                <c:when test="${not empty sessionScope.image}">
                    <img src="${pageContext.request.contextPath}/${sessionScope.image}" alt="User Image">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/default-user.png" alt="User Image">
                </c:otherwise>
            </c:choose>
            <i class="fas fa-chevron-down"></i>

            <div class="user-dropdown" id="userDropdown">
                <c:choose>
                    <c:when test="${sessionScope.username != null}">
                        <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> Profile</a>
                        <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> Login</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Debugging info (uncomment display in CSS to show) -->
<div class="debug-info">
    requestURI: ${currentPath}<br>
    servletPath: ${pageContext.request.servletPath}<br>
    contextPath: ${pageContext.request.contextPath}<br>
    role: ${cookie.role.value}<br>
    username: ${sessionScope.username}
</div>

<script>
    const userToggle = document.getElementById('userToggle');
    const userDropdown = document.getElementById('userDropdown');
    const menuToggle = document.getElementById('menuToggle');
    const navLinks = document.getElementById('navLinks');

    userToggle.addEventListener('click', () => {
        userDropdown.style.display = userDropdown.style.display === 'block' ? 'none' : 'block';
    });

    document.addEventListener('click', (e) => {
        if (!userToggle.contains(e.target)) {
            userDropdown.style.display = 'none';
        }
    });

    menuToggle.addEventListener('click', (e) => {
        e.stopPropagation(); // Prevent the header-left click from triggering
        navLinks.classList.toggle('active');
    });

    // Close mobile menu when clicking outside
    document.addEventListener('click', (e) => {
        if (!menuToggle.contains(e.target) && !navLinks.contains(e.target)) {
            navLinks.classList.remove('active');
        }
    });

    // Close mobile menu when a link is clicked
    navLinks.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', () => {
            navLinks.classList.remove('active');
        });
    });

    // Log for debugging
    console.log('requestURI: ${currentPath}');
    console.log('servletPath: ${pageContext.request.servletPath}');
    console.log('contextPath: ${pageContext.request.contextPath}');
    console.log('role: ${cookie.role.value}');
    console.log('username: ${sessionScope.username}');
</script>