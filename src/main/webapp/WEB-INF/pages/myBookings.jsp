<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<%@ include file="user-navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Bookings | NPL Ticket Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { margin: 0; padding: 0; font-family: 'Poppins', sans-serif; background: #f4f6fa; }
        .main-content { margin-left: 240px; padding: 30px 40px; min-height: calc(100vh - 60px - 60px); background: linear-gradient(to right, #eae6f9, #f5f7fa); }
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

        .status-badge { display: inline-block; padding: 4px 10px; border-radius: 12px; font-size: 12px; color: white; }
        .status-confirmed { background: #4CAF50; }
        .status-pending { background: #FF9800; }
        .status-cancelled { background: #F44336; }

        .action-btn { padding: 6px 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 13px; margin-right: 5px; }
        .btn-confirm { background: #4CAF50; color: white; transition: background 0.3s; }
        .btn-confirm:hover { background: #388E3C; }
        .btn-cancel { background: #F44336; color: white; transition: background 0.3s; }
        .btn-cancel:hover { background: #D32F2F; }

        .no-bookings { background: white; padding: 40px; border-radius: 8px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .no-bookings a { color: #3366ff; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>

<div class="main-content">
    <h1>My Bookings</h1>

    <c:if test="${not empty message}">
        <div class="alert ${messageType}">
            <svg viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="${messageType == 'success' ? 'M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z' : 'M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.707a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.707z'}" clip-rule="evenodd"/>
            </svg>
            <p>${message}</p>
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
                                <c:if test="${booking.status == 'Pending'}">
                                    <form action="${pageContext.request.contextPath}/mybookings" method="POST" style="display:inline;">
                                        <input type="hidden" name="action" value="confirm">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <button type="submit" class="action-btn btn-confirm">Confirm</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/mybookings" method="POST" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <button type="submit" class="action-btn btn-cancel">Delete</button>
                                    </form>
                                </c:if>
                                <c:if test="${booking.status != 'Pending'}">
                                    -
                                </c:if>
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

<%@ include file="footer.jsp" %>
</body>
</html>