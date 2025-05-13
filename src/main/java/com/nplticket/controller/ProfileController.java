package com.nplticket.controller;

import com.nplticket.model.UserModel;
import com.nplticket.service.ProfileService;
import com.nplticket.util.ImageUtil;
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

@WebServlet(asyncSupported = true, urlPatterns = {"/profile"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 20) // 10MB per file, 20MB total
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProfileService profileService;
    private ImageUtil imageUtil;
    private static final String UPLOAD_DIR = "images/users/";

    @Override
    public void init() throws ServletException {
        profileService = new ProfileService();
        imageUtil = new ImageUtil();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            UserModel user = profileService.getUserProfile(userId);
            if (user == null) {
                session.setAttribute("message", "User profile not found.");
                session.setAttribute("messageType", "error");
            } else {
                request.setAttribute("user", user);
                session.setAttribute("image", user.getImage());
                System.out.println("User Address: " + user.getAddress());
                System.out.println("Session image set to: " + user.getImage());
            }

            // Check for session-stored message
            String message = (String) session.getAttribute("message");
            String messageType = (String) session.getAttribute("messageType");
            if (message != null && messageType != null) {
                request.setAttribute("message", message);
                request.setAttribute("messageType", messageType);
                // Clear session attributes to prevent repeated display
                session.removeAttribute("message");
                session.removeAttribute("messageType");
            }

            request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Error loading profile: " + e.getMessage());
            session.setAttribute("messageType", "error");
            request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        Part imagePart = request.getPart("image");
        String contextPath = request.getServletContext().getRealPath("");

        try {
            // Validate inputs
            if (isNullOrEmpty(fullName) || isNullOrEmpty(email) || isNullOrEmpty(phone) || isNullOrEmpty(address)) {
                session.setAttribute("message", "All fields are required.");
                session.setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }

            // Retrieve the current user
            UserModel currentUser = profileService.getUserProfile(userId);
            if (currentUser == null) {
                session.setAttribute("message", "User not found.");
                session.setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }

            // Check if the new email is taken by another user
            if (!email.equals(currentUser.getEmail()) && profileService.emailExists(email, userId)) {
                session.setAttribute("message", "Email is already taken by another user.");
                session.setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }

            // Handle image upload
            String imagePath = currentUser.getImage(); // Default to existing image
            if (imagePart != null && imagePart.getSize() > 0) {
                long maxFileSize = 1024 * 1024 * 10; // 10MB limit
                if (imagePart.getSize() > maxFileSize) {
                    session.setAttribute("message", "File size exceeds 10MB limit.");
                    session.setAttribute("messageType", "error");
                    response.sendRedirect(request.getContextPath() + "/profile");
                    return;
                }
                System.out.println("Image part received: " + imagePart.getSubmittedFileName() + ", size: " + imagePart.getSize());
                String targetFileName = currentUser.getId() + ".jpg";
                imagePath = UPLOAD_DIR + targetFileName;

                // Rename existing image if it exists
                File currentImage = new File(imageUtil.getSavePath("users", contextPath) + targetFileName);
                if (currentImage.exists()) {
                    int oldVersion = 1;
                    File oldImage;
                    do {
                        oldImage = new File(imageUtil.getSavePath("users", contextPath) + currentUser.getId() + "-old" + oldVersion + ".jpg");
                        oldVersion++;
                    } while (oldImage.exists());
                    System.out.println("Renaming existing image to: " + oldImage.getAbsolutePath());
                    boolean renameSuccess = currentImage.renameTo(oldImage);
                    System.out.println("Rename existing image success: " + renameSuccess);
                    if (!renameSuccess) {
                        session.setAttribute("message", "Failed to rename existing image.");
                        session.setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/profile");
                        return;
                    }
                }

                // Upload new image directly as <userId>.jpg
                boolean uploadSuccess = imageUtil.uploadImage(imagePart, "users", contextPath, targetFileName);
                System.out.println("Image upload success: " + uploadSuccess);
                if (!uploadSuccess) {
                    session.setAttribute("message", "Failed to upload new image.");
                    session.setAttribute("messageType", "error");
                    response.sendRedirect(request.getContextPath() + "/profile");
                    return;
                }
            } else {
                System.out.println("No image part provided or size is 0.");
            }

            // Update UserModel
            currentUser.setFullName(fullName);
            currentUser.setEmail(email);
            currentUser.setPhoneNumber(phone);
            currentUser.setAddress(address);
            currentUser.setImage(imagePath);
            System.out.println("Updating user with image path: " + imagePath);

            // Persist changes
            boolean updateSuccess = profileService.updateUserProfile(currentUser);
            System.out.println("Profile update success: " + updateSuccess);
            if (updateSuccess) {
                session.setAttribute("image", imagePath);
                System.out.println("Session image updated to: " + imagePath);
                session.setAttribute("message", "Profile updated successfully.");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Failed to update profile in database.");
                session.setAttribute("messageType", "error");
            }

            response.sendRedirect(request.getContextPath() + "/profile");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Error updating profile: " + e.getMessage());
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }

    private boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
}