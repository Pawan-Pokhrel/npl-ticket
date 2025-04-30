package com.nplticket.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Utility class for managing HTTP sessions in the NPL Ticket Reservation system.
 * Provides methods to set, get, remove session attributes and invalidate sessions.
 */
public class SessionUtil {

    /**
     * Sets an attribute in the current session.
     *
     * @param request the HttpServletRequest to retrieve the session
     * @param key the attribute key
     * @param value the attribute value
     */
    public static void setAttribute(HttpServletRequest request, String key, Object value) {
        HttpSession session = request.getSession();
        session.setAttribute(key, value);
    }

    /**
     * Gets an attribute from the current session.
     *
     * @param request the HttpServletRequest to retrieve the session
     * @param key the attribute key
     * @return the attribute value, or null if session or attribute not found
     */
    public static Object getAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return session.getAttribute(key);
        }
        return null;
    }

    /**
     * Removes an attribute from the current session.
     *
     * @param request the HttpServletRequest to retrieve the session
     * @param key the attribute key
     */
    public static void removeAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(key);
        }
    }

    /**
     * Invalidates the current session.
     *
     * @param request the HttpServletRequest to retrieve the session
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
