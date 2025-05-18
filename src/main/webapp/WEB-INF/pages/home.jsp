<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home | NPL Ticket Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            color: #333;
            overflow-x: hidden;
            position: relative;
            min-height: 100vh;
            margin: 0;
            background: #f5f5fa;
        }

        .page-wrapper {
            min-height: 100vh;
            position: relative;
        }

        .top-content {
            background: url('https://publisher-publish.s3.eu-central-1.amazonaws.com/pb-nepalitimes/swp/asv65r/media/2024112905114_32012f475b0660e609a36d9c288d0ef4b8d19ef7e54a7b916e192ab4c5f7dab6.jpg') no-repeat top center;
            background-size: cover;
            background-color: #1e3a8a;
            background-attachment: scroll;
            padding: 100px 40px 40px;
            position: relative;
            min-height: calc(100vh - 80px);
        }

        .top-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.2));
            z-index: 0;
        }

        .main-content {
            position: relative;
            z-index: 1;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        .welcome-section {
            text-align: left;
            margin-bottom: 20px;
            padding: 40px;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.95), rgba(230, 230, 250, 0.9));
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            z-index: 1;
            width: 65%;
            margin-left: 20px;
            margin-right: auto;
            max-width: 750px;
            min-height: 320px;
            transition: transform 0.3s ease;
        }

        .welcome-section:hover {
            transform: translateY(-5px);
        }

        .welcome-section h1 {
            font-size: 38px;
            font-weight: 700;
            color: #6a5acd;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

        .welcome-section p {
            font-size: 18px;
            color: #444;
            max-width: 100%;
            margin: 0 0 20px 0;
            line-height: 1.7;
            font-weight: 400;
        }

        .welcome-section .button-container {
            text-align: right;
        }

        .welcome-section .premium-button {
            display: inline-flex;
            align-items: center;
            padding: 12px 25px;
            background: linear-gradient(90deg, #6a5acd, #9370db);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(106, 90, 205, 0.3);
            position: relative;
            overflow: hidden;
        }

        .welcome-section .premium-button i {
            margin-left: 10px;
            font-size: 16px;
            transition: transform 0.3s ease;
        }

        .welcome-section .premium-button:hover {
            background: linear-gradient(90deg, #5a4db7, #7b5ec8);
            box-shadow: 0 6px 15px rgba(106, 90, 205, 0.4);
        }

        .welcome-section .premium-button:hover i {
            transform: translateX(5px);
        }

        .welcome-section .login-button {
            display: inline-flex;
            align-items: center;
            padding: 12px 25px;
            background: linear-gradient(90deg, #dc3545, #c82333);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
            position: relative;
            overflow: hidden;
        }

        .welcome-section .login-button i {
            margin-left: 10px;
            font-size: 16px;
            transition: transform 0.3s ease;
        }

        .welcome-section .login-button:hover {
            background: linear-gradient(90deg, #c82333, #bd2130);
            box-shadow: 0 6px 15px rgba(220, 53, 69, 0.4);
        }

        .welcome-section .login-button:hover i {
            transform: translateX(5px);
        }

        .quick-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            padding: 0 20px;
            z-index: 1;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            min-height: 350px;
            position: relative;
            border: 1px solid rgba(106, 90, 205, 0.2);
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        .card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-bottom: 2px solid #6a5acd;
        }

        .card-content {
            padding: 15px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            color: #333;
        }

        .card-content h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 6px;
            color: #6a5acd;
        }

        .card-content p {
            font-size: 13px;
            color: #666;
            flex-grow: 1;
            font-weight: 400;
        }

        .steps-section {
            background: linear-gradient(135deg, #e6e6fa, #d8d8f5);
            border-radius: 12px;
            padding: 40px 60px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            margin: 40px 20px;
            text-align: center;
            z-index: 1;
            border: 1px solid rgba(106, 90, 205, 0.3);
        }

        .steps-section h2 {
            color: #6a5acd;
            margin-bottom: 35px;
            font-size: 28px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .steps {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            position: relative;
        }

        .step {
            padding: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            transition: background 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid rgba(106, 90, 205, 0.3);
            position: relative;
            overflow: hidden;
        }

        .step:hover {
            background: rgba(255, 255, 255, 1);
            transform: translateY(-8px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .step-icon {
            font-size: 40px;
            color: #6a5acd;
            margin-bottom: 15px;
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .step:hover .step-icon {
            transform: scale(1.15);
            color: #5a4db7;
        }

        .step h3 {
            font-size: 16px;
            color: #333;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .step p {
            font-size: 13px;
            color: #666;
            font-weight: 400;
            line-height: 1.5;
        }

        @media (min-width: 768px) {
            .step:not(:last-child)::after {
                content: '';
                position: absolute;
                top: 50%;
                right: -25px;
                width: 25px;
                height: 2px;
                background: linear-gradient(to right, #6a5acd, transparent);
                z-index: -1;
            }
        }

        @media (max-width: 768px) {
            .top-content {
                padding: 80px 20px 20px;
                min-height: 800px;
            }

            .welcome-section {
                width: 100%;
                margin-left: 0;
                max-width: 100%;
                padding: 30px;
            }

            .welcome-section h1 {
                font-size: 24px;
            }

            .welcome-section p {
                font-size: 14px;
            }

            .welcome-section .button-container {
                text-align: center;
            }

            .quick-links {
                grid-template-columns: 1fr;
                padding: 0 10px;
            }

            .card {
                min-height: 300px;
            }

            .card img {
                height: 150px;
            }

            .steps-section {
                padding: 30px 20px;
                margin: 20px 10px;
            }

            .steps-section h2 {
                font-size: 22px;
            }

            .step {
                padding: 15px;
            }
        }
    </style>
</head>
<body>

<div class="page-wrapper">
    <div class="top-content">
        <div class="main-content">
            <div class="welcome-section">
                <h1>Welcome to NPL Ticket Reservation!</h1>
                <p>Experience the thrill of live matches! Book your seats, manage your bookings, and explore upcoming matches all in one place. <c:if test="${empty sessionScope.username}">Log in to the NPL Ticket System to continue and secure your spot for an unforgettable cricket experience!</c:if><c:if test="${not empty sessionScope.username}">Enjoy real-time updates, secure payment options, and exclusive access to premium events. Secure your spot today!</c:if></p>
                <div class="button-container">
                    <c:choose>
                        <c:when test="${empty sessionScope.username}">
                            <a href="${pageContext.request.contextPath}/login" class="login-button">
                                Login <i class="fas fa-sign-in-alt"></i>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/matches" class="premium-button">
                                View Upcoming Match Events <i class="fas fa-arrow-right"></i>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="quick-links">
                <div class="card" onclick="location.href='${pageContext.request.contextPath}/book-tickets'">
                    <img src="${pageContext.request.contextPath}/images/bookTickets.jpg" alt="Book Tickets">
                    <div class="card-content">
                        <h3>Book Tickets</h3>
                        <p>Secure your spot in the stands for the most anticipated matches.</p>
                    </div>
                </div>

                <div class="card" onclick="location.href='${pageContext.request.contextPath}/mybookings'">
                    <img src="${pageContext.request.contextPath}/images/bookings.jpeg" alt="My Bookings">
                    <div class="card-content">
                        <h3>My Bookings</h3>
                        <p>View and manage all your ticket reservations in one place.</p>
                    </div>
                </div>

                <div class="card" onclick="location.href='${pageContext.request.contextPath}/matches'">
                    <img src="${pageContext.request.contextPath}/images/upcomingMatches.jpg" alt="Upcoming Matches">
                    <div class="card-content">
                        <h3>Upcoming Matches</h3>
                        <p>Stay updated with match schedules, teams, and venues.</p>
                    </div>
                </div>

                <div class="card" onclick="location.href='${pageContext.request.contextPath}/profile'">
                    <img src="${pageContext.request.contextPath}/images/manageProfile.png" alt="Profile">
                    <div class="card-content">
                        <h3>Profile</h3>
                        <p>Update your personal information and preferences here.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="steps-section">
        <h2>How It Works</h2>
        <div class="steps">
            <div class="step">
                <i class="fas fa-calendar-check step-icon"></i>
                <h3>Select Match</h3>
                <p>Browse upcoming matches and choose the one you want to attend.</p>
            </div>
            <div class="step">
                <i class="fas fa-credit-card step-icon"></i>
                <h3>Make Payment</h3>
                <p>Securely pay online using your preferred payment method.</p>
            </div>
            <div class="step">
                <i class="fas fa-ticket-alt step-icon"></i>
                <h3>Get Tickets</h3>
                <p>Receive e-tickets instantly and enjoy the game day experience!</p>
            </div>
        </div>
    </div>
</div>

</body>
<%@ include file="footer.jsp" %>
</html>