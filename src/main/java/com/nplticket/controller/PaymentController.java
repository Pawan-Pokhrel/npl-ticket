package com.nplticket.controller;

import com.nplticket.model.BookingModel;
import com.nplticket.model.UserModel;
import com.nplticket.service.LogInService;
import com.nplticket.service.PaymentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = {"/payment"})
public class PaymentController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PaymentService paymentService;
    private LogInService logInService;

    @Override
    public void init() throws ServletException {
        paymentService = new PaymentService();
        logInService = new LogInService();
        System.out.println("PaymentController initialized");
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

        int bookingId;
        try {
            bookingId = Integer.parseInt(request.getParameter("bookingId"));
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid booking ID.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
            return;
        }

        try {
            BookingModel booking = paymentService.getBookingById(bookingId);
            if (booking == null) {
                request.setAttribute("message", "Booking not found.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
                return;
            }
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("doGet: Error: " + e.getMessage());
            request.setAttribute("message", "Error fetching booking details: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
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
            request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
            return;
        }

        int bookingId;
        try {
            bookingId = Integer.parseInt(request.getParameter("bookingId"));
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid booking ID.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
            return;
        }

        try {
            BookingModel booking = paymentService.getBookingById(bookingId);
            if (booking == null) {
                request.setAttribute("message", "Booking not found.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
                return;
            }

            if (!booking.getStatus().equals("Pending")) {
                request.setAttribute("message", "Booking cannot be paid. Status is not Pending.");
                request.setAttribute("messageType", "error");
                request.setAttribute("booking", booking);
                request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
                return;
            }

            int tickets = booking.getTickets();
            if (tickets <= 0) {
                request.setAttribute("message", "Invalid number of tickets: " + tickets);
                request.setAttribute("messageType", "error");
                request.setAttribute("booking", booking);
                request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
                return;
            }

            String paymentMethod = request.getParameter("paymentMethod");
            String identifier = null;
            String bankName = request.getParameter("bankName");

            // Retrieve identifier based on payment method
            if ("Debit Card".equals(paymentMethod)) {
                identifier = request.getParameter("debitCardNumber");
            } else if ("Bank Transfer".equals(paymentMethod)) {
                identifier = request.getParameter("bankUsername");
            } else if ("FonePay".equals(paymentMethod) || "ImePay".equals(paymentMethod)) {
                identifier = request.getParameter("fonePayUsername");
            } else if ("Esewa".equals(paymentMethod) || "Khalti".equals(paymentMethod)) {
                identifier = request.getParameter("esewaIdentifier");
            }

            // Log all parameters for debugging
            System.out.println("doPost: Received parameters - bookingId: " + bookingId + ", paymentMethod: " + paymentMethod + ", identifier: " + identifier + ", bankName: " + bankName);

            if (identifier == null || identifier.trim().isEmpty()) {
                System.err.println("doPost: Identifier is null or empty for paymentMethod: " + paymentMethod);
                request.setAttribute("message", "Identifier cannot be empty. Please fill in the required field.");
                request.setAttribute("messageType", "error");
                request.setAttribute("booking", booking);
                request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
                return;
            }

            double amount = tickets * 1000.0; // Rs. 1000 per ticket

            System.out.println("Processing payment for booking ID: " + bookingId + ", amount: " + amount + ", identifier: " + identifier + ", bankName: " + bankName);

            // Process the payment and get the payment_id
            int paymentId = paymentService.processPayment(bookingId, user.getId(), amount, paymentMethod, identifier, bankName);

            // Redirect to mybookings with success message and payment_id
            response.sendRedirect(request.getContextPath() + "/mybookings?message=Payment+successful.+Booking+confirmed.&messageType=success&paymentId=" + paymentId);
        } catch (Exception e) {
            System.err.println("doPost: Payment processing error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("message", "Error processing payment: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/WEB-INF/pages/payment.jsp").forward(request, response);
        }
    }
}