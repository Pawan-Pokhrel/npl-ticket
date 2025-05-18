<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Privacy Policy | NPL Ticket Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: #f5f5fa;
            color: #333;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #6a5acd;
            font-size: 28px;
            margin-bottom: 20px;
            text-align: center;
        }
        h2 {
            color: #483d8b;
            font-size: 20px;
            margin-top: 20px;
            margin-bottom: 10px;
        }
        p {
            font-size: 14px;
            margin-bottom: 15px;
        }
        .footer {
            width: 100%;
            height: 60px;
            background: linear-gradient(135deg, rgba(106, 90, 205, 0.85), rgba(72, 61, 139, 0.85));
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 40px;
            font-size: 14px;
            font-weight: 400;
            box-shadow: 0 -4px 20px rgba(0, 0, 0, 0.15);
            z-index: 1000;
            position: fixed;
            bottom: 0;
            left: 0;
        }
        .footer a {
            color: #d3d3fa;
            text-decoration: none;
            transition: color 0.3s ease;
            font-weight: 500;
        }
        .footer a:hover {
            color: #ffffff;
            text-decoration: underline;
        }
        @media (max-width: 768px) {
            .container {
                margin: 20px;
                padding: 15px;
            }
            h1 {
                font-size: 22px;
            }
            h2 {
                font-size: 18px;
            }
            p {
                font-size: 13px;
            }
            .footer {
                flex-direction: column;
                height: auto;
                padding: 12px 20px;
                text-align: center;
                gap: 6px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Privacy Policy</h1>
    <p>Last updated: May 18, 2025</p>
    <h2>1. Data Collection</h2>
    <p>We collect personal information such as your name, email, and payment details when you book tickets or create an account. We also gather non-personal data like IP addresses and browsing behavior to improve our services.</p>
    <h2>2. Data Usage</h2>
    <p>Your information is used to process ticket bookings, send updates, and enhance user experience. We do not share your data with third parties except as required by law or with service providers who assist us.</p>
    <h2>3. Data Security</h2>
    <p>We implement industry-standard security measures to protect your data, including encryption and secure servers. However, no online system is fully immune to breaches.</p>
    <h2>4. User Rights</h2>
    <p>You have the right to access, correct, or delete your personal data. Contact us at support@npltickets.com to exercise these rights.</p>
</div>
</body>
<%@ include file="footer.jsp" %>
</html>