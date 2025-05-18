<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<%@ include file="admin-navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Matches</title>
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

        .add-btn {
            background: linear-gradient(to right, #6d47e5, #5833b7);
            color: #fff;
            padding: 8px 15px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: 0.3s ease;
        }
        .add-btn:hover {
            background: #4728a7;
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

        .match-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .match-table th, .match-table td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
            font-size: 15px;
        }

        .match-table th {
            background-color: #edeaff;
            color: #4a2fb3;
            font-weight: 600;
        }

        .match-table tr:nth-child(even) {
            background-color: #f9f8ff;
        }

        .match-table tr:hover {
            background-color: #f3f3ff;
        }

        .action-btns {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .action-btns button {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 9px 14px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: 0.3s;
            color: #fff;
        }

        .edit-btn {
            background-color: #3d8bfd;
        }
        .edit-btn:hover {
            background-color: #276dd9;
        }

        .delete-btn {
            background-color: #ff4d4d;
        }
        .delete-btn:hover {
            background-color: #d93636;
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
            width: 500px;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 8px 40px rgba(0, 0, 0, 0.12);
            position: relative;
        }

        .popup-form h3,
        .confirm-dialog h3 {
            font-size: 22px;
            text-align: center;
            color: #4a2fb3;
            margin-bottom: 25px;
        }

        .popup-form input,
        .popup-form select {
            width: 100%;
            padding: 12px 15px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 16px;
            transition: 0.2s;
        }
        .popup-form input:focus,
        .popup-form select:focus {
            border-color: #6c47d9;
            outline: none;
        }

        .popup-form button[type="submit"],
        .popup-form .cancel-btn {
            padding: 12px 20px;
            font-size: 15px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
        }

        .popup-form button[type="submit"] {
            background-color: #5a2ebc;
            color: white;
        }
        .popup-form button[type="submit"]:hover {
            background-color: #4725a1;
        }

        .popup-form .cancel-btn {
            background-color: #e74c3c;
            color: white;
        }
        .popup-form .cancel-btn:hover {
            background-color: #c0392b;
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
            gap: 30px;
        }

        .confirm-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 16px;
        }

        .confirm-buttons button {
            padding: 10px 18px;
            font-size: 14px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
        }

        .confirm-delete {
            background-color: #e74c3c;
            color: white;
        }
        .confirm-delete:hover {
            background-color: #c0392b;
        }
        .confirm-cancel {
            background-color: #6b7280;
            color: white;
        }
        .confirm-cancel:hover {
            background-color: #4b5563;
        }

        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 10000;
        }

        .toast {
            background-color: #2c2c2c;
            color: white;
            padding: 20px 30px;
            border-radius: 12px;
            border-left: 8px solid #5a2ebc;
            margin-bottom: 15px;
            opacity: 0;
            transition: opacity 0.3s ease;
            min-width: 340px;
            font-size: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .toast-close {
            background: #555;
            color: white;
            border: none;
            font-size: 16px;
            border-radius: 50%;
            width: 26px;
            height: 26px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .toast-close:hover {
            background-color: #333;
        }

        .toast.error {
            border-left-color: #e74c3c;
        }

        .toast.show {
            opacity: 1;
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

            .match-table th, .match-table td {
                font-size: 14px;
            }

            .action-btns button {
                padding: 7px 12px;
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
                padding: 30px;
            }

            .popup-form h3,
            .confirm-dialog h3 {
                font-size: 20px;
            }

            .popup-form input,
            .popup-form select {
                padding: 10px;
                font-size: 14px;
            }

            .popup-form button[type="submit"],
            .popup-form .cancel-btn {
                padding: 10px 18px;
                font-size: 14px;
            }

            .confirm-buttons button {
                padding: 8px 16px;
                font-size: 13px;
            }

            .toast {
                min-width: 280px;
                padding: 15px 25px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
<div class="content-wrapper">
    <div class="page-title-container">
        <div class="page-title">Manage Matches</div>
        <div class="search-container">
            <form id="searchForm" action="manage-matches" method="get" onsubmit="return true;">
                <input type="hidden" name="page" value="1">
                <input type="hidden" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 15}">
                <div style="display: flex; gap: 10px;">
                    <input type="text" name="search" id="searchInput" class="search-bar" placeholder="Search matches..." value="${param.search}">
                    <button type="submit" style="padding: 8px 15px; font-size: 15px; border-radius: 8px; border: none; cursor: pointer; background-color: #5a2ebc; color: white;">Search</button>
                </div>
            </form>
            <button class="add-btn" onclick="openForm()">+ Add Match</button>
        </div>
    </div>

    <div class="pagination-container">
        <div class="rows-per-page">
            <label for="rowsPerPage">Rows per page:</label>
            <form id="rowsPerPageForm" action="manage-matches" method="get">
                <input type="hidden" name="page" value="1">
                <input type="hidden" name="search" value="${param.search}">
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
                <form action="manage-matches" method="get" style="display:inline;">
                    <input type="hidden" name="page" value="${currentPage - 1}">
                    <input type="hidden" name="search" value="${param.search}">
                    <input type="hidden" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 15}">
                    <button type="submit">Previous</button>
                </form>
            </c:if>
            <span>Page ${currentPage} of ${totalPages}</span>
            <c:if test="${currentPage < totalPages}">
                <form action="manage-matches" method="get" style="display:inline;">
                    <input type="hidden" name="page" value="${currentPage + 1}">
                    <input type="hidden" name="search" value="${param.search}">
                    <input type="hidden" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 15}">
                    <button type="submit">Next</button>
                </form>
            </c:if>
        </div>
    </div>

    <table class="match-table" id="matchTable">
        <thead>
            <tr>
                <th>Match No.</th>
                <th>Match</th>
                <th>Date</th>
                <th>Time</th>
                <th>Venue</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty matches}">
                    <c:forEach var="match" items="${matches}" varStatus="loop">
                        <tr data-match-id="${match.matchId}" data-match-name="${match.team1} vs ${match.team2}" data-date="${match.date}" data-time="${match.time}" data-venue="${match.venue}" data-status="${match.status}">
                            <td>${match.matchId}</td>
                            <td>${match.team1} vs ${match.team2}</td>
                            <td>${match.date}</td>
                            <td>${match.time.toString().substring(0, 5)}</td>
                            <td>${match.venue}</td>
                            <td>${match.status}</td>
                            <td class="action-btns">
                                <button class="edit-btn" onclick="openForm('${match.team1}', '${match.team2}', '${match.date}', '${match.time.toString().substring(0, 5)}', '${match.venue}', '${match.audience}', '${match.status}', '${match.matchId}')">
                                    <svg viewBox="0 0 24 24">
                                        <path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/>
                                    </svg>
                                    Edit
                                </button>
                                <button class="delete-btn" onclick="showConfirmDialog('${match.matchId}', '${match.team1} vs ${match.team2}')">
                                    <svg viewBox="0 0 24 24">
                                        <path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/>
                                    </svg>
                                    Delete
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="7">No matches found.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

<!-- Popup Form -->
<div class="popup-overlay" id="matchPopup">
    <div class="popup-form">
        <button class="close-btn" onclick="closeForm()">×</button>
        <h3 id="formTitle">Add Match</h3>
        <form action="manage-matches" method="post" onsubmit="return validateForm()">
            <input type="hidden" id="matchId" name="matchId">
            <input type="hidden" id="formAction" name="action" value="add">
            <input type="hidden" id="formPage" name="page" value="${currentPage}">
            <input type="hidden" id="formRowsPerPage" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 15}">
            <input type="hidden" id="formSearch" name="search" value="${param.search}">
            <input type="text" id="team1" name="team1" placeholder="Team 1 Name" required>
            <input type="text" id="team2" name="team2" placeholder="Team 2 Name" required>
            <input type="date" id="date" name="date" required>
            <input type="time" id="time" name="time" required>
            <input type="text" id="venue" name="venue" placeholder="Venue" required>
            <input type="number" id="audience" name="audience" placeholder="Audience" min="0">
            <input type="text" id="status" name="status" placeholder="Status" value="Not Started">
            <div style="text-align: right;">
                <button type="submit">Save</button>
                <button type="button" class="cancel-btn" onclick="closeForm()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Confirmation Dialog -->
<div class="confirm-overlay" id="confirmDialog">
    <div class="confirm-dialog">
        <button class="confirm-close" onclick="closeConfirmDialog()">×</button>
        <h3>Confirm Deletion</h3>
        <p>Are you sure you want to delete the match "<span id="matchName"></span>"?</p>
        <div class="confirm-buttons">
            <button class="confirm-cancel" onclick="closeConfirmDialog()">Cancel</button>
            <form id="deleteForm" method="post" action="manage-matches" style="display:inline;">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" id="confirmMatchId" name="matchId" value=""/>
                <input type="hidden" id="deleteFormPage" name="page" value="${currentPage}">
                <input type="hidden" id="deleteFormRowsPerPage" name="rowsPerPage" value="${param.rowsPerPage != null ? param.rowsPerPage : 15}">
                <input type="hidden" id="deleteFormSearch" name="search" value="${param.search}">
                <button type="submit" class="confirm-delete">Delete</button>
            </form>
        </div>
    </div>
</div>

<!-- Toast Container -->
<div class="toast-container" id="toastContainer"></div>

<script>
    // Synchronize rows per page with search form
    document.getElementById('rowsPerPage').addEventListener('change', function() {
        document.querySelector('#searchForm input[name="rowsPerPage"]').value = this.value;
        document.getElementById('rowsPerPageForm').submit();
    });

    // Focus on search bar when page loads
    window.onload = function() {
        document.getElementById('searchInput').focus();
        <%
            String message = (String) session.getAttribute("message");
            if (message != null) {
                message = message.replace("<", "<").replace(">", ">").replace("'", "\\'");
                session.removeAttribute("message");
        %>
                const message = '<%= message %>';
                const isError = message.toLowerCase().includes('error');
                showToast(message, isError);
        <% } %>
    };

    function openForm(team1 = '', team2 = '', date = '', time = '', venue = '', audience = '', status = 'Not Started', matchId = '') {
        document.getElementById('formTitle').innerText = matchId ? 'Edit Match' : 'Add Match';
        document.getElementById('team1').value = team1;
        document.getElementById('team2').value = team2;
        document.getElementById('date').value = date;
        document.getElementById('time').value = time;
        document.getElementById('venue').value = venue;
        document.getElementById('audience').value = audience;
        document.getElementById('status').value = status;
        document.getElementById('matchId').value = matchId;
        document.getElementById('formAction').value = matchId ? 'edit' : 'add';
        document.getElementById('matchPopup').style.display = 'flex';
    }

    function closeForm() {
        document.getElementById('matchPopup').style.display = 'none';
        document.getElementById('formAction').value = 'add';
        document.getElementById('team1').value = '';
        document.getElementById('team2').value = '';
        document.getElementById('date').value = '';
        document.getElementById('time').value = '';
        document.getElementById('venue').value = '';
        document.getElementById('audience').value = '';
        document.getElementById('status').value = 'Not Started';
        document.getElementById('matchId').value = '';
    }

    function showConfirmDialog(matchId, matchName) {
        document.getElementById('confirmDialog').style.display = 'flex';
        document.getElementById('matchName').textContent = matchName;
        document.getElementById('confirmMatchId').value = matchId;
    }

    function closeConfirmDialog() {
        document.getElementById('confirmDialog').style.display = 'none';
        document.getElementById('matchName').textContent = '';
        document.getElementById('confirmMatchId').value = '';
    }

    function validateForm() {
        const team1 = document.getElementById('team1').value.trim();
        const team2 = document.getElementById('team2').value.trim();
        const date = document.getElementById('date').value;
        const time = document.getElementById('time').value;
        const venue = document.getElementById('venue').value.trim();

        if (!team1 || !team2 || !date || !time || !venue) {
            showToast('Please fill all required fields.', true);
            return false;
        }
        return true;
    }

    function showToast(message, isError = false) {
        const toastContainer = document.getElementById('toastContainer');
        const toast = document.createElement('div');
        toast.className = 'toast' + (isError ? ' error' : '');
        toast.textContent = message;

        const closeBtn = document.createElement('button');
        closeBtn.className = 'toast-close';
        closeBtn.innerHTML = '×';
        closeBtn.onclick = () => {
            toast.classList.remove('show');
            setTimeout(() => toast.remove(), 500);
        };
        toast.appendChild(closeBtn);

        toastContainer.appendChild(toast);

        setTimeout(() => toast.classList.add('show'), 100);
        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => toast.remove(), 500);
        }, 2500);
    }
</script>
</body>
</html>