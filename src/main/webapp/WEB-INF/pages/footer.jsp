<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
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
            font-family: 'Poppins', sans-serif;
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

<div class="footer">
    <div>© 2025 NPL Ticket Reservation. All rights reserved.</div>
    <div>
        <a href="${pageContext.request.contextPath}/privacy" target="_blank">Privacy Policy</a> | <a href="${pageContext.request.contextPath}/terms" target="_blank">Terms of Service</a>
    </div>
</div>

</body>
</html>