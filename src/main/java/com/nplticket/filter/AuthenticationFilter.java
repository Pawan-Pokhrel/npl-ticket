package com.nplticket.filter;

import com.nplticket.model.UserModel;
import com.nplticket.service.LogInService;
import com.nplticket.util.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    private static final String LOGIN = "/login";
    private static final String REGISTER = "/register";
    private static final String HOME = "/home";
    private static final String ROOT = "/";
    private static final String TICKET_PAGE = "/booktickets";
    private static final String ADMIN_PATH = "/admin";
    private static final String BOOKING_PAGE = "/mybookings";

    private LogInService logInService;

    @Override
    public void init(FilterConfig filterConfig) {
        logInService = new LogInService();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.startsWith(contextPath) ? uri.substring(contextPath.length()) : uri;
        if (path.isEmpty()) path = "/";
        HttpSession session = req.getSession(false);

        // Debug: Log request details
        System.out.println("Request URI: " + uri + ", Path: " + path + ", ContextPath: " + contextPath + ", Session: " + (session != null ? session.getId() : "null"));

        // Check for logged-in user (user attribute is the email as a String)
        String userEmail = (session != null) ? (String) SessionUtil.getAttribute(req, "user") : null;
        boolean isLoggedIn = userEmail != null;

        // Debug: Log authentication status
        System.out.println("isLoggedIn: " + isLoggedIn + ", userEmail: " + userEmail);

        // Allow static resources
        if (uri.matches(".*(\\.css|\\.js|\\.png|\\.jpg|\\.jpeg|\\.svg|\\.woff|\\.ttf)$")) {
            System.out.println("Static resource, allowing: " + uri);
            chain.doFilter(request, response);
            return;
        }

        // Allow public pages
        if (path.equals(ROOT) || path.equals(LOGIN) || path.equals(REGISTER) || path.equals(HOME)) {
            System.out.println("Public page, allowing: " + path);
            // If logged in and trying to access login page, redirect to home
            if (isLoggedIn && path.equals(LOGIN)) {
                System.out.println("Logged-in user tried to access login page, redirecting to home");
                res.sendRedirect(contextPath + HOME);
                return;
            }
            chain.doFilter(request, response);
            return;
        }

        // Handle admin path
        if (path.startsWith(ADMIN_PATH) || path.equals(ADMIN_PATH + "/")) {
            System.out.println("Admin path accessed: " + path + ", isLoggedIn: " + isLoggedIn);
            if (!isLoggedIn || userEmail == null) {
                System.out.println("Not logged in, redirecting to login");
                res.sendRedirect(contextPath + LOGIN);
                return;
            }

            // Fetch user from database to verify role
            UserModel user = logInService.getUserByEmail(userEmail);
            if (user == null) {
                System.out.println("User not found in database, invalidating session and redirecting to login");
                if (session != null) {
                    session.invalidate();
                }
                res.sendRedirect(contextPath + LOGIN);
                return;
            }

            if (!"admin".equalsIgnoreCase(user.getRole())) {
                System.out.println("Not an admin (role: " + user.getRole() + "), redirecting to bookings");
                res.sendRedirect(contextPath + "/");
                return;
            }

            // Admin user — allow access
            System.out.println("Admin access granted for user: " + userEmail);
            chain.doFilter(request, response);
            return;
        }

        // For ticket booking page, require login
        if (path.contains(TICKET_PAGE)) {
            System.out.println("Ticket page accessed: " + path + ", isLoggedIn: " + isLoggedIn);
            if (!isLoggedIn) {
                System.out.println("Ticket page accessed without login, redirecting to login");
                res.sendRedirect(contextPath + LOGIN);
                return;
            }
        }

        // Allow other requests
        System.out.println("Allowing other request: " + path);
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Optional cleanup
    }
}