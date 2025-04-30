<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="user-sidebar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>About | NPL Ticket Reservation</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <style>
    body { margin:0; padding:0; font-family:'Poppins',sans-serif; background:#f5f7fa; }
    .main-content { margin-left:240px; padding:40px; min-height:calc(100vh - 60px - 60px); box-sizing:border-box; background: linear-gradient(to right, #eae6f9, #f5f7fa); }
    .main-content h1 { color:#5a2ebc; font-size:32px; margin-bottom:20px; }

    .about-container { display:grid; grid-template-columns:1fr 1fr; gap:40px; align-items:center; margin-bottom:60px; }
    .about-text { background:white; padding:30px; border-radius:12px; box-shadow:0 6px 16px rgba(0,0,0,0.05); }
    .about-text h2 { color:#333; font-size:24px; margin-bottom:16px; }
    .about-text p { color:#555; font-size:16px; line-height:1.6; margin-bottom:12px; }
    .about-image img { width:100%; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.1); }

    .stats { display:flex; gap:30px; margin-bottom:60px; }
    .stat-card { background:white; flex:1; text-align:center; padding:20px; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.05); }
    .stat-card h3 { font-size:28px; color:#7e3ff2; margin-bottom:8px; }
    .stat-card p { color:#555; font-size:14px; }

    .team-section h2 { color:#5a2ebc; font-size:28px; margin-bottom:24px; text-align:center; }
    /* Force exactly 4 cards per row */
    .team-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:30px; justify-items:center; }
    .team-card { background:white; border-radius:12px; overflow:hidden; box-shadow:0 4px 12px rgba(0,0,0,0.05); text-align:center; transition:transform .3s; width:220px; }
    .team-card:hover { transform:translateY(-6px); }
    .team-card img { width:100%; height:160px; object-fit:cover; }
    .team-card h4 { margin:12px 0; font-size:18px; color:#333; }
  </style>
</head>
<body>

<div class="main-content">
  <h1>About Us</h1>
  <div class="about-container">
    <div class="about-text">
      <h2>Our Mission</h2>
      <p>At NPL Ticket Reservation, our mission is to bring fans closer to the action by providing a seamless, secure, and enjoyable ticket booking experience for Nepal Premier League matches.</p>
      <h2>Our Vision</h2>
      <p>We strive to be the leading sports ticketing platform in Nepal, leveraging technology and customer-centric services to elevate the fan experience and support the growth of Nepali cricket.</p>
      <p>Founded by cricket enthusiasts, we are committed to transparency, reliability, and innovation in every booking.</p>
    </div>
    <div class="about-image">
      <img src="images/stadium.png" alt="Stadium Crowd">
    </div>
  </div>

  <div class="stats">
    <div class="stat-card">
      <h3>10,000+</h3>
      <p>Tickets Sold</p>
    </div>
    <div class="stat-card">
      <h3>8</h3>
      <p>Participating Teams</p>
    </div>
    <div class="stat-card">
      <h3>20+</h3>
      <p>Matches Hosted</p>
    </div>
    <div class="stat-card">
      <h3>95%</h3>
      <p>Customer Satisfaction</p>
    </div>
  </div>

  <div class="team-section">
    <h2>Meet the Teams</h2>
    <div class="team-grid">
      <div class="team-card"><img src="images/teams/biratnagar-kings.jpg" alt="Biratnagar Kings"><h4>Biratnagar Kings</h4></div>
      <div class="team-card"><img src="images/teams/chitwan-rhinos.jpg" alt="Chitwan Rhinos"><h4>Chitwan Rhinos</h4></div>
      <div class="team-card"><img src="images/teams/janakpur-bolts.jpg" alt="Janakpur Bolts"><h4>Janakpur Bolts</h4></div>
      <div class="team-card"><img src="images/teams/karnali-yaks.jpg" alt="Karnali Yaks"><h4>Karnali Yaks</h4></div>
      <div class="team-card"><img src="images/teams/kathmandu-gurkhas.jpg" alt="Kathmandu Gurkhas"><h4>Kathmandu Gurkhas</h4></div>
      <div class="team-card"><img src="images/teams/lumbini-lions.jpg" alt="Lumbini Lions"><h4>Lumbini Lions</h4></div>
      <div class="team-card"><img src="images/teams/pokhara-avengers.jpg" alt="Pokhara Avengers"><h4>Pokhara Avengers</h4></div>
      <div class="team-card"><img src="images/teams/sudurpaschim-royals.jpg" alt="Sudurpaschim Royals"><h4>Sudurpaschim Royals</h4></div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>