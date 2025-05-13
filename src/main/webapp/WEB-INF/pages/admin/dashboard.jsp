<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %> <!-- Include the header here -->
<%@ include file="admin-navbar.jsp" %> <!-- Include the admin navbar here -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | NPL</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: #f4f6fb;
        }

        /* Main content layout - Adjusted for sidebar and header */
        .admin-dashboard {
            margin-left: 240px; /* Sidebar width */
            padding: 40px;
            min-height: calc(100vh - 70px); /* Adjust height to account for header and navbar */
            box-sizing: border-box;
            background: linear-gradient(to right, #eae6f9, #f5f7fa);
        }

        .dashboard-header {
            margin-bottom: 30px;
        }

        .dashboard-header h1 {
            font-size: 30px;
            color: #2e2a4f;
        }

        .dashboard-header p {
            font-size: 14px;
            color: #888;
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }

        .dashboard-card {
            background: #fff;
            border-radius: 16px;
            padding: 28px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.07);
            display: flex;
            flex-direction: column;
            gap: 10px;
            transition: transform 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 14px 30px rgba(0, 0, 0, 0.1);
        }

        .dashboard-card h3 {
            font-size: 18px;
            color: #5a2ebc;
        }

        .dashboard-card p {
            font-size: 14px;
            color: #666;
        }

        .card-icon {
            font-size: 30px;
            color: #7e3ff2;
        }

        @media (max-width: 768px) {
            .admin-dashboard {
                margin-left: 0;
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<div class="admin-dashboard">
    <div class="dashboard-header">
        <h1>Welcome, Admin</h1>
        <p>Overview of your platform’s status and key metrics</p>
    </div>

    <div class="card-grid">
        <div class="dashboard-card">
            <div class="card-icon"><i class="fas fa-calendar-check"></i></div>
            <h3>Total Matches</h3>
            <p>32 Scheduled Matches</p>
        </div>

        <div class="dashboard-card">
            <div class="card-icon"><i class="fas fa-ticket-alt"></i></div>
            <h3>Tickets Sold</h3>
            <p>12,430 Tickets Sold</p>
        </div>

        <div class="dashboard-card">
            <div class="card-icon"><i class="fas fa-users"></i></div>
            <h3>Registered Users</h3>
            <p>4,128 Users</p>
        </div>

        <div class="dashboard-card">
            <div class="card-icon"><i class="fas fa-file-alt"></i></div>
            <h3>Reports</h3>
            <p>Performance and booking analytics</p>
        </div>
    </div>
</div>

</body>
</html>
