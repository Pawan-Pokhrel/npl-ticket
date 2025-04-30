<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NPL Register</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            height: 100vh;
            background: url('https://cricket.genzaitv.com/wp-content/uploads/2024/11/image-2.png') no-repeat center center/cover;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }
        .container {
            position: relative;
            z-index: 2;
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(7px);
            padding: 40px 30px;
            border-radius: 15px;
            min-width: 370px;
            width: 30%;
            height: 80vh;
            box-shadow: 0 0 32px 0 rgba(31, 38, 135, 0.37);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            place-content: space-between;
        }
        .container h2 {
            margin-bottom: 20px;
            color: #333;
            font-size: 28px;
            font-weight: 700;
            text-align: center;
        }
        .header-text {
            display: flex;
            align-items: center;
            margin-top: 15px;
        }
        .container h2 img {
            width: 90px;
        }
        form {
            width: 90%;
        }
        .form-group {
            width: 100%;
            margin-bottom: 18px;
        }
        .form-group input {
            width: 100%;
            padding: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: rgba(230, 230, 250, 1);
            font-size: 16px;
            outline: none;
            transition: 0.2s ease-in-out;
        }
        .form-group input:focus {
            border: 1px solid #7e3ff2;
        }
        .back-to-home {
            display: block;
            text-align: center;
        }
        button {
            width: 100%;
            padding: 14px;
            background: #7e3ff2;
            border: none;
            color: white;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        button:hover {
            background: #5a2ebc;
        }
        .login-text {
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
        }
        .login-text a {
            color: #7e3ff2;
            text-decoration: none;
            font-weight: 600;
        }

        @media (max-width: 480px) {
            .container {
                width: 90%;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>REGISTER TO <br> 
        <span class="header-text">
            <img src="${pageContext.request.contextPath}/images/NPL-text.png"> Ticket Reservation System
        </span> 
    </h2>

    <form action="register" method="post">
    <div class="form-group">
        <input type="text" name="fullName" placeholder="Full Name" required>
    </div>
    <div class="form-group">
        <input type="email" name="email" placeholder="Email Address" required>
    </div>
    <div class="form-group">
        <input type="tel" name="phone" placeholder="Phone Number" required minlength="10">
    </div>
    <div class="form-group">
        <textarea name="address" placeholder="Address" rows="3" required style="width: 100%; padding: 14px; border: 1px solid #ccc; border-radius: 8px; background-color: rgba(230, 230, 250, 1); font-size: 16px;"></textarea>
    </div>
    <div class="form-group">
        <input type="password" name="password" placeholder="Create Password" required minlength="6">
    </div>
    <div class="form-group">
        <input type="password" name="confirmPassword" placeholder="Confirm Password" required minlength="6">
    </div>

    <!-- Hidden isVerified field -->
    <input type="hidden" name="isVerified" value="false">

    <button type="submit">Sign Up</button>
</form>


    <div class="login-text">
        Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a><br><br>
        <span class="back-to-home">Return to Homepage? <a href="${pageContext.request.contextPath}/">Go back</a></span>
    </div>
</div>
</body>
</html>
