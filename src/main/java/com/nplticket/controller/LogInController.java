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

            // Validate input
            if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                request.setAttribute("message", "Please fill in all required fields.");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
                return;
            }

            // Retrieve user by email
            UserModel user = loginService.getUserByEmail(email);

            if (user == null || !PasswordUtil.verifyPassword(password, user.getPassword(), email)) {
                request.setAttribute("message", "Invalid email or password.");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
                return;
            }

            // ✅ Store email in session
            SessionUtil.setAttribute(request, "user", user.getEmail());

            // ✅ Extract username from email and store it in session
            String username = user.getEmail().split("@")[0];
            SessionUtil.setAttribute(request, "username", username);

            // ✅ Add role cookie (valid for 1 day = 86400 seconds)
            CookieUtil.addCookie(response, "role", user.getRole(), 86400, true);

            // ✅ Redirect to homepage after successful login
            response.sendRedirect(request.getContextPath() + "/");
        } catch (Exception e) {
            request.setAttribute("message", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}
