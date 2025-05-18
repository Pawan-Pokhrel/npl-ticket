<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<%@ include file="admin-navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');

        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, white 20%, #bfa2d1 80%);
            color: #2e2e2e;
        }

        .content-wrapper {
            margin-left: 250px;
            padding: 30px;
            min-height: 100vh;
            background-color: #f9f8ff;
        }

        .page-title-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 26px;
            font-weight: 600;
            color: #5a2ebc;
        }

        .search-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-bar {
            padding: 8px 15px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            width: 300px;
            transition: 0.2s;
        }

        .search-bar:focus {
            border-color: #6c47d9;
            outline: none;
        }

        .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .rows-per-page {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .rows-per-page label {
            font-size: 15px;
            color: #4a2fb3;
        }

        .rows-per-page select {
            padding: 6px 10px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            cursor: pointer;
        }

        .pagination {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .pagination button {
            padding: 8px 15px;
            font-size: 15px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            background-color: #5a2ebc;
            color: white;
        }

        .pagination button:hover {
            background-color: #4725a1;
        }

        .pagination button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .pagination span {
            font-size: 15px;
            color: #4a2fb3;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .user-table th, .user-table td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
            font-size: 15px;
        }

        .user-table th {
            background-color: #edeaff;
            color: #4a2fb3;
            font-weight: 600;
        }

        .user-table tr:nth-child(even) {
            background-color: #f9f8ff;
        }

        .user-table tr:hover {
            background-color: #f3f3ff;
        }

        .user-image {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }

        .action-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            background: linear-gradient(135deg, #6d47e5, #5833b7);
            color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s ease, box-shadow 0.3s ease, background 0.3s ease;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            background: linear-gradient(135deg, #5833b7, #6d47e5);
        }

        .popup-overlay,
        .confirm-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(0, 0, 0, 0.45);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .popup-form,
        .confirm-dialog {
            background: white;
            width: 400px;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 8px 40px rgba(0, 0, 0, 0.12);
            position: relative;
            text-align: center;
        }

        .popup-form h3,
        .confirm-dialog h3 {
            font-size: 20px;
            color: #4a2fb3;
            margin-bottom: 20px;
        }

        .popup-form select {
            width: 100%;
            padding: 10px 15px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 16px;
            transition: 0.2s;
        }

        .popup-form select:focus {
            border-color: #6c47d9;
            outline: none;
        }

        .update-btn {
            padding: 10px 18px;
            font-size: 14px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            background: linear-gradient(135deg, #34c759, #2ea44f);
            color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s ease, box-shadow 0.3s ease, background 0.3s ease;
            margin-right: 10px;
        }

        .update-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            background: linear-gradient(135deg, #2ea44f, #34c759);
        }

        .cancel-btn {
            padding: 10px 18px;
            font-size: 14px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            background-color: #e74c3c;
            color: white;
        }

        .cancel-btn:hover {
            background-color: #c0392b;
        }

        .confirm-update {
            padding: 10px 18px;
            font-size: 14px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            background: linear-gradient(135deg, #34c759, #2ea44f);
            color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s ease, box-shadow 0.3s ease, background 0.3s ease;
            margin-right: 10px;
        }

        .confirm-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            background: linear-gradient(135deg, #2ea44f, #34c759);
        }

        .confirm-cancel {
            padding: 10px 18px;
            font-size: 14px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            background-color: #6b7280;
            color: white;
        }

        .confirm-cancel:hover {
            background-color: #4b5563;
        }

        .close-btn,
        .confirm-close {
            position: absolute;
            top: 10px;
            right: 12px;
            font-size: 22px;
            border: none;
            background-color: #f2f2f2;
            color: #4a2fb3;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            cursor: pointer;
        }

        .close-btn:hover,
        .confirm-close:hover {
            background-color: #4a2fb3;
            color: white;
        }

        .confirm-dialog {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .confirm-message {
            font-size: 16px;
            color: #333;
            margin-bottom: 20px;
        }

        .confirm-buttons {
            display: flex;
            justify-content: center;
            gap: 12px;
        }

        .message, .error {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            position: relative;
            display: flex;
            justify-content: space-between;
            align-items: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .message {
            background-color: #d4edda;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }

        .message.show, .error.show {
            opacity: 1;
        }

        .message-close {
            background: none;
            border: none;
            font-size: 16px;
            cursor: pointer;
            color: inherit;
        }

        @media (max-width: 768px) {
            .content-wrapper {
                margin-left: 0;
                padding: 100px 15px;
            }

            .page-title-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .search-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .search-bar {
                width: 100%;
            }

            .pagination-container {
                flex-direction: column;
                align-items: center;
                gap: 10px;
            }

            .rows-per-page {
                justify-content: center;
            }

            .user-table th, .user-table td {
                font-size: 14px;
            }

            .action-btn {
                padding: 6px 10px;
                font-size: 13px;
            }

            .pagination button {
                padding: 6px 12px;
                font-size: 14px;
            }

            .pagination span {
                font-size: 14px;
            }

            .popup-form,
            .confirm-dialog {
                width: 90%;
                padding: 20px;
            }

            .popup-form h3,
            .confirm-dialog h3 {
                font-size: 18px;
            }

            .popup-form select {
                padding: 8px;
                font-size: 14px;
            }

            .update-btn,
            .cancel-btn,
            .confirm-update,
            .confirm-cancel {
                padding: 8px 16px;
                font-size: 13px;
            }

            .confirm-buttons {
                flex-direction: column;
                gap: 10px;
            }

            .confirm-buttons button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="content-wrapper">
    <div class="page-title-container">
        <div class="page-title">Manage Users</div>
        <div class="search-container">
            <form id="searchForm" action="manage-users" method="get" onsubmit="return true;">
                <input type="hidden" name="page" value="1">
                <input type="hidden" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 15}">
                <div style="display: flex; gap: 10px;">
                    <input type="text" name="search" id="searchInput" class="search-bar" placeholder="Search users..." value="${searchTerm}">
                    <button type="submit" style="padding: 8px 15px; font-size: 15px; border-radius: 8px; border: none; cursor: pointer; background-color: #5a2ebc; color: white;">Search</button>
                </div>
            </form>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div id="messageBox" class="message show">
            ${message}
            <button class="message-close" onclick="closeMessage()">×</button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div id="messageBox" class="error show">
            ${error}
            <button class="message-close" onclick="closeMessage()">×</button>
        </div>
    </c:if>

    <div class="pagination-container">
        <div class="rows-per-page">
            <label for="rowsPerPage">Rows per page:</label>
            <form id="rowsPerPageForm" action="manage-users" method="get">
                <input type="hidden" name="page" value="1">
                <input type="hidden" name="search" value="${searchTerm}">
                <select name="rowsPerPage" id="rowsPerPage" onchange="this.form.submit()">
                    <option value="10" ${param.rowsPerPage == '10' ? 'selected' : ''}>10</option>
                    <option value="15" ${param.rowsPerPage == '15' || empty param.rowsPerPage ? 'selected' : ''}>15</option>
                    <option value="20" ${param.rowsPerPage == '20' ? 'selected' : ''}>20</option>
                    <option value="50" ${param.rowsPerPage == '50' ? 'selected' : ''}>50</option>
                </select>
            </form>
        </div>
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <form action="manage-users" method="get" style="display:inline;">
                    <input type="hidden" name="page" value="${currentPage - 1}">
                    <input type="hidden" name="search" value="${searchTerm}">
                    <input type="hidden" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 15}">
                    <button type="submit">Previous</button>
                </form>
            </c:if>
            <span>Page ${currentPage} of ${totalPages}</span>
            <c:if test="${currentPage < totalPages}">
                <form action="manage-users" method="get" style="display:inline;">
                    <input type="hidden" name="page" value="${currentPage + 1}">
                    <input type="hidden" name="search" value="${searchTerm}">
                    <input type="hidden" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 15}">
                    <button type="submit">Next</button>
                </form>
            </c:if>
        </div>
    </div>

    <table class="user-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Image</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty users}">
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.phoneNumber}</td>
                            <td>${user.address}</td>
                            <td>
                                <c:if test="${not empty user.image}">
                                    <img src="${pageContext.request.contextPath}/${user.image}" alt="${user.fullName}" class="user-image">
                                </c:if>
                                <c:if test="${empty user.image}">
                                    No Image
                                </c:if>
                            </td>
                            <td>${user.role}</td>
                            <td>
                                <button class="action-btn" onclick="openRoleDialog(${user.id}, '${user.fullName}', '${user.role}')">
                                    <i class="fas fa-user-shield"></i> Update Role
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="8">No users found.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

<!-- Role Update Dialog -->
<div class="popup-overlay" id="rolePopup">
    <div class="popup-form">
        <button class="close-btn" onclick="closeRoleDialog()">×</button>
        <h3>Update Role for <span id="userName"></span></h3>
        <form id="roleForm" action="manage-users" method="post">
            <input type="hidden" name="action" value="updateRole">
            <input type="hidden" name="userId" id="userId">
            <select name="role" id="roleSelect">
                <option value="customer">Customer</option>
                <option value="admin">Admin</option>
            </select>
            <div style="text-align: right;">
                <button type="button" class="update-btn" onclick="showConfirmDialog()">Update</button>
                <button type="button" class="cancel-btn" onclick="closeRoleDialog()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Confirmation Dialog -->
<div class="confirm-overlay" id="confirmDialog">
    <div class="confirm-dialog">
        <button class="confirm-close" onclick="closeConfirmDialog()">×</button>
        <h3>Confirm Role Change</h3>
        <p class="confirm-message" id="confirmMessage"></p>
        <div class="confirm-buttons">
            <button class="confirm-cancel" onclick="closeConfirmDialog()">Cancel</button>
            <button class="confirm-update" onclick="submitRoleUpdate()">Confirm</button>
        </div>
    </div>
</div>

<script>
    // Synchronize rows per page with search form
    document.getElementById('rowsPerPage').addEventListener('change', function() {
        document.querySelector('#searchForm input[name="rowsPerPage"]').value = this.value;
        document.getElementById('rowsPerPageForm').submit();
    });

    // Focus on search bar and handle message display when page loads
    window.onload = function() {
        document.getElementById('searchInput').focus();
        const messageBox = document.getElementById('messageBox');
        if (messageBox) {
            setTimeout(() => {
                messageBox.classList.remove('show');
            }, 3500);
        }
    };

    // Close popup when clicking outside
    document.getElementById('rolePopup').addEventListener('click', function(event) {
        if (event.target === this) {
            closeRoleDialog();
        }
    });

    // Close confirmation dialog when clicking outside
    document.getElementById('confirmDialog').addEventListener('click', function(event) {
        if (event.target === this) {
            closeConfirmDialog();
        }
    });

    function closeMessage() {
        const messageBox = document.getElementById('messageBox');
        if (messageBox) {
            messageBox.classList.remove('show');
        }
    }

    function openRoleDialog(userId, fullName, currentRole) {
        document.getElementById('userId').value = userId;
        document.getElementById('userName').textContent = fullName;
        document.getElementById('roleSelect').value = currentRole;
        document.getElementById('rolePopup').style.display = 'flex';
    }

    function closeRoleDialog() {
        document.getElementById('rolePopup').style.display = 'none';
        document.getElementById('userId').value = '';
        document.getElementById('userName').textContent = '';
        document.getElementById('roleSelect').value = 'customer';
    }

    function showConfirmDialog() {
        const userName = document.getElementById('userName').textContent;
        const newRole = document.getElementById('roleSelect').value;
        const currentRole = document.getElementById('roleSelect')[document.getElementById('roleSelect').selectedIndex - 1] ? document.getElementById('roleSelect')[document.getElementById('roleSelect').selectedIndex - 1].value : 'customer';
        const action = newRole === 'admin' ? 'upgrade' : 'downgrade';
        const targetRole = newRole === 'admin' ? 'admin' : 'customer';
        const message = "Are you sure you want to " + action + " " + userName + " to " + targetRole + "?";
        document.getElementById('confirmMessage').textContent = message;
        document.getElementById('confirmDialog').style.display = 'flex';
    }

    function closeConfirmDialog() {
        document.getElementById('confirmDialog').style.display = 'none';
        document.getElementById('confirmMessage').textContent = '';
    }

    function submitRoleUpdate() {
        document.getElementById('roleForm').submit();
    }
</script>
</body>
</html>