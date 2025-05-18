<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="user-sidebar">
    <div class="user-profile">
        <c:choose>
            <c:when test="${not empty sessionScope.image}">
                <img src="${pageContext.request.contextPath}/${sessionScope.image}" alt="User Image" class="profile-image">
            </c:when>
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/images/default-user.png" alt="User Image" class="profile-image">
            </c:otherwise>
        </c:choose>
        <p class="username">${sessionScope.username != null ? sessionScope.username : 'Guest'}</p>
        <h2>
            <img src="${pageContext.request.contextPath}/images/NPL-text.png" alt="NPL Logo">
            <span>Admin</span>
        </h2>
    </div>

    <div class="nav-section">
        <p class="section-title">MAIN</p>
        <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/manage-tickets"><i class="fas fa-ticket-alt"></i> Manage Tickets</a>
        <a href="${pageContext.request.contextPath}/admin/ticket-types"><i class="fas fa-calendar-alt"></i> Ticket Types</a>
        <a href="${pageContext.request.contextPath}/admin/manage-matches"><i class="fas fa-info-circle"></i> Manage Matches</a>
        <a href="${pageContext.request.contextPath}/admin/manage-users"><i class="fas fa-users"></i> Manage Users</a>
        <a href="${pageContext.request.contextPath}/admin/view-payments"><i class="fas fa-money-bill-wave"></i> View Payments</a>
    </div>

    <div class="nav-section">
        <p class="section-title">ACCOUNT</p>
        <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-cog"></i> Profile Settings</a>
    </div>

    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>
</div>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .user-sidebar {
        position: fixed;
        top: 70px;
        left: 0;
        height: calc(100vh - 70px);
        width: 250px;
        background: linear-gradient(180deg, #6e4b8c, #bfa2d1);
        border-right: 1px solid #e0e0e0;
        padding: 20px 10px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
    }

    .user-profile {
        text-align: center;
        margin-bottom: 30px;
    }

    .user-profile h2 {
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
    }

    .user-profile h2 img {
        width: 60px;
    }

    .profile-image {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #fff;
        margin-bottom: 10px;
        transition: transform 0.3s ease;
    }

    .profile-image:hover {
        transform: scale(1.05);
    }

    .username {
        font-weight: 600;
        color: #fff;
    }

    .nav-section {
        margin-bottom: 30px;
    }

    .section-title {
        font-size: 12px;
        color: #e6e6e6;
        margin-bottom: 10px;
        padding-left: 5px;
        text-transform: uppercase;
        font-weight: 500;
    }

    .nav-section a {
        display: flex;
        align-items: center;
        gap: 14px;
        padding: 10px 15px;
        margin-bottom: 8px;
        border-radius: 8px;
        text-decoration: none;
        color: #fff;
        font-size: 15px;
        transition: background-color 0.3s ease, transform 0.3s ease;
    }

    .nav-section a:hover {
        background-color: #9b7ce6;
        transform: scale(1.05);
    }

    .logout-btn {
        margin-top: auto;
        background-color: #e74c3c;
        color: #fff;
        text-align: center;
        padding: 12px 0;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 500;
        transition: background 0.3s ease;
    }

    .logout-btn:hover {
        background-color: #c0392b;
    }

    .nav-section i,
    .logout-btn i {
        font-size: 16px;
    }
</style>