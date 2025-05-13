package com.nplticket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.nplticket.model.UserModel;
import com.nplticket.service.LogInService;
import com.nplticket.util.CookieUtil;
import com.nplticket.util.PasswordUtil;
import com.nplticket.util.SessionUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/login" })
public class LogInController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private LogInService loginService;

    public LogInController() {
        super();
    }

    @Override
    public void init() throws ServletException {
        loginService = new LogInService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Check for empty fields and set specific error messages
            boolean hasFieldErrors = false;
            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("emailError", "Email is required.");
                hasFieldErrors = true;
            }
            if (password == null || password.trim().isEmpty()) {
                request.setAttribute("passwordError", "Password is required.");
                hasFieldErrors = true;
            }

            if (hasFieldErrors) {
                request.setAttribute("message", "Please fill in all required fields.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
                return;
            }

            UserModel user = loginService.getUserByEmail(email);

            if (user == null || !PasswordUtil.verifyPassword(password, user.getPassword(), email)) {
                request.setAttribute("message", "Invalid email or password.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
                return;
            }

            // Debug: Log the image path
            System.out.println("User Image Path: " + user.getImage());
            if (user.getImage() == null) {
                System.out.println("Warning: User image is null for email: " + email);
            }

            SessionUtil.setAttribute(request, "user", user.getEmail());
            SessionUtil.setAttribute(request, "image", user.getImage());
            String username = user.getEmail().split("@")[0];
            SessionUtil.setAttribute(request, "username", username);

            CookieUtil.addCookie(response, "role", user.getRole(), 86400, true);

            response.sendRedirect(request.getContextPath() + "/");
        } catch (Exception e) {
            request.setAttribute("message", "Login failed: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}