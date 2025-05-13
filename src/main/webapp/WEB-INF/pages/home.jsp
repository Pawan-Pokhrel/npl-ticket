<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="user-navbar.jsp" %>
<%@ include file="footer.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home | NPL Ticket Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: #f4f6fa;
        }

        .main-content {
            margin-left: 240px;
            padding: 40px;
            min-height: calc(100vh - 70px - 60px);
            box-sizing: border-box;
            background: linear-gradient(to right, #eae6f9, #f5f7fa);
        }

        .welcome-section {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
            text-align: center;
        }

        .welcome-section h1 {
            font-size: 36px;
            color: #5a2ebc;
            margin-bottom: 20px;
        }

        .welcome-section p {
            font-size: 18px;
            color: #444;
            max-width: 800px;
            margin: auto;
        }

        .quick-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
            transition: 0.3s ease-in-out;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            min-height: 380px; /* increased height */
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 25px rgba(90, 46, 188, 0.2);
        }

        .card img {
            width: 100%;
            height: 200px; /* increased image height */
            object-fit: cover;
        }

        .card-content {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .card-content h3 {
            color: #333;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .card-content p {
            color: #666;
            font-size: 14px;
            flex-grow: 1;
        }

        /* New "How It Works" section */
        .steps-section {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
        }

        .steps-section h2 {
            text-align: center;
            color: #5a2ebc;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .steps {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .step {
            text-align: center;
            padding: 20px;
        }

        .step-icon {
            font-size: 40px;
            color: #7e3ff2;
            margin-bottom: 15px;
        }

        .step p {
            font-size: 14px;
            color: #555;
        }
    </style>
</head>
<body>

<div class="main-content">
    <div class="welcome-section">
        <h1>Welcome to NPL Ticket Reservation!</h1>
        <p>
            Experience the thrill of live matches! Book your seats, manage your bookings, and explore upcoming matches all in one place.
            Your gateway to non-stop sports excitement starts here.
        </p>
    </div>

    <div class="quick-links">
        <div class="card" onclick="location.href='${pageContext.request.contextPath}/book-tickets'">
            <img src="https://scontent.fktm7-1.fna.fbcdn.net/v/t39.30808-6/475197044_122195099912231149_7878520258805594284_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_ohc=8uPIvJWGEt0Q7kNvwGGC2cT&_nc_oc=AdnCIe7HNZjQR6-XHPjXI5UP5Y5GOm0ZzWThzSnAnqXmsQh1fd2PZDmheagiQaE2fPc&_nc_zt=23&_nc_ht=scontent.fktm7-1.fna&_nc_gid=g6g_x8gZklXTcugmlpnBig&oh=00_AfEY28wrXZCD0F-amLuW84mqLz5h1W2P9jZGwsRoxPlbcw&oe=681700A3" alt="Book Tickets">
            <div class="card-content">
                <h3>Book Tickets</h3>
                <p>Secure your spot in the stands for the most anticipated matches.</p>
            </div>
        </div>

        <div class="card" onclick="location.href='${pageContext.request.contextPath}/mybookings'">
            <img src="https://scontent.fktm10-1.fna.fbcdn.net/v/t39.30808-6/481670990_632282732930259_5696827349609065255_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=aa7b47&_nc_ohc=N3yRGczjj2MQ7kNvwHz3x9M&_nc_oc=AdmyFAmQHntuOzOOtea3iq9881OP2lGYIlh-yRliqSomq5HzzHGqWXLe16mMB_6TI4I&_nc_zt=23&_nc_ht=scontent.fktm10-1.fna&_nc_gid=KgxZsWPFK_IDrerW08DQ4g&oh=00_AfESyZpwvRn0AAHAzAxgouqbiIKJYo-8DApvQX-0wg0eAw&oe=68170454" alt="My Bookings">
            <div class="card-content">
                <h3>My Bookings</h3>
                <p>View and manage all your ticket reservations in one place.</p>
            </div>
        </div>

        <div class="card" onclick="location.href='${pageContext.request.contextPath}/matches'">
            <img src="https://images.mykhel.com/img/2024/12/royals-vs-kings-npl-live-streaming-1733143420.jpg" alt="Upcoming Matches">
            <div class="card-content">
                <h3>Upcoming Matches</h3>
                <p>Stay updated with match schedules, teams, and venues.</p>
            </div>
        </div>

        <div class="card" onclick="location.href='${pageContext.request.contextPath}/profile'">
            <img src="https://static.vecteezy.com/system/resources/previews/054/548/207/non_2x/avatar-with-gear-showing-concept-of-employee-setting-icon-vector.jpg" alt="Profile">
            <div class="card-content">
                <h3>Profile</h3>
                <p>Update your personal information and preferences here.</p>
            </div>
        </div>
    </div>

    <!-- New "How It Works" Section -->
    <div class="steps-section">
        <h2>How It Works</n2>
        <div class="steps">
            <div class="step">
                <div class="step-icon">📝</div>
                <h3>Select Match</h3>
                <p>Browse upcoming matches and choose the one you want to attend.</p>
            </div>
            <div class="step">
                <div class="step-icon">💳</div>
                <h3>Make Payment</h3>
                <p>Securely pay online using your preferred payment method.</p>
            </div>
            <div class="step">
                <div class="step-icon">🎟️</div>
                <h3>Get Tickets</h3>
                <p>Receive e- tickets instantly and enjoy the game day experience!</p>
            </div>
        </div>
    </div>
</div>

</body>
</html>