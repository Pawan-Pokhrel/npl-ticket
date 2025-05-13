package com.nplticket.filter;

import com.nplticket.util.CookieUtil;
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

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        HttpSession session = req.getSession(false);

        boolean isLoggedIn = session != null && SessionUtil.getAttribute(req, "user") != null;
        String userRole = CookieUtil.getCookie(req, "role") != null ?
                          CookieUtil.getCookie(req, "role").getValue() : null;


        // ✅ Allow static resources
        if (uri.matches(".*(\\.css|\\.js|\\.png|\\.jpg|\\.jpeg|\\.svg|\\.woff|\\.ttf)$")) {
            chain.doFilter(request, response);
            return;
        }

        // ✅ Allow public pages
        if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER) || uri.endsWith(HOME) || uri.equals(contextPath + ROOT)) {
            chain.doFilter(request, response);
            return;
        }

        // ✅ Handle admin path
//        if (uri.startsWith(contextPath + ADMIN_PATH)) {
//            if (!isLoggedIn) {
//                // Not logged in — redirect to login
//                res.sendRedirect(contextPath + LOGIN);
//                return;
//            } else if (!"admin".equals(userRole)) {
//                // Logged in but not admin — redirect to /booking
//                res.sendRedirect(contextPath + BOOKING_PAGE);
//                return;
//            } else {
//                // Admin user — allow access
//                chain.doFilter(request, response);
//                return;
//            }
//        }

        // ✅ For ticket booking page, require login
        if (uri.contains(TICKET_PAGE)) {
            if (!isLoggedIn) {
                res.sendRedirect(contextPath + LOGIN);
                return;
            }
        }

        // ✅ Allow other requests
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {
        // Optional init
    }

    @Override
    public void destroy() {
        // Optional cleanup
    }
}
