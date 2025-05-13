package com.nplticket.controller;

import com.nplticket.model.MatchModel;
import com.nplticket.model.UserModel;
import com.nplticket.service.BookTicketService;
import com.nplticket.service.LogInService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = {"/book-tickets"})
public class BookTicketController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookTicketService bookTicketService;
    private LogInService logInService;

    @Override
    public void init() throws ServletException {
        bookTicketService = new BookTicketService();
        logInService = new LogInService();
        System.out.println("BookTicketController initialized");
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

        try {
            List<MatchModel> matches = bookTicketService.getTBDScheduledMatches();
            System.out.println("doGet: Fetched " + matches.size() + " TBD matches");
            request.setAttribute("matches", matches);
            request.getRequestDispatcher("/WEB-INF/pages/bookTicket.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("doGet: Error: " + e.getMessage());
            request.setAttribute("message", "Error fetching matches: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.setAttribute("matches", new ArrayList<>());
            request.getRequestDispatcher("/WEB-INF/pages/bookTicket.jsp").forward(request, response);
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
            try {
				request.setAttribute("matches", bookTicketService.getTBDScheduledMatches());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            request.getRequestDispatcher("/WEB-INF/pages/bookTicket.jsp").forward(request, response);
            return;
        }

        long userId = user.getId();
        try {
            int matchId = Integer.parseInt(request.getParameter("matchId"));
            int ticketQuantity = Integer.parseInt(request.getParameter("quantity"));

            // Validate ticket quantity
            if (ticketQuantity < 1 || ticketQuantity > 10) {
                request.setAttribute("message", "Ticket quantity must be between 1 and 10.");
                request.setAttribute("messageType", "error");
            } else {
                bookTicketService.bookTicket(userId, matchId, ticketQuantity);
                request.setAttribute("message", "Booking successful! Check your bookings for details.");
                request.setAttribute("messageType", "success");
            }
        } catch (NumberFormatException e) {
            System.err.println("doPost: NumberFormatException: " + e.getMessage());
            request.setAttribute("message", "Invalid match ID or ticket quantity.");
            request.setAttribute("messageType", "error");
        } catch (Exception e) {
            System.err.println("doPost: Error: " + e.getMessage());
            request.setAttribute("message", "Error booking tickets: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }

        try {
            List<MatchModel> matches = bookTicketService.getTBDScheduledMatches();
            request.setAttribute("matches", matches);
            request.getRequestDispatcher("/WEB-INF/pages/bookTicket.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("doPost: Error refreshing matches: " + e.getMessage());
            request.setAttribute("matches", new ArrayList<>());
            request.getRequestDispatcher("/WEB-INF/pages/bookTicket.jsp").forward(request, response);
        }
    }
}