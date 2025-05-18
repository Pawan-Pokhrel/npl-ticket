<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Ticket | NPL Ticket Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: #f4f6fa;
            min-height: 100vh;
            position: relative;
        }

        .main-content {
            padding: 30px 40px;
            min-height: calc(100vh - 80px - 60px);
            box-sizing: border-box;
            background: linear-gradient(to right, #eae6f9, #f5f7fa);
        }

        .booking-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .booking-header h1 {
            color: #5a2ebc;
            font-size: 34px;
        }

        .booking-header p {
            color: #555;
            font-size: 17px;
        }

        .matches-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(240px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .match-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .match-card:hover {
            transform: translateY(-6px);
        }

        .match-card .team-logos {
            display: flex;
            justify-content: space-between;
        }

        .match-card img {
            width: 48%;
            height: auto;
            aspect-ratio: 5 / 4;
            object-fit: cover;
        }

        .match-card .match-info {
            margin: 20px;
        }

        .match-card h3 {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
        }

        .match-card p {
            font-size: 14px;
            color: #555;
            margin: 5px 0;
        }

        .popup-overlay {
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

        .popup-content {
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 90%;
            position: relative;
            padding: 10px;
        }

        .close-button-container {
            display: flex;
            justify-content: end;
            padding: 10px 10px 0 0;
            cursor: pointer;
            margin-bottom: 20px; /* Added space beneath the close button */
        }

        .close-button {
            position: relative;
            width: 20px;
            height: 20px;
            margin-top: 5px;
            display: inline-block;
        }

        .close-button::before,
        .close-button::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 2px;
            height: 20px;
            background-color: #555;
            transform: translate(-50%, -50%) rotate(45deg);
            transition: background-color 0.2s, transform 0.2s;
        }

        .close-button::after {
            transform: translate(-50%, -50%) rotate(-45deg);
        }

        .close-button:hover::before,
        .close-button:hover::after {
            background-color: #ff0000;
            transform: translate(-50%, -50%) rotate(45deg) scale(1.2);
        }

        .close-button:hover::after {
            transform: translate(-50%, -50%) rotate(-45deg) scale(1.2);
        }

        .popup-content .team-logos {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            padding: 0 30px;
        }

        .popup-content form {
            padding: 0 30px 30px 30px;
        }

        .popup-content img {
            width: 48%;
            height: auto;
            aspect-ratio: 5 / 4;
            object-fit: cover;
            border-radius: 8px;
        }

        .popup-content label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #444;
        }

        .popup-content select,
        .popup-content input {
            width: 100%;
            margin-bottom: 20px;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
        }

        .popup-content .button-group {
            display: flex;
            gap: 15px;
        }

        .popup-content button {
            flex: 1;
            padding: 12px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .popup-content .book-button {
            background: #7e3ff2;
            color: white;
            border: none;
        }

        .popup-content .book-button:hover {
            background: #5a2ebc;
        }

        .popup-content .cancel-button {
            background: #dc3545;
            color: white;
            border: none;
            order: -1;
        }

        .popup-content .cancel-button:hover {
            background: #c82333;
        }

        .info-section {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            margin-top: 40px;
        }

        .info-section h2 {
            color: #5a2ebc;
            margin-bottom: 15px;
        }

        .info-section p {
            color: #555;
            font-size: 14px;
            line-height: 1.6;
        }

        .message-box {
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 5px;
        }

        .message-box.success {
            background: #d4edda;
            color: #155724;
        }

        .message-box.error {
            background: #f8d7da;
            color: #721c24;
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
            }

            .booking-header h1 {
                font-size: 26px;
            }

            .booking-header p {
                font-size: 15px;
            }

            .matches-grid {
                grid-template-columns: repeat(1, 1fr);
                gap: 20px;
            }

            .popup-content {
                padding: 20px;
                width: 95%;
            }
        }
    </style>
</head>
<body>

<div class="main-content">
    <div class="booking-header">
        <h1>Book Your NPL Match Tickets</h1>
        <p>Select a match, choose ticket quantity, and enjoy the game!</p>
    </div>

    <c:if test="${not empty message}">
        <div class="message-box ${messageType}">
            <p>${message}</p>
        </div>
    </c:if>

    <div class="matches-grid">
        <c:forEach var="match" items="${matches}">
            <div class="match-card" onclick="openPopup('${match.matchId}', '${match.team1.toLowerCase().replace(' ', '-')}', '${match.team2.toLowerCase().replace(' ', '-')}')">
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

<div class="popup-overlay" id="popupOverlay">
    <div class="popup-content">
        <div class="close-button-container" onclick="closePopup()">
            <div class="close-button"></div>
        </div>
        <div class="team-logos" id="popupTeamLogos">
            <img id="team1Image" src="" alt="Team 1">
            <img id="team2Image" src="" alt="Team 2">
        </div>
        <form action="${pageContext.request.contextPath}/book-tickets" method="post">
            <label for="matchSelect">Selected Match</label>
            <select id="matchSelect" name="matchId" onchange="updateMatchImages()" required>
                <c:forEach var="match" items="${matches}">
                    <option value="${match.matchId}" 
                            data-team1="${match.team1.toLowerCase().replace(' ', '-')}" 
                            data-team2="${match.team2.toLowerCase().replace(' ', '-')}"
                            data-matchname="${match.team1} vs ${match.team2} (${match.date})">
                        ${match.team1} vs ${match.team2} (${match.date})
                    </option>
                </c:forEach>
            </select>

            <label for="quantity">Number of Tickets</label>
            <input type="number" id="quantity" name="quantity" min="1" max="10" placeholder="Enter quantity" required>

            <div class="button-group">
                <button type="button" class="cancel-button" onclick="closePopup()">Cancel</button>
                <button type="submit" class="book-button">Book Now</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>

<script>
    function openPopup(matchId, team1, team2) {
        const popupOverlay = document.getElementById('popupOverlay');
        const matchSelect = document.getElementById('matchSelect');
        const team1Image = document.getElementById('team1Image');
        const team2Image = document.getElementById('team2Image');

        console.log(team1);

        matchSelect.value = matchId;
        team1Image.src = "images/teams/" + team1 + ".jpg";
        team2Image.src = "images/teams/" + team2 + ".jpg";
        team1Image.alt = team1.replace('-', ' ');
        team2Image.alt = team2.replace('-', ' ');
        popupOverlay.style.display = 'flex';

        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function closePopup() {
        document.getElementById('popupOverlay').style.display = 'none';
        document.getElementById('quantity').value = '';
    }

    function updateMatchImages() {
        const matchSelect = document.getElementById('matchSelect');
        const selectedOption = matchSelect.options[matchSelect.selectedIndex];
        const team1Image = document.getElementById('team1Image');
        const team2Image = document.getElementById('team2Image');

        const team1 = selectedOption.getAttribute('data-team1');
        const team2 = selectedOption.getAttribute('data-team2');
        team1Image.src = "images/teams/" + team1 + ".jpg";
        team2Image.src = "images/teams/" + team2 + ".jpg";
        team1Image.alt = team1.replace('-', ' ');
        team2Image.alt = team2.replace('-', ' ');
    }

    // Close popup when clicking outside the popup content
    document.getElementById('popupOverlay').addEventListener('click', function(event) {
        if (event.target === this) {
            closePopup();
        }
    });
</script>