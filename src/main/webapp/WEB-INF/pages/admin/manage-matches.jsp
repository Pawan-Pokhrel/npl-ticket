<%@ page import="java.util.List, com.nplticket.model.MatchModel" %>
<%@ include file="header.jsp" %>
<%@ include file="admin-navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Matches</title>
    <style>
		@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap');
		
		body {
		    margin: 0;
		    font-family: 'Poppins', sans-serif;
		    background: linear-gradient(135deg, #f6f5ff, #f3f0fc);
		    color: #2e2e2e;
		}
		
		.main-content {
		    margin-left: 240px;
		    padding: 40px 50px;
		    min-height: 100vh;
		    background-color: #f9f8ff;
		}
		
		.page-title {
		    font-size: 30px;
		    font-weight: 700;
		    color: #4a2fb3;
		    margin-bottom: 30px;
		}
		
		.add-btn {
		    background: linear-gradient(to right, #6d47e5, #5833b7);
		    color: #fff;
		    padding: 12px 22px;
		    border: none;
		    border-radius: 10px;
		    font-size: 15px;
		    font-weight: 500;
		    cursor: pointer;
		    transition: 0.3s ease;
		    box-shadow: 0 4px 14px rgba(88, 51, 183, 0.3);
		}
		.add-btn:hover {
		    background: #4728a7;
		    box-shadow: 0 6px 20px rgba(70, 40, 150, 0.4);
		}
		
		table {
		    width: 100%;
		    border-spacing: 0;
		    border-radius: 14px;
		    overflow: hidden;
		    background: #fff;
		    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
		}
		
		th, td {
		    padding: 18px 20px;
		    font-size: 15px;
		    text-align: left;
		}
		
		th {
		    background: #edeaff;
		    color: #4a2fb3;
		    font-weight: 600;
		}
		
		tr {
		    border-bottom: 1px solid #eee;
		    transition: background-color 0.2s ease;
		}
		tr:nth-child(even) {
		    background-color: #f9f8ff;
		}
		tr:hover {
		    background-color: #f1edff;
		}
		
		td {
		    color: #555;
		    vertical-align: middle;
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
		    top: 0; left: 0;
		    width: 100vw; height: 100vh;
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

    </style>
</head>
<body>

<div class="main-content">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
        <h2 class="page-title">Manage Matches</h2>
        <button class="add-btn" onclick="openForm()">+ Add Match</button>
    </div>

    <table>
        <thead>
            <tr>
                <th>Match No.</th>
                <th>Match</th>
                <th>Date</th>
                <th>Time</th>
                <th>Venue</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<MatchModel> matches = (List<MatchModel>) request.getAttribute("matches");
            System.out.println("JSP: Matches attribute: " + (matches != null ? matches.size() : "null"));
            if (matches != null && !matches.isEmpty()) {
                for (MatchModel match : matches) {
                    // Escape output to prevent XSS
                    String team1 = match.getTeam1() != null ? match.getTeam1().replace("<", "&lt;").replace(">", "&gt;") : "";
                    String team2 = match.getTeam2() != null ? match.getTeam2().replace("<", "&lt;").replace(">", "&gt;") : "";
                    String venue = match.getVenue() != null ? match.getVenue().replace("<", "&lt;").replace(">", "&gt;") : "";
                    String status = match.getStatus() != null ? match.getStatus().replace("<", "&lt;").replace(">", "&gt;") : "";
                    // Escape for JavaScript
                    String jsTeam1 = team1.replace("'", "\\'");
                    String jsTeam2 = team2.replace("'", "\\'");
                    String jsVenue = venue.replace("'", "\\'");
                    String jsStatus = status.replace("'", "\\'");
        %>
            <tr>
                <td><%= match.getMatchId() %></td>
                <td><%= team1 %> vs <%= team2 %></td>
                <td><%= match.getDate() %></td>
                <td><%= match.getTime().toString().substring(0, 5) %></td>
                <td><%= venue %></td>
                <td><%= status %></td>
                <td class="action-btns">
                    <button class="edit-btn"
                        onclick="openForm('<%= jsTeam1 %>', '<%= jsTeam2 %>', '<%= match.getDate() %>', '<%= match.getTime().toString().substring(0, 5) %>', '<%= jsVenue %>', '<%= match.getAudience() %>', '<%= jsStatus %>', '<%= match.getMatchId() %>')">
                        <svg viewBox="0 0 24 24">
                            <path d="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"/>
                        </svg>
                        Edit
                    </button>
                    <button class="delete-btn" onclick="showConfirmDialog('<%= match.getMatchId() %>', '<%= jsTeam1 %> vs <%= jsTeam2 %>')">
                        <svg viewBox="0 0 24 24">
                            <path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/>
                        </svg>
                        Delete
                    </button>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="7">No matches found.</td></tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<!-- Popup Form -->
<div class="popup-overlay" id="matchPopup">
    <div class="popup-form">
        <div class="popup-form-header">
            <button class="close-btn" onclick="closeForm()">×</button>
        </div>
        <h3 id="formTitle">Add Match</h3>
        <form action="manage-matches" method="post" onsubmit="return validateForm()">
            <input type="hidden" id="matchId" name="matchId">
            <input type="hidden" id="formAction" name="action" value="add">

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
                <button type="submit" class="confirm-delete">Delete</button>
            </form>
        </div>
    </div>
</div>

<!-- Toast Container -->
<div class="toast-container" id="toastContainer"></div>

<script>
    function openForm(team1 = '', team2 = '', date = '', time = '', venue = '', audience = '', status = 'Not Started', matchId = '') {
        console.log('openForm called with matchId:', matchId, 'team1:', team1, 'team2:', team2);
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
        console.log('closeForm called');
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
        console.log('showConfirmDialog called with matchId:', matchId, 'matchName:', matchName);
        document.getElementById('confirmDialog').style.display = 'flex';
        document.getElementById('matchName').textContent = matchName;
        document.getElementById('confirmMatchId').value = matchId;
    }

    function closeConfirmDialog() {
        console.log('closeConfirmDialog called');
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

        console.log('validateForm: team1=', team1, 'team2=', team2, 'date=', date, 'time=', time, 'venue=', venue);

        if (!team1 || !team2 || !date || !time || !venue) {
            showToast('Please fill all required fields.', true);
            return false;
        }
        return true;
    }

    function showToast(message, isError = false) {
        console.log('showToast called with message:', message, 'isError:', isError);
        const toastContainer = document.getElementById('toastContainer');
        const toast = document.createElement('div');
        toast.className = 'toast' + (isError ? ' error' : '');
        toast.textContent = message;

        // Add close button
        const closeBtn = document.createElement('button');
        closeBtn.className = 'toast-close';
        closeBtn.innerHTML = '×';
        closeBtn.onclick = function() {
            console.log('toast-close clicked for message:', message);
            toast.classList.remove('show');
            setTimeout(() => {
                toast.remove();
            }, 500);
        };
        toast.appendChild(closeBtn);

        toastContainer.appendChild(toast);

        setTimeout(() => {
            toast.classList.add('show');
        }, 100);

        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => {
                toast.remove();
            }, 500);
        }, 2500);
    }

    <%
        String message = (String) session.getAttribute("message");
        if (message != null) {
            // Escape message to prevent XSS
            message = message.replace("<", "&lt;").replace(">", "&gt;").replace("'", "\\'");
            // Clear session attribute to prevent repeated display
            session.removeAttribute("message");
    %>
        window.onload = function() {
            const message = '<%= message %>';
            const isError = message.toLowerCase().includes('error');
            showToast(message, isError);
        };
    <% } %>
</script>

</body>
</html>