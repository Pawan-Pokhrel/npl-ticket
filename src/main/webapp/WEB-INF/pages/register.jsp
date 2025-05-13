<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NPL Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
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
            background: rgba(0, 0, 0, 0.6);
            z-index: 1;
        }
        .container {
            position: relative;
            z-index: 2;
            background: linear-gradient(145deg, rgba(255, 255, 255, 0.95), rgba(240, 240, 255, 0.9));
            backdrop-filter: blur(12px);
            padding: 30px 25px;
            border-radius: 20px;
            min-width: 370px;
            width: 35%;
            height: auto;
            max-height: 90vh;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-around;
            transition: all 0.3s ease;
        }
        .container:hover {
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
        }
        .container h2 {
            color: #2c2c54;
            font-size: 28px;
            font-weight: 700;
            text-align: center;
            line-height: 1.3;
            margin-bottom: 15px;
        }
        .message {
            color: #d32f2f;
            text-align: center;
            margin-bottom: 15px;
            font-size: 14px;
        }
        form {
            width: 90%;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .form-group {
            width: 100%;
            margin-bottom: 15px;
            position: relative;
            display: flex;
            align-items: flex-start;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 12px 12px 12px 40px;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            background-color: #f7f7ff;
            font-size: 16px;
            outline: none;
            transition: all 0.3s ease;
            line-height: 1.5;
            transform: translateY(-1px);
        }
        .form-group input:focus, .form-group textarea:focus {
            border-color: #7e3ff2;
            box-shadow: 0 0 10px #7e3ff2;
        }
        .form-group i {
            position: absolute;
            left: 12px;
            top: 12px;
            font-size: 20px;
            color: #7e3ff2;
            opacity: 0.6;
            z-index: 10;
            transition: opacity 0.3s ease;
            pointer-events: none;
        }
        .form-group textarea ~ i {
            top: 12px;
        }
        .form-group:focus-within i, .form-group i {
            opacity: 1;
            display: inline-block;
        }
        .avatar-container {
            position: relative;
            margin-bottom: 20px;
            width: 120px;
            height: 120px;
            transition: transform 0.3s ease;
        }
        .avatar-container:hover {
            transform: scale(1.05);
        }
        .avatar {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 50px;
            color: #7e3ff2;
            border: 4px solid #7e3ff2;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            overflow: hidden; /* Ensure the image stays within bounds */
        }
        .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }
        .upload-icon {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 35px;
            height: 35px;
            background: #7e3ff2;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: white;
            font-size: 18px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            transition: background 0.3s ease;
        }
        .upload-icon:hover {
            background: #5a2ebc;
        }
        .file-input {
            display: none;
        }
        .back-to-home {
            display: block;
            text-align: center;
        }
        button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(90deg, #7e3ff2, #a67bff);
            border: none;
            color: white;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(126, 63, 242, 0.3);
        }
        button:hover {
            background: linear-gradient(90deg, #5a2ebc, #8b5cf6);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(126, 63, 242, 0.4);
        }
        .login-text {
            margin-top: 15px;
            font-size: 14px;
            text-align: center;
            color: #666;
        }
        .login-text a {
            color: #7e3ff2;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        .login-text a:hover {
            color: #5a2ebc;
        }
        @media (max-width: 480px) {
            .container {
                width: 90%;
                padding: 25px 20px;
                max-height: 95vh;
            }
            .container h2 {
                font-size: 24px;
            }
            .avatar-container {
                width: 100px;
                height: 100px;
            }
            .avatar {
                font-size: 40px;
            }
            .upload-icon {
                width: 30px;
                height: 30px;
                font-size: 16px;
            }
            .form-group input, .form-group textarea {
                font-size: 14px;
                padding: 10px 10px 10px 35px;
            }
            .form-group i {
                font-size: 18px;
                left: 10px;
                top: 10px;
            }
            button {
                font-size: 16px;
                padding: 12px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Sign Up</h2>
    <% if (request.getAttribute("message") != null) { %>
        <div class="message"><%= request.getAttribute("message") %></div>
    <% } %>

    <form action="register" method="post" enctype="multipart/form-data">
        <div class="avatar-container">
            <div class="avatar">
                <i class="fas fa-user"></i>
            </div>
            <span class="upload-icon"><i class="fas fa-camera"></i></span>
            <input type="file" id="image" name="image" class="file-input" accept="image/*">
        </div>

        <div class="form-group">
            <i class="fas fa-user"></i>
            <input type="text" name="fullName" placeholder="Full Name" required>
        </div>
        <div class="form-group">
            <i class="fas fa-envelope"></i>
            <input type="email" name="email" placeholder="Email Address" required>
        </div>
        <div class="form-group">
            <i class="fas fa-phone"></i>
            <input type="tel" name="phone" placeholder="Phone Number" required minlength="10">
        </div>
        <div class="form-group">
            <i class="fas fa-home"></i>
            <textarea name="address" placeholder="Address" rows="3" required></textarea>
        </div>
        <div class="form-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="Create Password" required minlength="6">
        </div>
        <div class="form-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required minlength="6">
        </div>

        <input type="hidden" name="isVerified" value="false">

        <button type="submit">Sign Up</button>
    </form>

    <div class="login-text">
        Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a><br><br>
        <span class="back-to-home">Return to Homepage? <a href="${pageContext.request.contextPath}/">Go back</a></span>
    </div>
</div>
<script>
    const uploadIcon = document.querySelector('.upload-icon');
    const fileInput = document.querySelector('.file-input');
    const avatar = document.querySelector('.avatar');

    uploadIcon.addEventListener('click', () => {
        fileInput.click();
    });

    fileInput.addEventListener('change', (e) => {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (event) => {
                // Clear existing content and set the image
                avatar.innerHTML = '';
                const img = document.createElement('img');
                img.src = event.target.result;
                img.style.width = '100%';
                img.style.height = '100%';
                img.style.objectFit = 'cover';
                img.style.borderRadius = '50%';
                avatar.appendChild(img);
                console.log('Image loaded:', event.target.result); // Debugging
            };
            reader.readAsDataURL(file);
            console.log('File selected:', file.name); // Debugging
        } else {
            // Reset to default icon if no file is selected
            avatar.innerHTML = '<i class="fas fa-user"></i>';
            console.log('No file selected, resetting to default icon');
        }
    });
</script>
</body>
</html>