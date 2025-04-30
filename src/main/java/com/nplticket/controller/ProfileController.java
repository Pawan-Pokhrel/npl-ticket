package com.nplticket.controller;

import com.nplticket.model.UserModel;
import com.nplticket.service.ProfileService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProfileService profileService;

    @Override
    public void init() throws ServletException {
        profileService = new ProfileService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username"); // Use consistent attribute name

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            UserModel user = profileService.getUserProfile(userId);
            if (user == null) {
                request.setAttribute("message", "User profile not found.");
            } else {
                request.setAttribute("user", user);
                System.out.println("User Address: " + user.getAddress()); // For debugging
            }
            request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error loading profile: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");
        System.out.println("H");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
//        String image = request.getParameter("image"); // Handle file upload if needed
        System.out.println("Ho");
        try {
            // Validate inputs with trimming
            if (isNullOrEmpty(fullName) || isNullOrEmpty(email) || isNullOrEmpty(phone) || isNullOrEmpty(address)) {
                request.setAttribute("message", "All fields are required.");
                request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
                return;
            }
            System.out.println("Hol");
            // Retrieve the current user to preserve the ID
            UserModel currentUser = profileService.getUserProfile(userId);
            if (currentUser == null) {
                request.setAttribute("message", "User not found.");
                request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
                return;
            }
            System.out.println("Hola");
            // Check if the new email is taken by another user
            if (!email.equals(currentUser.getEmail()) && profileService.emailExists(email, userId)) {
                request.setAttribute("message", "Email is already taken by another user.");
                request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
                return;
            }
            
            System.out.println("Holaa");

            // Update the existing UserModel
            currentUser.setFullName(fullName);
            currentUser.setEmail(email);
            currentUser.setPhoneNumber(phone);
            currentUser.setAddress(address);
//            currentUser.setImage(image);

            if (profileService.updateUserProfile(currentUser)) {
                request.setAttribute("message", "Profile updated successfully.");
            } else {
                request.setAttribute("message", "Failed to update profile.");
            }

            response.sendRedirect(request.getContextPath() + "/profile");


        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error updating profile: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
        }
    }

    private boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
}