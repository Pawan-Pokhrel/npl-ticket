<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="user-sidebar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Events | NPL Ticket Reservation</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <style>
    body { margin:0; padding:0; font-family:'Poppins',sans-serif; background:#f4f6fa; }
    .main-content { margin-left:240px; padding:30px 40px; min-height:calc(100vh - 60px - 60px); background: linear-gradient(to right, #eae6f9, #f5f7fa); }
    .main-content h1 { color:#5a2ebc; font-size:32px; margin-bottom:24px; }
    .events-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(300px,1fr)); gap:30px; }
    .event-card {
      background:#fff; border-radius:14px; overflow:hidden;
      box-shadow:0 6px 16px rgba(0,0,0,0.08);
      transition:transform .3s,box-shadow .3s; cursor:pointer; min-height:360px;
      display:flex; flex-direction:column;
    }
    .event-card:hover { transform:translateY(-8px); box-shadow:0 16px 32px rgba(126,63,242,0.2); }
    .event-card img { width:100%; height:180px; object-fit:cover; }
    .event-info { padding:24px; flex-grow:1; display:flex; flex-direction:column; }
    .event-info h3 { font-size:22px; color:#333; margin-bottom:12px; }
    .event-info p { color:#555; font-size:15px; margin:6px 0; flex-grow:1; }
    .event-date { display:inline-block; background:#7e3ff2; color:#fff; padding:6px 12px; border-radius:8px; font-size:13px; margin-top:10px; }
  </style>
</head>
<body>

<div class="main-content">
  <h1>Upcoming Events</h1>
  <div class="events-grid">
    <div class="event-card">
      <img src="images/events/opening-ceremony.jpg" alt="Opening Ceremony">
      <div class="event-info">
        <h3>Opening Ceremony – NPL 2025</h3>
        <p>Enjoy live performances, fireworks, and special guest appearances to kick off the season.</p>
        <p><span class="event-date">2025-05-10 18:00 | Kirtipur Stadium</span></p>
      </div>
    </div>

    <div class="event-card">
      <img src="images/events/fan-meet.jpg" alt="Fan Meet and Greet">
      <div class="event-info">
        <h3>Fan Meet & Greet</h3>
        <p>Get up close with your favorite players, take photos, and win signed merchandise.</p>
        <p><span class="event-date">2025-05-20 15:00 | Hotel Annapurna, Kathmandu</span></p>
      </div>
    </div>

    <div class="event-card">
      <img src="images/events/skills-challenge.jpg" alt="Skills Challenge">
      <div class="event-info">
        <h3>Skills Challenge</h3>
        <p>Watch top athletes compete in batting, bowling, and fielding challenges for prize money.</p>
        <p><span class="event-date">2025-06-05 14:00 | Pokhara Stadium</span></p>
      </div>
    </div>

    <div class="event-card">
      <img src="images/events/all-stars-match.jpg" alt="All-Stars Charity Match">
      <div class="event-info">
        <h3>All-Stars Charity Match</h3>
        <p>Support local charities as NPL all-stars face off in a fun exhibition game.</p>
        <p><span class="event-date">2025-06-25 17:00 | Biratnagar Ground</span></p>
      </div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
