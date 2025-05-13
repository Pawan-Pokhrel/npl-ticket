package com.nplticket.controller;

import com.nplticket.model.UserModel;
import com.nplticket.service.RegisterService;
import com.nplticket.util.ImageUtil;
import com.nplticket.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(asyncSupported = true, urlPatterns = {"/register"})
@MultipartConfig(maxFileSize = 10485760) // 10MB max file size
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RegisterService registerService;
    private ImageUtil imageUtil;

    @Override
    public void init() throws ServletException {
        registerService = new RegisterService();
        imageUtil = new ImageUtil();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");
        Part imagePart = request.getPart("image");
        String contextPath = request.getServletContext().getRealPath("");

        try {
            // Validate inputs
            if (fullName == null || email == null || phone == null || password == null || confirmPassword == null ||
                    fullName.isEmpty() || email.isEmpty() || phone.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
                request.setAttribute("message", "All fields are required.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }

            if (!password.equals(confirmPassword)) {
                request.setAttribute("message", "Passwords do not match.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }

            if (registerService.emailExists(email)) {
                request.setAttribute("message", "Email already registered.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }

            String hashedPassword = PasswordUtil.encrypt(email, password);

            UserModel user = new UserModel();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhoneNumber(phone);
            user.setPassword(hashedPassword);
            user.setAddress(address);

            // Register user and get the generated user ID
            long userId = registerService.registerUser(user);

            // Handle image upload if provided
            String imagePath = "images/users/default-user.jpg"; // Default image path
            if (imagePart != null && imagePart.getSize() > 0) {
                boolean uploadSuccess = imageUtil.uploadImage(imagePart, "users", contextPath);
                if (uploadSuccess) {
                    imagePath = "images/users/" + userId + ".jpg";
                    // Rename or move the uploaded file to match the user ID
                    String tempFileName = imageUtil.getImageNameFromPart(imagePart);
                    if (tempFileName != null) {
                        File oldFile = new File(imageUtil.getSavePath("users", contextPath) + tempFileName);
                        File newFile = new File(imageUtil.getSavePath("users", contextPath) + userId + ".jpg");
                        if (oldFile.exists()) {
                            oldFile.renameTo(newFile);
                        }
                    }
                } else {
                    request.setAttribute("message", "Failed to upload image.");
                    request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                    return;
                }
            }

            // Update user with image path
            registerService.updateUserImage(userId, imagePath);

            // Create session for automatic login
            HttpSession session = request.getSession();
            session.setAttribute("username", email.split("@")[0]); // Match ProfileService logic
            session.setAttribute("image", imagePath);
            System.out.println("Session created for username: " + email.split("@")[0] + ", image: " + imagePath);

            request.setAttribute("message", "Registration successful! Welcome to NPL Ticket.");
            request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Registration failed: Database error - " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }
}