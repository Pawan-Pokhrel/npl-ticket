<%@ include file="header.jsp" %>
<%@ include file="admin-navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Ticket Types</title>
    <style>
        body {
            margin: 0;
            background: linear-gradient(to right, #f5f7fa, #eae6f9);
            font-family: 'Poppins', sans-serif;
        }

        .main-content {
            margin-left: 240px; /* Adjust if your sidebar width is different */
            padding: 30px 40px;
            flex-grow: 1;
        }

        .page-title {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 30px;
            color: #4c3575;
        }

        .add-ticket-btn {
            background-color: #5a2ebc;
            color: #fff;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            margin-bottom: 30px;
            transition: background 0.3s ease;
        }

        .add-ticket-btn:hover {
            background-color: #4725a1;
        }

        .ticket-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 24px;
        }

        .ticket-card {
            background-color: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .ticket-card:hover {
            transform: translateY(-4px);
        }

        .ticket-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }

        .ticket-info {
            padding: 16px;
        }

        .ticket-info h3 {
            margin: 0;
            font-size: 20px;
            color: #333;
        }

        .ticket-info p {
            margin: 8px 0;
            color: #555;
            font-size: 14px;
        }

        .ticket-info .price {
            font-weight: 600;
            color: #5a2ebc;
            margin-top: 10px;
        }

        /* Popup form */
        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(0,0,0,0.4);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .popup-form {
            background: #fff;
            border-radius: 16px;
            padding: 40px 30px 30px;
            width: 500px;
            position: relative;
        }

        /* Close button inside the popup */
        .popup-form-header {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 100%;
            display: flex;
            justify-content: flex-end;
        }

        .close-btn {
            background-color: #5a2ebc; /* Added background color */
            border: none;
            font-size: 28px;
            cursor: pointer;
            color: #fff; /* Text color to white for contrast */
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: background 0.3s ease;
            border-radius: 50%;
        }

        /* Hover effect for close button */
        .close-btn:hover {
            background-color: #4725a1; /* Darken the background on hover */
        }

        /* Popup form styling */
        .popup-form h3 {
            font-size: 22px;
            margin-bottom: 24px;
            color: #4c3575;
            text-align: center;
        }

        .popup-form input,
        .popup-form textarea {
            width: 100%;
            margin-bottom: 18px;
            padding: 12px 14px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        .popup-form input:focus,
        .popup-form textarea:focus {
            border: 1px solid #7e3ff2;
        	box-shadow: 0 0px 5px #7e3ff2;
            outline: none;
        }

        .popup-form button[type='submit'] {
            background: #5a2ebc;
            color: #fff;
            padding: 12px 18px;
            font-size: 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .popup-form button[type='submit']:hover {
            background: #4725a1;
        }

        /* Cancel button inside the popup */
        .cancel-btn {
            background-color: #e74c3c;
            color: white;
            padding: 10px 18px;
            font-size: 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 10px;
        }

        .cancel-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>

<div class="main-content">
    <h2 class="page-title">Manage Ticket Types</h2>

    <button class="add-ticket-btn" onclick="document.querySelector('.popup-overlay').style.display='flex'">
        + Add Ticket Type
    </button>

    <div class="ticket-container">
        <!-- Example Ticket Type Cards -->
        <div class="ticket-card">
            <img src="https://via.placeholder.com/400x180.png?text=VIP+Ticket" alt="VIP Ticket">
            <div class="ticket-info">
                <h3>VIP Ticket</h3>
                <p>Access to premium seating and lounge area with refreshments included.</p>
                <p class="price">Rs. 5000</p>
            </div>
        </div>

        <div class="ticket-card">
            <img src="https://via.placeholder.com/400x180.png?text=Normal+Ticket" alt="Normal Ticket">
            <div class="ticket-info">
                <h3>Normal Ticket</h3>
                <p>General seating with good view of the field. Basic amenities.</p>
                <p class="price">Rs. 1000</p>
            </div>
        </div>
    </div>
</div>

<!-- Popup Form -->
<div class="popup-overlay">
    <div class="popup-form">
        <div class="popup-form-header">
            <button class="close-btn" onclick="document.querySelector('.popup-overlay').style.display='none'">&times;</button>
        </div>
        <h3>Add New Ticket Type</h3>
        <form action="add-ticket-type" method="post">
            <div style="display: flex; gap: 15px;">
                <input type="text" name="ticketName" placeholder="Ticket Name" required style="flex: 1;">
                <input type="number" name="price" placeholder="Price (Rs.)" required style="flex: 1;">
            </div>

            <textarea name="description" rows="4" placeholder="Description" required></textarea>
            <input type="text" name="imageUrl" placeholder="Image URL (optional)">

            <div style="text-align: right; margin-top: 10px;">
                <button type="submit">Add Ticket</button>
                <button type="button" class="cancel-btn" onclick="document.querySelector('.popup-overlay').style.display='none'">Cancel</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
