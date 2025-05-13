<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="user-navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upcoming Matches | NPL Ticket Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { margin: 0; padding: 0; font-family: 'Poppins', sans-serif; background: #f4f6fa; }
        .main-content { margin-left: 240px; padding: 30px 40px; min-height: calc(100vh - 60px - 60px); box-sizing: border-box; background: linear-gradient(to right, #eae6f9, #f5f7fa); }
        .main-content h1 { color: #5a2ebc; font-size: 32px; margin-bottom: 24px; }

        /* Two cards per row */
        .matches-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 30px; margin-bottom: 40px; }

        .match-card { background: white; border-radius: 14px; overflow: hidden; box-shadow: 0 6px 16px rgba(0,0,0,0.08); transition: transform 0.3s, box-shadow 0.3s; cursor: pointer; display: flex; flex-direction: column; }
        .match-card:hover { transform: translateY(-8px); box-shadow: 0 16px 32px rgba(126,63,242,0.2); }

        /* Horizontal images row with divider */
        .images-row { display: flex; }
        .team-img { width: 50%; aspect-ratio: 5/4; object-fit: cover; }
        .divider { width: 6px; background: white; }

        .match-info { padding: 16px; text-align: center; }
        .match-info h3 { font-size: 20px; color: #333; margin: 12px 0; }
        .match-info p { color: #555; font-size: 14px; margin: 4px 0; }
        .date-badge { display: inline-block; background: #7e3ff2; color: #fff; padding: 6px 12px; border-radius: 8px; font-size: 13px; margin-top: 10px; }
    </style>
</head>
<body>

<div class="main-content">
    <h1>Upcoming Matches</h1>
    <div class="matches-grid">
        <!-- Match 1 -->
        <div class="match-card">
            <div class="images-row">
                <img class="team-img" src="images/teams/biratnagar-kings.jpg" alt="Biratnagar Kings">
                <div class="divider"></div>
                <img class="team-img" src="images/teams/chitwan-rhinos.jpg" alt="Chitwan Rhinos">
            </div>
            <div class="match-info">
                <h3>Biratnagar Kings vs Chitwan Rhinos</h3>
                <p>Venue: Kathmandu Stadium</p>
                <span class="date-badge">2025-05-15 14:00</span>
            </div>
        </div>
        <!-- Match 2 -->
        <div class="match-card">
            <div class="images-row">
                <img class="team-img" src="images/teams/janakpur-bolts.jpg" alt="Janakpur Bolts">
                <div class="divider"></div>
                <img class="team-img" src="images/teams/karnali-yaks.jpg" alt="Karnali Yaks">
            </div>
            <div class="match-info">
                <h3>Janakpur Bolts vs Karnali Yaks</h3>
                <p>Venue: Biratnagar Ground</p>
                <span class="date-badge">2025-06-02 16:00</span>
            </div>
        </div>
        <!-- Match 3 -->
        <div class="match-card">
            <div class="images-row">
                <img class="team-img" src="images/teams/kathmandu-gurkhas.jpg" alt="Kathmandu Gurkhas">
                <div class="divider"></div>
                <img class="team-img" src="images/teams/lumbini-lions.jpg" alt="Lumbini Lions">
            </div>
            <div class="match-info">
                <h3>Kathmandu Gurkhas vs Lumbini Lions</h3>
                <p>Venue: Pokhara Stadium</p>
                <span class="date-badge">2025-06-18 13:30</span>
            </div>
        </div>
        <!-- Match 4 -->
        <div class="match-card">
            <div class="images-row">
                <img class="team-img" src="images/teams/pokhara-avengers.jpg" alt="Pokhara Avengers">
                <div class="divider"></div>
                <img class="team-img" src="images/teams/sudurpaschim-royals.jpg" alt="Sudurpaschim Royals">
            </div>
            <div class="match-info">
                <h3>Pokhara Avengers vs Sudurpaschim Royals</h3>
                <p>Venue: Janakpur Arena</p>
                <span class="date-badge">2025-07-05 15:00</span>
            </div>
        </div>
        <!-- Match 5 -->
        <div class="match-card">
            <div class="images-row">
                <img class="team-img" src="images/teams/chitwan-rhinos.jpg" alt="Chitwan Rhinos">
                <div class="divider"></div>
                <img class="team-img" src="images/teams/lumbini-lions.jpg" alt="Lumbini Lions">
            </div>
            <div class="match-info">
                <h3>Chitwan Rhinos vs Lumbini Lions</h3>
                <p>Venue: Chitwan Ground</p>
                <span class="date-badge">2025-07-20 12:00</span>
            </div>
        </div>
        <!-- Match 6 -->
        <div class="match-card">
            <div class="images-row">
                <img class="team-img" src="images/teams/karnali-yaks.jpg" alt="Karnali Yaks">
                <div class="divider"></div>
                <img class="team-img" src="images/teams/kathmandu-gurkhas.jpg" alt="Kathmandu Gurkhas">
            </div>
            <div class="match-info">
                <h3>Karnali Yaks vs Kathmandu Gurkhas</h3>
                <p>Venue: Karnali Stadium</p>
                <span class="date-badge">2025-08-01 14:30</span>
            </div>
        </div>
        <!-- Match 7 -->
        <div class="match-card">
            <div class="images-row">
                <img class="team-img" src="images/teams/lumbini-lions.jpg" alt="Lumbini Lions">
                <div class="divider"></div>
                <img class="team-img" src="images/teams/biratnagar-kings.jpg" alt="Biratnagar Kings">
            </div>
            <div class="match-info">
                <h3>Lumbini Lions vs Biratnagar Kings</h3>
                <p>Venue: Lumbini Arena</p>
                <span class="date-badge">2025-08-15 16:00</span>
            </div>
        </div>
        <!-- Match 8 -->
        <div class="match-card">
            <div class="images-row">
                <img class="team-img" src="images/teams/sudurpaschim-royals.jpg" alt="Sudurpaschim Royals">
                <div class="divider"></div>
                <img class="team-img" src="images/teams/janakpur-bolts.jpg" alt="Janakpur Bolts">
            </div>
            <div class="match-info">
                <h3>Sudurpaschim Royals vs Janakpur Bolts</h3>
                <p>Venue: Sudurpaschim Field</p>
                <span class="date-badge">2025-08-30 17:00</span>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>