<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<%@ include file="admin-navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | NPL</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Inter', sans-serif;
            background: #f5f7fa;
            color: #333;
            overflow-x: hidden;
        }

        .admin-dashboard {
            margin-left: 250px;
            padding: 40px 30px;
            min-height: calc(100vh - 70px);
            box-sizing: border-box;
            background: #f5f7fa;
            display: flex;
            flex-direction: column;
        }

        .dashboard-header {
            margin-bottom: 40px;
            text-align: left;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .dashboard-header h1 {
            font-size: 28px;
            font-weight: 600;
            color: #1a202c;
            margin: 0;
        }

        .dashboard-header p {
            font-size: 14px;
            font-weight: 400;
            color: #718096;
            margin: 5px 0 0;
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .chart-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            flex-grow: 1;
        }

        .dashboard-card, .chart-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            transition: box-shadow 0.3s ease;
            height: 150px;
            cursor: pointer;
        }

        .dashboard-card:hover, .chart-card:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .chart-card {
            padding: 20px;
            height: 100%;
            min-height: 300px;
        }

        .card-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            flex-grow: 1;
            padding: 10px 0;
        }

        .card-icon {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .chart-card h3, .chart-card p {
            margin: 0;
            text-align: center;
        }

        .chart-card h3 {
            font-size: 16px;
            font-weight: 500;
            color: #4a5568;
        }

        .chart-card p {
            font-size: 22px;
            font-weight: 600;
            color: #2d3748;
            margin-top: 5px;
        }

        .chart-container {
            position: relative;
            height: 200px;
            width: 100%;
            margin-top: 15px;
        }

        .dashboard-card .card-content, .chart-card .card-content {
            padding: 15px;
        }

        .card-total-matches .card-icon { color: #4a90e2; }
        .card-tickets-sold .card-icon { color: #e53e3e; }
        .card-registered-users .card-icon { color: #38a169; }
        .card-pending-payments .card-icon { color: #d69e2e; }
        .chart-total-revenue .card-icon { color: #319795; }
        .card-total-bookings .card-icon { color: #805ad5; }

        @media (max-width: 1200px) {
            .card-grid, .chart-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .admin-dashboard {
                margin-left: 0;
                padding: 20px;
            }

            .dashboard-header h1 {
                font-size: 24px;
            }

            .dashboard-header p {
                font-size: 13px;
            }

            .card-grid, .chart-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-card, .chart-card {
                height: 120px;
            }

            .chart-card {
                min-height: 250px;
            }

            .card-content {
                padding: 10px 0;
            }

            .chart-container {
                height: 180px;
                margin-top: 10px;
            }

            .chart-card h3 {
                font-size: 14px;
            }

            .chart-card p {
                font-size: 20px;
            }
        }

        @media (max-width: 480px) {
            .dashboard-header h1 {
                font-size: 20px;
            }

            .dashboard-card, .chart-card {
                height: 100px;
            }

            .chart-card {
                min-height: 220px;
            }

            .card-content {
                padding: 8px 0;
            }

            .chart-container {
                height: 160px;
                margin-top: 8px;
            }

            .chart-card h3 {
                font-size: 13px;
            }

            .chart-card p {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
<div class="admin-dashboard">
    <div class="dashboard-header">
        <h1>Welcome, Admin</h1>
        <p>Overview of NPL ticket reservation status as of ${currentDate}</p>
    </div>

    <div class="card-grid">
        <div class="dashboard-card card-total-matches" onclick="window.location.href='${pageContext.request.contextPath}/admin/manage-matches'">
            <div class="card-content">
                <div class="card-icon"><i class="fas fa-calendar-check"></i></div>
                <h3>Total Matches</h3>
                <p><c:out value="${totalMatches}" /> Matches</p>
            </div>
        </div>

        <div class="dashboard-card card-tickets-sold" onclick="window.location.href='${pageContext.request.contextPath}/admin/manage-tickets'">
            <div class="card-content">
                <div class="card-icon"><i class="fas fa-ticket-alt"></i></div>
                <h3>Tickets Sold</h3>
                <p><c:out value="${ticketsSold}" /> Tickets</p>
            </div>
        </div>

        <div class="dashboard-card card-registered-users" onclick="window.location.href='${pageContext.request.contextPath}/admin/manage-users'">
            <div class="card-content">
                <div class="card-icon"><i class="fas fa-users"></i></div>
                <h3>Registered Users</h3>
                <p><c:out value="${registeredUsers}" /> Users</p>
            </div>
        </div>

        <div class="dashboard-card card-pending-payments" onclick="window.location.href='${pageContext.request.contextPath}/admin/view-payments'">
            <div class="card-content">
                <div class="card-icon"><i class="fas fa-exclamation-triangle"></i></div>
                <h3>Pending Payments</h3>
                <p><c:out value="${pendingPayments}" /> Payments</p>
            </div>
        </div>
    </div>

    <div class="chart-grid">
        <div class="chart-card chart-total-revenue" onclick="window.location.href='${pageContext.request.contextPath}/admin/view-payments'">
            <div class="card-content">
                <div class="card-icon"><i class="fas fa-money-bill-wave"></i></div>
                <h3>Total Revenue</h3>
                <p>Rs. <c:out value="${totalRevenue}" />/-</p>
            </div>
            <div class="chart-container">
                <canvas id="revenueChart"></canvas>
            </div>
        </div>

        <div class="chart-card card-total-bookings" onclick="window.location.href='${pageContext.request.contextPath}/admin/manage-tickets'">
            <div class="card-content">
                <div class="card-icon"><i class="fas fa-bookmark"></i></div>
                <h3>Total Bookings</h3>
                <p><c:out value="${totalBookings}" /> Bookings</p>
            </div>
            <div class="chart-container">
                <canvas id="bookingsChart"></canvas>
            </div>
        </div>
    </div>
</div>

<script>
    // Dynamic date update
    const currentDate = new Date().toLocaleDateString('en-GB', {
        weekday: 'long', day: 'numeric', month: 'long', year: 'numeric',
        hour: '2-digit', minute: '2-digit',
        timeZone: 'Asia/Kathmandu'
    });
    document.querySelector('.dashboard-header p').innerHTML = `Overview of NPL ticket reservation status as of ${currentDate}`;

    // Chart.js initialization
    const ctxRevenue = document.getElementById('revenueChart').getContext('2d');
    new Chart(ctxRevenue, {
        type: 'bar',
        data: {
            labels: ['Lifetime'],
            datasets: [{
                label: 'Total Revenue (Rs.)',
                data: [<c:out value="${totalRevenue}" />],
                backgroundColor: '#319795',
                borderColor: '#2c7a7b',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: { beginAtZero: true },
                x: { grid: { display: false } }
            },
            plugins: {
                legend: { display: false }
            }
        }
    });

    const ctxBookings = document.getElementById('bookingsChart').getContext('2d');
    new Chart(ctxBookings, {
        type: 'bar',
        data: {
            labels: ['Lifetime'],
            datasets: [{
                label: 'Total Bookings',
                data: [<c:out value="${totalBookings}" />],
                backgroundColor: '#805ad5',
                borderColor: '#6b46c1',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: { beginAtZero: true },
                x: { grid: { display: false } }
            },
            plugins: {
                legend: { display: false }
            }
        }
    });
</script>