package com.nplticket.controller;

import com.nplticket.model.BookingModel;
import com.nplticket.model.UserModel;
import com.nplticket.service.BookingService;
import com.nplticket.service.LogInService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = {"/mybookings"})
public class BookingController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingService bookingService;
    private LogInService logInService;

    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
        logInService = new LogInService();
        System.out.println("BookingController initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("user");

        if (userEmail == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = logInService.getUserByEmail(userEmail);
        if (user == null) {
            System.err.println("doGet: User not found for email: " + userEmail);
            request.setAttribute("message", "User not found.");
            request.setAttribute("messageType", "error");
            request.setAttribute("bookings", new ArrayList<>());
            request.getRequestDispatcher("/WEB-INF/pages/myBookings.jsp").forward(request, response);
            return;
        }

        long userId = user.getId();
        try {
            List<BookingModel> bookings = bookingService.getUserBookings(userId);
            System.out.println("doGet: Fetched " + bookings.size() + " bookings for user ID " + userId);
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/WEB-INF/pages/myBookings.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("doGet: Error: " + e.getMessage());
            request.setAttribute("message", "Error fetching bookings: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.setAttribute("bookings", new ArrayList<>());
            request.getRequestDispatcher("/WEB-INF/pages/myBookings.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("user");

        if (userEmail == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = logInService.getUserByEmail(userEmail);
        if (user == null) {
            System.err.println("doPost: User not found for email: " + userEmail);
            request.setAttribute("message", "User not found.");
            request.setAttribute("messageType", "error");
            request.setAttribute("bookings", new ArrayList<>());
            request.getRequestDispatcher("/WEB-INF/pages/myBookings.jsp").forward(request, response);
            return;
        }

        long userId = user.getId();
        String action = request.getParameter("action");
        System.out.println("doPost: Received action: " + action);

        if (action != null) {
            try {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                if (action.equals("confirm")) {
                    System.out.println("doPost: Confirming booking ID " + bookingId);
                    bookingService.confirmBooking(bookingId);
                    request.setAttribute("message", "Booking confirmed successfully.");
                    request.setAttribute("messageType", "success");
                } else if (action.equals("cancel")) {
                    System.out.println("doPost: Cancelling booking ID " + bookingId);
                    bookingService.cancelBooking(bookingId);
                    request.setAttribute("message", "Booking cancelled successfully.");
                    request.setAttribute("messageType", "success");
                } else if (action.equals("delete")) {
                    System.out.println("doPost: Deleting booking ID " + bookingId);
                    bookingService.deleteBooking(bookingId);
                    request.setAttribute("message", "Booking deleted successfully.");
                    request.setAttribute("messageType", "success");
                } else {
                    request.setAttribute("message", "Invalid action: " + action);
                    request.setAttribute("messageType", "error");
                }
            } catch (NumberFormatException e) {
                System.err.println("doPost: NumberFormatException: " + e.getMessage());
                request.setAttribute("message", "Invalid booking ID.");
                request.setAttribute("messageType", "error");
            } catch (Exception e) {
                System.err.println("doPost: Error: " + e.getMessage());
                request.setAttribute("message", "Error processing action: " + e.getMessage());
                request.setAttribute("messageType", "error");
            }
        } else {
            System.err.println("doPost: No action specified");
            request.setAttribute("message", "No action specified.");
            request.setAttribute("messageType", "error");
        }

        try {
            List<BookingModel> bookings = bookingService.getUserBookings(userId);
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/WEB-INF/pages/myBookings.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("doPost: Error refreshing bookings: " + e.getMessage());
            request.setAttribute("bookings", new ArrayList<>());
            request.getRequestDispatcher("/WEB-INF/pages/myBookings.jsp").forward(request, response);
        }
    }
}