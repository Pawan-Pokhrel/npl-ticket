package com.nplticket.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.nplticket.service.admin.ViewPaymentService;

import java.io.IOException;

@WebServlet(
    asyncSupported = true,
    urlPatterns = {
        "/admin/view-payments"
    })
public class ViewPaymentsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ViewPaymentService paymentService = new ViewPaymentService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int rowsPerPage = request.getParameter("rowsPerPage") != null ? Integer.parseInt(request.getParameter("rowsPerPage")) : 5;
        String search = request.getParameter("search");

        // Fetch payments using the separate service
        var payments = paymentService.getPayments(page, rowsPerPage, search);
        int totalPayments = paymentService.getTotalPayments(search);
        int totalPages = (int) Math.ceil((double) totalPayments / rowsPerPage);

        // Set attributes
        request.setAttribute("payments", payments);
        request.setAttribute("currentPage", page);
        request.setAttribute("rowsPerPage", rowsPerPage);
        request.setAttribute("totalPages", totalPages > 0 ? totalPages : 1);

        request.getRequestDispatcher("/WEB-INF/pages/admin/view-payments.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}