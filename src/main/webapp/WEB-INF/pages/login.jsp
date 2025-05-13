<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NPL Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            height: 100vh;
            background: url('${pageContext.request.contextPath}/images/stadium.png') no-repeat center center/cover;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        /* Dark overlay on background */
        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }
        .notification {
            position: absolute;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            width: 90%;
            max-width: 400px;
            padding: 15px;
            border-radius: 8px;
            color: white;
            text-align: center;
            z-index: 3;
        }
        .notification.success {
            background: #28a745;
        }
        .notification.error {
            background: #dc3545;
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
            height: 70vh;
            box-shadow: 0 0 32px 0 rgba(31, 38, 135, 0.37);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            place-content: space-between;
        }
        .container h2 {
            margin-bottom: 30px;
            color: #333;
            font-size: 28px;
            font-weight: 700;
            text-align: center;
        }
        .header-text {
            display: flex;
            align-items: center;
            margin-top: 25px;
        }
        .container h2 img {
            width: 90px;
        }
        form {
            width: 90%;
        }
        .form-group {
            width: 100%;
            margin-bottom: 20px;
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
            box-shadow: 0 0px 10px #7e3ff2;
        }
        .form-group .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: block;
        }
        .back-to-home {
            display: block;
            text-align: center;
        }
        .options {
            width: 100%;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .options label {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .options a {
            text-decoration: none;
            color: #7e3ff2;
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
        .signup-text {
            margin-top: 20px;
            font-size: 14px;
        }
        .signup-text a {
            color: #7e3ff2;
            text-decoration: none;
            font-weight: 600;
        }
        /* Responsive */
        @media (max-width: 480px) {
            .container {
                width: 90%;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
<% if (request.getAttribute("message") != null) { %>
    <div class="notification <%= request.getAttribute("messageType") %>">
        <%= request.getAttribute("message") %>
    </div>
<% } %>
<div class="container">
    <h2>LOGIN TO <br> <span class="header-text"><img src="${pageContext.request.contextPath}/images/NPL-text.png"> Ticket Reservation System</span> </h2>
    <form action="login" method="post">
        <div class="form-group">
            <input type="email" name="email" placeholder="Email Address" required value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            <% if (request.getAttribute("emailError") != null) { %>
                <span class="error-message"><%= request.getAttribute("emailError") %></span>
            <% } %>
        </div>
        <div class="form-group">
            <input type="password" name="password" placeholder="Enter Password" required minlength="6">
            <% if (request.getAttribute("passwordError") != null) { %>
                <span class="error-message"><%= request.getAttribute("passwordError") %></span>
            <% } %>
        </div>
        <div class="options">
            <label><input type="checkbox" name="rememberMe"> Remember me</label>
            <a href="forgotPassword.jsp">Forgot password?</a>
        </div>
        <button type="submit">Sign In</button>
    </form>
    <div class="signup-text">
        Don't have an account? <a href="${pageContext.request.contextPath}/register">Register now</a><br><br>
        <span class="back-to-home">Return to Homepage? <a href="${pageContext.request.contextPath}/">Go back</a></span>
    </div>
</div>
</body>
</html>