<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="admin-navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Tickets</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, white 20%, #bfa2d1 80%);
        }

        .content-wrapper {
            margin-left: 250px;
            padding: 90px 30px 30px;
        }

        .page-title {
            font-size: 26px;
            font-weight: 600;
            color: #5a2ebc;
            margin-bottom: 20px;
        }

        .ticket-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .ticket-table th, .ticket-table td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }

        .ticket-table th {
            background-color: #f8f8f8;
            color: #555;
            font-weight: 500;
        }

        .ticket-table tr:hover {
            background-color: #f3f3ff;
        }

        .action-btn {
            background-color: #5a2ebc;
            color: white;
            padding: 6px 12px;
            font-size: 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .action-btn:hover {
            background-color: #452394;
        }

        @media (max-width: 768px) {
            .content-wrapper {
                margin-left: 0;
                padding: 100px 15px;
            }

            .ticket-table th, .ticket-table td {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="content-wrapper">
    <div class="page-title">Manage Tickets</div>

    <table class="ticket-table">
        <thead>
            <tr>
                <th>Ticket ID</th>
                <th>User</th>
                <th>Match</th>
                <th>Date</th>
                <th>Seat No</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <!-- Example Row -->
            <tr>
                <td>#TCK1234</td>
                <td>pawanpokhrel</td>
                <td>Team A vs Team B</td>
                <td>2025-05-20</td>
                <td>A-15</td>
                <td>Confirmed</td>
                <td><button class="action-btn">Cancel</button></td>
            </tr>
            <!-- More rows will come here dynamically -->
        </tbody>
    </table>
</div>

</body>
</html>
