<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Bookings | NPL Ticket Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { margin: 0; padding: 0; font-family: 'Poppins', sans-serif; background: #f4f6fa; }
        .main-content { margin: 0; padding: 30px 40px; min-height: calc(100vh - 60px - 60px); background: linear-gradient(to right, #eae6f9, #f5f7fa); }
        .main-content h1 { color: #5a2ebc; font-size: 28px; margin-bottom: 20px; }

        .alert { padding: 15px; border-radius: 12px; display: flex; align-items: center; width: 100%; max-width: 600px; margin: 0 auto 25px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); }
        .alert.success { background: #4caf50; color: white; }
        .alert.error { background: #f44336; color: white; }
        .alert svg { width: 20px; height: 20px; margin-right: 10px; }

        .bookings-table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .bookings-table thead { background: linear-gradient(to right, #8ec5fc, #e0c3fc); }
        .bookings-table th, .bookings-table td { padding: 16px; text-align: left; }
        .bookings-table th { color: #333; font-weight: 600; }
        .bookings-table tbody tr { transition: background 0.2s; }
        .bookings-table tbody tr:nth-child(even) { background: #fafafa; }
        .bookings-table tbody tr:hover { background: #f0ecfa; }

        .status-badge { 
            display: inline-block; 
            padding: 4px 10px; 
            border-radius: 12px; 
            font-size: 12px; 
            color: white; 
        }
        .status-confirmed { 
            background: linear-gradient(to right, #4CAF50, #81C784); 
        }
        .status-pending { 
            background: linear-gradient(to right, #FF9800, #FFB74D); 
        }
        .status-cancelled { 
            background: linear-gradient(to right, #F44336, #EF5350); 
        }

        .action-btn { padding: 6px 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 13px; margin-right: 5px; }
        .btn-confirm { background: #4CAF50; color: white; transition: background 0.3s; }
        .btn-confirm:hover { background: #388E3C; }
        .btn-cancel { background: #F44336; color: white; transition: background 0.3s; }
        .btn-cancel:hover { background: #D32F2F; }
        .btn-delete { background: #757575; color: white; transition: background 0.3s; }
        .btn-delete:hover { background: #616161; }

        .no-bookings { background: white; padding: 40px; border-radius: 8px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .no-bookings a { color: #3366ff; text-decoration: none; font-weight: 600; }

        /* Modal Styles */
        .modal { 
            display: none; 
            position: fixed; 
            top: 0; 
            left: 0; 
            width: 100%; 
            height: 100%; 
            background: rgba(0, 0, 0, 0.5); 
            z-index: 1000; 
            justify-content: center; 
            align-items: center; 
        }
        .modal-content { 
            background: white; 
            padding: 20px; 
            border-radius: 8px; 
            max-width: 400px; 
            width: 90%; 
            text-align: center; 
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); 
        }
        .modal-content h3 { 
            margin-top: 0; 
            color: #333; 
            font-size: 18px; 
        }
        .modal-content p { 
            color: #555; 
            margin: 10px 0 20px; 
        }
        .modal-buttons { 
            display: flex; 
            justify-content: center; 
            gap: 10px; 
        }
        .modal-btn { 
            padding: 8px 16px; 
            border: none; 
            border-radius: 6px; 
            cursor: pointer; 
            font-size: 14px; 
            transition: background 0.3s; 
        }
        .modal-btn-confirm { 
            background: #F44336; 
            color: white; 
        }
        .modal-btn-confirm:hover { 
            background: #D32F2F; 
        }
        .modal-btn-cancel { 
            background: #ccc; 
            color: #333; 
        }
        .modal-btn-cancel:hover { 
            background: #b3b3b3; 
        }
        
        .success-message {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #4caf50;
            color: white;
            padding: 15px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            z-index: 1000;
            display: ${not empty param.message ? 'flex' : 'none'};
            align-items: center;
            justify-content: space-between;
        }
        .success-message .close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 18px;
            cursor: pointer;
            padding: 0 5px;
        }
        .success-message .close-btn:hover {
            color: #ddd;
        }
    </style>
</head>
<body>

<div class="main-content">
    <h1>My Bookings</h1>

    <c:if test="${not empty param.message}">
        <div class="success-message">
            <span>${param.message}</span>
            <button class="close-btn" onclick="this.parentElement.style.display='none'">×</button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty bookings}">
            <table class="bookings-table">
                <thead>
                    <tr>
                        <th>Match</th>
                        <th>Date</th>
                        <th>Venue</th>
                        <th>Tickets</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td>${booking.team1} vs ${booking.team2}</td>
                            <td>${booking.date}</td>
                            <td>${booking.venue}</td>
                            <td>${booking.tickets}</td>
                            <td>
                                <span class="status-badge status-${booking.status.toLowerCase()}">
                                    ${booking.status}
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${booking.status == 'Pending'}">
                                        <a href="${pageContext.request.contextPath}/payment?bookingId=${booking.bookingId}" class="action-btn btn-confirm">Confirm</a>
                                        <button type="button" class="action-btn btn-cancel" onclick="showCancelModal(${booking.bookingId})">Cancel</button>
                                        <form id="cancel-form-${booking.bookingId}" action="${pageContext.request.contextPath}/mybookings" method="POST" style="display:none;">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        </form>
                                    </c:when>
                                    <c:when test="${booking.status == 'Cancelled'}">
                                        <button type="button" class="action-btn btn-delete" onclick="showDeleteModal(${booking.bookingId})">Delete</button>
                                        <form id="delete-form-${booking.bookingId}" action="${pageContext.request.contextPath}/mybookings" method="POST" style="display:none;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        -
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-bookings">
                <h2>No bookings found</h2>
                <p>You haven't booked any matches yet. <a href="${pageContext.request.contextPath}/book-tickets">Book now</a> to enjoy live action!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Cancellation Modal -->
<div id="cancelModal" class="modal">
    <div class="modal-content">
        <h3>Confirm Cancellation</h3>
        <p>Are you sure you want to cancel this booking? This action cannot be undone.</p>
        <div class="modal-buttons">
            <button class="modal-btn modal-btn-confirm" onclick="confirmCancellation()">Yes, Cancel</button>
            <button class="modal-btn modal-btn-cancel" onclick="hideCancelModal()">No, Keep Booking</button>
        </div>
    </div>
</div>

<!-- Deletion Modal -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <h3>Confirm Deletion</h3>
        <p>Are you sure you want to delete this booking? This action will permanently remove it from your records.</p>
        <div class="modal-buttons">
            <button class="modal-btn modal-btn-confirm" onclick="confirmDeletion()">Yes, Delete</button>
            <button class="modal-btn modal-btn-cancel" onclick="hideDeleteModal()">No, Keep Booking</button>
        </div>
    </div>
</div>

<script>
    let currentBookingId = null;

    // Cancellation Modal Functions
    function showCancelModal(bookingId) {
        currentBookingId = bookingId;
        document.getElementById('cancelModal').style.display = 'flex';
    }

    function hideCancelModal() {
        document.getElementById('cancelModal').style.display = 'none';
        currentBookingId = null;
    }

    function confirmCancellation() {
        if (currentBookingId) {
            const form = document.getElementById('cancel-form-' + currentBookingId);
            if (form) {
                form.submit();
            }
        }
        hideCancelModal();
    }

    // Deletion Modal Functions
    function showDeleteModal(bookingId) {
        currentBookingId = bookingId;
        document.getElementById('deleteModal').style.display = 'flex';
    }

    function hideDeleteModal() {
        document.getElementById('deleteModal').style.display = 'none';
        currentBookingId = null;
    }

    function confirmDeletion() {
        if (currentBookingId) {
            const form = document.getElementById('delete-form-' + currentBookingId);
            if (form) {
                form.submit();
            }
        }
        hideDeleteModal();
    }

    // Close modals when clicking outside
    window.onclick = function(event) {
        const cancelModal = document.getElementById('cancelModal');
        const deleteModal = document.getElementById('deleteModal');
        if (event.target === cancelModal) {
            hideCancelModal();
        }
        if (event.target === deleteModal) {
            hideDeleteModal();
        }
    };
</script>

<%@ include file="footer.jsp" %>
</body>
</html>