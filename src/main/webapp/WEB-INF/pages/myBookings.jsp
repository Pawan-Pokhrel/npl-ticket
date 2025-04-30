<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="user-sidebar.jsp" %>
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

        .action-btn { padding: 6px 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 13px; }
        .btn-cancel { background: #F44336; color: white; transition: background 0.3s; }
        .btn-cancel:hover { background: #D32F2F; }

        .no-bookings { background: white; padding: 40px; border-radius: 8px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<div class="main-content">
    <h1>My Bookings</h1>

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
            <tr>
                <td>Biratnagar Kings vs Chitwan Rhinos</td>
                <td>2025-05-15</td>
                <td>Kathmandu Stadium</td>
                <td>2</td>
                <td><span class="status-badge status-confirmed">Confirmed</span></td>
                <td><button class="action-btn btn-cancel">Cancel</button></td>
            </tr>
            <tr>
                <td>Janakpur Bolts vs Karnali Yaks</td>
                <td>2025-06-02</td>
                <td>Biratnagar Ground</td>
                <td>4</td>
                <td><span class="status-badge status-pending">Pending</span></td>
                <td><button class="action-btn btn-cancel">Cancel</button></td>
            </tr>
            <tr>
                <td>Kathmandu Gurkhas vs Lumbini Lions</td>
                <td>2025-06-18</td>
                <td>Pokhara Stadium</td>
                <td>1</td>
                <td><span class="status-badge status-cancelled">Cancelled</span></td>
                <td>-</td>
            </tr>
            <tr>
                <td>Pokhara Avengers vs Sudurpaschim Royals</td>
                <td>2025-07-05</td>
                <td>Janakpur Arena</td>
                <td>3</td>
                <td><span class="status-badge status-confirmed">Confirmed</span></td>
                <td><button class="action-btn btn-cancel">Cancel</button></td>
            </tr>
        </tbody>
    </table>

    <!-- If no bookings exist, show this message instead -->
    <%--
    <div class="no-bookings">
        <h2>No bookings found</h2>
        <p>You haven't booked any matches yet. <a href="${pageContext.request.contextPath}/book-tickets">Book now</a> to enjoy live action!</p>
    </div>
    --%>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>