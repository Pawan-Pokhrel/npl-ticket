<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        .footer {
            position: fixed;
            bottom: 0;
            left: 240px; /* matches sidebar width */
            width: calc(100% - 240px);
            height: 60px;
            background-color: #fff;
            color: #444;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 24px;
            font-size: 14px;
            font-weight: 400;
            z-index: 100;
        }

        .footer a {
            color: #5d3fd3;
            text-decoration: none;
            transition: color 0.3s ease;
            font-weight: 500;
        }

        .footer a:hover {
            color: #3d1fd3;
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .footer {
                left: 0;
                width: 100%;
                flex-direction: column;
                height: auto;
                padding: 12px 16px;
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
        <a href="privacy.jsp">Privacy Policy</a> &nbsp;|&nbsp; 
        <a href="terms.jsp">Terms of Service</a>
    </div>
</div>

</body>
</html>
