<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="user-navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Ticket | NPL Ticket Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { margin: 0; padding: 0; font-family: 'Poppins', sans-serif; background: #f4f6fa; }
        .main-content { margin-left: 240px; padding: 30px 40px; min-height: calc(100vh - 60px - 60px); box-sizing: border-box; background: linear-gradient(to right, #eae6f9, #f5f7fa); }
        .booking-header { text-align: center; margin-bottom: 30px; }
        .booking-header h1 { color: #5a2ebc; font-size: 34px; }
        .booking-header p { color: #555; font-size: 17px; }

        /* Force exactly 4 cards per row and slightly larger cards */
        .matches-grid { display: grid; grid-template-columns: repeat(4, minmax(240px, 1fr)); gap: 30px; margin-bottom: 40px; }
        .match-card { background: white; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); overflow: hidden; cursor: pointer; transition: transform 0.3s; }
        .match-card:hover { transform: translateY(-6px); }
        .match-card .team-logos { display: flex; justify-content: space-between; }
        .match-card img {
            width: 48%;
            height: auto;
            aspect-ratio: 5 / 4;
            object-fit: cover;
        }
        .match-card .match-info { margin: 20px; }
        .match-card h3 { font-size: 18px; color: #333; margin-bottom: 10px; }
        .match-card p { font-size: 14px; color: #555; margin: 5px 0; }

        .ticket-form { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 600px; margin: auto; }
        .ticket-form label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; }
        .ticket-form select, .ticket-form input, .ticket-form button { width: 100%; margin-bottom: 20px; padding: 12px; border: 1px solid #ccc; border-radius: 8px; font-size: 16px; }
        .ticket-form button { background: #7e3ff2; color: white; border: none; cursor: pointer; transition: background 0.3s; }
        .ticket-form button:hover { background: #5a2ebc; }

        .info-section { background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-top: 40px; }
        .info-section h2 { color: #5a2ebc; margin-bottom: 15px; }
        .info-section p { color: #555; font-size: 14px; line-height: 1.6; }

        .message-box { text-align: center; margin-bottom: 20px; padding: 10px; border-radius: 5px; }
        .message-box.success { background: #d4edda; color: #155724; }
        .message-box.error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>

<div class="main-content">
    <div class="booking-header">
        <h1>Book Your NPL Match Tickets</h1>
        <p>Select a match, choose ticket quantity, and enjoy the game!</p>
    </div>

    <!-- Display Messages -->
    <c:if test="${not empty message}">
        <div class="message-box ${messageType}">
            <p>${message}</p>
        </div>
    </c:if>

    <!-- Matches Selection Grid -->
    <div class="matches-grid">
        <c:forEach var="match" items="${matches}">
            <div class="match-card" onclick="selectMatch('${match.matchId}', '${match.team1} vs ${match.team2}')">
                <div class="team-logos">
                    <img src="images/teams/${match.team1.toLowerCase().replace(' ', '-')}.jpg" alt="${match.team1}">
                    <img src="images/teams/${match.team2.toLowerCase().replace(' ', '-')}.jpg" alt="${match.team2}">
                </div>
                <div class="match-info">
                    <h3>${match.team1} vs ${match.team2}</h3>
                    <p>Date: ${match.date}</p>
                    <p>Venue: ${match.venue}</p>
                    <p>Time: ${match.time}</p>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Booking Form -->
    <form class="ticket-form" action="${pageContext.request.contextPath}/book-tickets" method="post">
        <label for="matchSelect">Selected Match</label>
        <select id="matchSelect" name="matchId" required>
            <option value="">-- Choose a Match --</option>
            <c:forEach var="match" items="${matches}">
                <option value="${match.matchId}">${match.team1} vs ${match.team2} (${match.date})</option>
            </c:forEach>
        </select>

        <label for="quantity">Number of Tickets</label>
        <input type="number" id="quantity" name="quantity" min="1" max="10" placeholder="Enter quantity" required>

        <button type="submit">Book Now</button>
    </form>

    <!-- Info Section -->
    <div class="info-section">
        <h2>Why Book with NPL Ticket Reservation?</h2>
        <p>
            • <strong>Instant Confirmation:</strong> Get your e-tickets delivered instantly via email.<br>
            • <strong>Secure Payment:</strong> We use encrypted payment gateways to keep your data safe.<br>
            • <strong>Easy Management:</strong> View and modify your bookings anytime from your account.<br>
            • <strong>Exclusive Offers:</strong> Early bird discounts and special deals for registered users.
        </p>
    </div>
</div>

<script>
    function selectMatch(matchId, matchName) {
        document.getElementById('matchSelect').value = matchId;
        window.scrollTo({ top: document.querySelector('.ticket-form').offsetTop - 20, behavior: 'smooth' });
    }
</script>
</body>
</html>