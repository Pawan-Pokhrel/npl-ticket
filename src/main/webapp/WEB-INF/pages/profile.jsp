<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ include file="user-sidebar.jsp" %>
<%@ include file="footer.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile | NPL Ticket Reservation</title>
    <style>
        body {
            background: linear-gradient(to right, #eae6f9, #f5f7fa);
            font-family: 'Poppins', sans-serif;
            margin: 0;
        }
        .main-content {
            margin-left: 240px;
            padding: 60px;
            box-sizing: border-box;
            min-height: 80dvh;
            width: calc(100% - 240px);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .profile-container {
            background: #fff;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(122, 82, 255, 0.15);
            width: 70%;
            max-width: 900px;
        }
        .profile-picture {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        .profile-picture img {
            width: 180px;
            height: 180px;
            object-fit: cover;
            border-radius: 50%;
            border: 5px solid #a08be0;
            box-shadow: 0 0 15px rgba(160, 139, 224, 0.4);
        }
        .profile-info, .profile-edit-form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: flex-start;
        }
        .profile-info p {
            font-size: 17px;
            color: #333;
            width: 100%;
            background: #f0ecfa;
            padding: 12px 20px;
            border-radius: 10px;
            text-align: left;
            box-shadow: inset 0 0 3px rgba(160, 139, 224, 0.2);
        }
        .profile-info span {
            font-weight: 600;
            color: #000000;
        }
        .edit-btn {
            margin-top: 20px;
            padding: 12px 30px;
            background: #7e3ff2;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            align-self: center;
            transition: background 0.3s;
        }
        .edit-btn:hover {
            background: #5a2ebc;
        }
        .profile-edit-form {
            display: none;
            margin-top: 20px;
            width: 100%;
        }
        .profile-edit-form input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 16px;
        }
        .profile-edit-form button {
            margin-top: 20px;
            padding: 12px 30px;
            background: #7e3ff2;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .profile-edit-form button:hover {
            background: #5a2ebc;
        }
        .alert {
            padding: 15px;
            background-color: #f44336;
            color: white;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .alert.success {
            background-color: #4CAF50;
        }
    </style>
</head>
<body>

<div class="main-content">
    <div class="profile-container">
        <!-- Success/Error message display -->
        <c:if test="${not empty message}">
            <div class="alert ${messageType}">
                <p>${message}</p>
            </div>
        </c:if>

        <div class="profile-picture">
            <img src="${pageContext.request.contextPath}/images/${user.image}" alt="Profile Picture">
        </div>
        <div class="profile-info" id="profileInfo">
            <p><span>Name:</span> <span id="displayName">${user.getFullName()}</span></p>
            <p><span>Email:</span> <span id="displayEmail">${user.email}</span></p>
            <p><span>Phone:</span> <span id="displayPhone">${user.phoneNumber}</span></p>
            <p><span>Address:</span> <span id="displayAddress">${user.getAddress() != null ? user.address : 'Not provideddd '}</span></p>
            <p><span>Joined On:</span> <span id="displayJoined">${user.createdAt}</span></p>
            <button class="edit-btn" onclick="toggleEdit()">Edit Profile</button>
        </div>

        <form class="profile-edit-form" id="profileEditForm" action="${pageContext.request.contextPath}/profile" method="POST" >
            <input type="text" id="nameInput" name="fullName" value="${user.getFullName()}" required>
            <input type="email" id="emailInput" name="email" value="${user.email}" required>
            <input type="text" id="phoneInput" name="phoneNumber" value="${user.phoneNumber}" required>
            <input type="text" id="addressInput" name="address" value="${user.address}" required>
            <!-- <input type="file" id="imageInput" name="image"> -->
            <button type="submit">Save Changes</button>
        </form>
    </div>
</div>

<script>
    const profileData = {
        name: document.getElementById('displayName').innerText,
        email: document.getElementById('displayEmail').innerText,
        phone: document.getElementById('displayPhone').innerText,
        address: document.getElementById('displayAddress').innerText,
        joined: document.getElementById('displayJoined').innerText
    };

    function toggleEdit() {
        document.getElementById('profileInfo').style.display = 'none';
        const form = document.getElementById('profileEditForm');
        form.style.display = 'flex';
    }
    
    console.log("User Address:", document.getElementById('displayName').innerText);


    // Optional: You can add an event listener for form submission to handle AJAX or form data.
</script>

</body>
</html>
 	