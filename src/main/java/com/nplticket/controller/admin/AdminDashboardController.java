package com.nplticket.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.nplticket.service.admin.AdminDashboardService;

@WebServlet(
    asyncSupported = true,
    urlPatterns = {
        "/admin/",
        "/admin/dashboard"
    })
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDashboardService dashboardService = new AdminDashboardService();

    public AdminDashboardController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch data from service layer
        int totalMatches = dashboardService.getTotalMatches();
        int ticketsSold = dashboardService.getTotalTicketsSold();
        int registeredUsers = dashboardService.getTotalUsers();
        double totalRevenue = dashboardService.getTotalRevenue();
        int totalBookings = dashboardService.getTotalBookings();
        int pendingPayments = dashboardService.getPendingPayments();

        // Set attributes for JSP
        request.setAttribute("totalMatches", totalMatches);
        request.setAttribute("ticketsSold", ticketsSold);
        request.setAttribute("registeredUsers", registeredUsers);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("pendingPayments", pendingPayments);

        // Set current date in Nepal time (09:25 PM +0545, May 18, 2025)
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, hh:mm a z");
        sdf.setTimeZone(java.util.TimeZone.getTimeZone("Asia/Kathmandu"));
        String currentDate = sdf.format(new Date());
        request.setAttribute("currentDate", currentDate);

        request.getRequestDispatcher("/WEB-INF/pages/admin/dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}