<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<%@ include file="admin-navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Ticket Types</title>
    <style>
        body {
            margin: 0;
            background: linear-gradient(to right, #f5f7fa, #eae6f9);
            font-family: 'Poppins', sans-serif;
        }

        .main-content {
            margin-left: 240px;
            padding: 30px 40px;
            flex-grow: 1;
        }

        .page-title {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 30px;
            color: #4c3575;
        }

        .add-ticket-btn {
            background-color: #5a2ebc;
            color: #fff;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            margin-bottom: 30px;
            transition: background 0.3s ease;
        }

        .add-ticket-btn:hover {
            background-color: #4725a1;
        }

        .ticket-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 24px;
        }

        .ticket-card {
            background-color: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
            position: relative;
        }

        .ticket-card:hover {
            transform: translateY(-4px);
        }

        .ticket-card img {
            width: 100%;
            object-fit: cover;
        }

        .ticket-info {
            padding: 16px;
        }

        .ticket-info h3 {
            margin: 0;
            font-size: 20px;
            color: #333;
        }

        .ticket-info p {
            margin: 8px 0;
            color: #555;
            font-size: 14px;
        }

        .ticket-info .price {
            font-weight: 600;
            color: #5a2ebc;
            margin-top: 10px;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .edit-btn, .delete-btn {
            padding: 8px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }

        .edit-btn {
            background-color: #3d8bfd;
            color: white;
        }

        .edit-btn:hover {
            background-color: #276dd9;
        }

        .delete-btn {
            background-color: #ff4d4d;
            color: white;
        }

        .delete-btn:hover {
            background-color: #d93636;
        }

        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(0,0,0,0.4);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .popup-form {
            background: #fff;
            border-radius: 16px;
            padding: 40px 30px 30px;
            width: 500px;
            position: relative;
        }

        .popup-form-header {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 100%;
            display: flex;
            justify-content: flex-end;
        }

        .close-btn {
            background-color: #5a2ebc;
            border: none;
            font-size: 28px;
            cursor: pointer;
            color: #fff;
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: background 0.3s ease;
            border-radius: 50%;
        }

        .close-btn:hover {
            background-color: #4725a1;
        }

        .popup-form h3 {
            font-size: 22px;
            margin-bottom: 24px;
            color: #4c3575;
            text-align: center;
        }

        .popup-form input,
        .popup-form textarea {
            width: 100%;
            margin-bottom: 18px;
            padding: 12px 14px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        .popup-form input:focus,
        .popup-form textarea:focus {
            border: 1px solid #7e3ff2;
            box-shadow: 0 0px 5px #7e3ff2;
            outline: none;
        }

        .popup-form button[type='submit'] {
            background: #5a2ebc;
            color: #fff;
            padding: 12px 18px;
            font-size: 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .popup-form button[type='submit']:hover {
            background: #4725a1;
        }

        .cancel-btn {
            background-color: #e74c3c;
            color: white;
            padding: 10px 18px;
            font-size: 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 10px;
        }

        .cancel-btn:hover {
            background-color: #c0392b;
        }

        .message, .error {
            margin-top: 10px;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }

        .message {
            background-color: #d4edda;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
<div class="main-content">
    <h2 class="page-title">Manage Ticket Types</h2>

    <button class="add-ticket-btn" onclick="openAddForm()">+ Add Ticket Type</button>

    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <div class="ticket-container">
        <c:forEach var="ticket" items="${ticketTypes}">
            <div class="ticket-card">
                <img src="${pageContext.request.contextPath}/images/${ticket.ticketType == 'Normal' ? 'normalTickets.jpg' : 'vipTicket.jpg'}" alt="${ticket.ticketType}">
                <div class="ticket-info">
                    <h3>${ticket.ticketType}</h3>
                    <p>${ticket.ticketDesc}</p>
                    <p class="price">Rs. ${ticket.unitPrice}</p>
                    <div class="action-buttons">
                        <button class="edit-btn" onclick="openEditForm(${ticket.ticketTypeId}, '${ticket.ticketType}', ${ticket.unitPrice}, '${ticket.ticketDesc}')">Edit</button>
                        <form action="ticket-types" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="ticketTypeId" value="${ticket.ticketTypeId}">
                            <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete ${ticket.ticketType}?')">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Add Popup Form -->
<div class="popup-overlay" id="addPopup">
    <div class="popup-form">
        <div class="popup-form-header">
            <button class="close-btn" onclick="closeForm('addPopup')">×</button>
        </div>
        <h3>Add New Ticket Type</h3>
        <form action="ticket-types" method="post">
            <input type="hidden" name="action" value="add">
            <div style="display: flex; gap: 15px;">
                <input type="text" name="ticketName" placeholder="Ticket Name" required style="flex: 1;">
                <input type="number" name="price" placeholder="Price (Rs.)" required style="flex: 1;">
            </div>
            <textarea name="description" rows="4" placeholder="Description" required></textarea>
            <div style="text-align: right; margin-top: 10px;">
                <button type="submit">Add Ticket</button>
                <button type="button" class="cancel-btn" onclick="closeForm('addPopup')">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Popup Form -->
<div class="popup-overlay" id="editPopup">
    <div class="popup-form">
        <div class="popup-form-header">
            <button class="close-btn" onclick="closeForm('editPopup')">×</button>
        </div>
        <h3>Edit Ticket Type</h3>
        <form action="ticket-types" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="ticketTypeId" id="editTicketTypeId">
            <div style="display: flex; gap: 15px;">
                <input type="text" name="ticketName" id="editTicketName" placeholder="Ticket Name" required style="flex: 1;">
                <input type="number" name="price" id="editPrice" placeholder="Price (Rs.)" required style="flex: 1;">
            </div>
            <textarea name="description" id="editDescription" rows="4" placeholder="Description" required></textarea>
            <div style="text-align: right; margin-top: 10px;">
                <button type="submit">Update Ticket</button>
                <button type="button" class="cancel-btn" onclick="closeForm('editPopup')">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openAddForm() {
        document.getElementById('addPopup').style.display = 'flex';
    }

    function openEditForm(ticketTypeId, ticketName, price, description) {
        document.getElementById('editTicketTypeId').value = ticketTypeId;
        document.getElementById('editTicketName').value = ticketName;
        document.getElementById('editPrice').value = price;
        document.getElementById('editDescription').value = description;
        document.getElementById('editPopup').style.display = 'flex';
    }

    function closeForm(popupId) {
        document.getElementById(popupId).style.display = 'none';
    }
</script>
</body>
</html>