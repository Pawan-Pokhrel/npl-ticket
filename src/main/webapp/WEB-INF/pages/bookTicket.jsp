<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="user-sidebar.jsp" %>
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
        .teams-grid { display: grid; grid-template-columns: repeat(4, minmax(240px, 1fr)); gap: 30px; margin-bottom: 40px; }
        .team-card { background: white; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); overflow: hidden; cursor: pointer; transition: transform 0.3s; }
        .team-card:hover { transform: translateY(-6px); }
        .team-card img {
            width: 100%;
            /* maintain 5:4 aspect ratio */
            height: auto;
            aspect-ratio: 5 / 4;
            object-fit: cover;
        }
        .team-card h3 { margin: 20px; font-size: 20px; color: #333; }

        .ticket-form { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 600px; margin: auto; }
        .ticket-form label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; }
        .ticket-form select, .ticket-form input, .ticket-form button { width: 100%; margin-bottom: 20px; padding: 12px; border: 1px solid #ccc; border-radius: 8px; font-size: 16px; }
        .ticket-form button { background: #7e3ff2; color: white; border: none; cursor: pointer; transition: background 0.3s; }
        .ticket-form button:hover { background: #5a2ebc; }

        .info-section { background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-top: 40px; }
        .info-section h2 { color: #5a2ebc; margin-bottom: 15px; }
        .info-section p { color: #555; font-size: 14px; line-height: 1.6; }
    </style>
</head>
<body>

<div class="main-content">
    <div class="booking-header">
        <h1>Book Your NPL Match Tickets</h1>
        <p>Select your favorite team, choose ticket quantity, and enjoy the game!</p>
    </div>

    <!-- Teams Selection Grid -->
    <div class="teams-grid">
        <div class="team-card" onclick="selectTeam('Biratnagar Kings')">
            <img src="images/teams/biratnagar-kings.jpg" alt="Biratnagar Kings">
            <h3>Biratnagar Kings</h3>
        </div>
        <div class="team-card" onclick="selectTeam('Chitwan Rhinos')">
            <img src="images/teams/chitwan-rhinos.jpg" alt="Chitwan Rhinos">
            <h3>Chitwan Rhinos</h3>
        </div>
        <div class="team-card" onclick="selectTeam('Janakpur Bolts')">
            <img src="images/teams/janakpur-bolts.jpg" alt="Janakpur Bolts">
            <h3>Janakpur Bolts</h3>
        </div>
        <div class="team-card" onclick="selectTeam('Karnali Yaks')">
            <img src="images/teams/karnali-yaks.jpg" alt="Karnali Yaks">
            <h3>Karnali Yaks</h3>
        </div>
        <div class="team-card" onclick="selectTeam('Kathmandu Gurkhas')">
            <img src="images/teams/kathmandu-gurkhas.jpg" alt="Kathmandu Gurkhas">
            <h3>Kathmandu Gurkhas</h3>
        </div>
        <div class="team-card" onclick="selectTeam('Lumbini Lions')">
            <img src="images/teams/lumbini-lions.jpg" alt="Lumbini Lions">
            <h3>Lumbini Lions</h3>
        </div>
        <div class="team-card" onclick="selectTeam('Pokhara Avengers')">
            <img src="images/teams/pokhara-avengers.jpg" alt="Pokhara Avengers">
            <h3>Pokhara Avengers</h3>
        </div>
        <div class="team-card" onclick="selectTeam('Sudurpaschim Royals')">
            <img src="images/teams/sudurpaschim-royals.jpg" alt="Sudurpaschim Royals">
            <h3>Sudurpaschim Royals</h3>
        </div>
    </div>

    <!-- Booking Form -->
    <form class="ticket-form" action="${pageContext.request.contextPath}/book-tickets" method="post">
        <label for="teamSelect">Selected Team</label>
        <select id="teamSelect" name="team" required>
            <option value="">-- Choose a Team --</option>
            <option>Biratnagar Kings</option>
            <option>Chitwan Rhinos</option>
            <option>Janakpur Bolts</option>
            <option>Karnali Yaks</option>
            <option>Kathmandu Gurkhas</option>
            <option>Lumbini Lions</option>
            <option>Pokhara Avengers</option>
            <option>Sudurpaschim Royals</option>
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
    function selectTeam(name) {
        document.getElementById('teamSelect').value = name;
        window.scrollTo({ top: document.querySelector('.ticket-form').offsetTop - 20, behavior: 'smooth' });
    }
</script>
</body>
</html>
