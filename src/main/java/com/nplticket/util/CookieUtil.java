package com.nplticket.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.Arrays;

/**
 * Utility class for managing HTTP cookies securely.
 */
public class CookieUtil {

    /**
     * Adds a secure cookie with HttpOnly and optional SameSite attribute.
     *
     * @param response the HttpServletResponse to add the cookie to
     * @param name     the name of the cookie
     * @param value    the value of the cookie
     * @param maxAge   the max age in seconds
     * @param isSecure true if the cookie should be sent only over HTTPS
     */
    public static void addCookie(HttpServletResponse response, String name, String value, int maxAge, boolean isSecure) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setSecure(isSecure); // Send over HTTPS only if secure

        response.addCookie(cookie);

        // Optionally add SameSite=Strict or Lax using header (Servlet API < 6 doesn't support SameSite natively)
        String sameSiteValue = "Strict"; // or "Lax", depending on your use case
        response.setHeader("Set-Cookie", String.format(
                "%s=%s; Max-Age=%d; Path=/; %s%s; SameSite=%s",
                name,
                value,
                maxAge,
                isSecure ? "Secure; " : "",
                "HttpOnly",
                sameSiteValue
        ));
    }

    /**
     * Retrieves a cookie by name from the request.
     *
     * @param request the HttpServletRequest containing the cookies
     * @param name    the name of the cookie to retrieve
     * @return the Cookie if found, otherwise null
     */
    public static Cookie getCookie(HttpServletRequest request, String name) {
        if (request.getCookies() != null) {
            return Arrays.stream(request.getCookies())
                    .filter(cookie -> name.equals(cookie.getName()))
                    .findFirst()
                    .orElse(null);
        }
        return null;
    }

    /**
     * Deletes a cookie by name by setting its max age to 0.
     *
     * @param response the HttpServletResponse to add the deletion cookie
     * @param name     the name of the cookie to delete
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setSecure(true); // Adjust based on your deployment
        response.addCookie(cookie);

        // Ensure SameSite is also considered in deletion
        response.setHeader("Set-Cookie", String.format(
                "%s=; Max-Age=0; Path=/; Secure; HttpOnly; SameSite=Strict",
                name
        ));
    }
}
