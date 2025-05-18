package com.nplticket.controller.admin;

import com.nplticket.model.TicketModel;
import com.nplticket.service.admin.ManageTicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/admin/manage-tickets" })
public class ManageTicketController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ManageTicketService manageTicketsService;
    private static final int DEFAULT_ROWS_PER_PAGE = 15;

    @Override
    public void init() throws ServletException {
        manageTicketsService = new ManageTicketService();
        System.out.println("ManageTicketController initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("doGet: Fetching tickets");

        // Get pagination, rows per page, and search parameters
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                System.err.println("doGet: Invalid page number: " + pageParam);
            }
        }

        int rowsPerPage = DEFAULT_ROWS_PER_PAGE;
        String rowsPerPageParam = request.getParameter("rowsPerPage");
        if (rowsPerPageParam != null && !rowsPerPageParam.isEmpty()) {
            try {
                rowsPerPage = Integer.parseInt(rowsPerPageParam);
                if (rowsPerPage < 1) rowsPerPage = DEFAULT_ROWS_PER_PAGE;
            } catch (NumberFormatException e) {
                System.err.println("doGet: Invalid rows per page: " + rowsPerPageParam);
            }
        }

        String searchTerm = request.getParameter("search");
        if (searchTerm == null) {
            searchTerm = "";
        }

        try {
            // Fetch tickets with search filtering
            List<TicketModel> allTickets = manageTicketsService.getAllTickets(searchTerm);
            int totalTickets = allTickets.size();
            int totalPages = (int) Math.ceil((double) totalTickets / rowsPerPage);
            if (totalPages == 0) totalPages = 1;

            // Apply server-side pagination
            int startIndex = (page - 1) * rowsPerPage;
            int endIndex = Math.min(startIndex + rowsPerPage, totalTickets);
            List<TicketModel> paginatedTickets = allTickets.subList(startIndex, endIndex);

            // Set attributes for the JSP
            request.setAttribute("tickets", paginatedTickets);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("/WEB-INF/pages/admin/manage-ticket.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("doGet: Error: " + e.getMessage());
            request.getSession().setAttribute("message", "Error fetching ticket details: " + e.getMessage());
            handleError(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("doPost: Received action: " + action);

        if (action != null) {
            try {
                if (action.equals("delete")) {
                    String ticketId = request.getParameter("ticketId");
                    System.out.println("doPost: Deleting ticket ID " + ticketId);
                    manageTicketsService.deleteTicket(ticketId);
                    request.getSession().setAttribute("message", "Ticket deleted successfully.");
                } else if (action.equals("update")) {
                    String ticketId = request.getParameter("ticketId");
                    String status = request.getParameter("status");

                    System.out.println("doPost: Updating ticket ID " + ticketId + " with status=" + status);

                    if (ticketId == null || ticketId.trim().isEmpty() || status == null || status.trim().isEmpty()) {
                        throw new IllegalArgumentException("Ticket ID and Status are required.");
                    }

                    if (!status.equals("Attended") && !status.equals("Absent")) {
                        throw new IllegalArgumentException("Status must be either 'Attended' or 'Absent'.");
                    }

                    if (!manageTicketsService.ticketExists(ticketId)) {
                        throw new IllegalArgumentException("Ticket ID " + ticketId + " does not exist.");
                    }

                    TicketModel ticket = new TicketModel();
                    ticket.setStatus(status.trim());

                    manageTicketsService.updateTicket(ticketId, ticket);
                    request.getSession().setAttribute("message", "Ticket updated successfully!");
                }

                // Preserve the current page and rows per page after update/delete
                String pageParam = request.getParameter("page");
                int page = 1;
                if (pageParam != null && !pageParam.isEmpty()) {
                    try {
                        page = Integer.parseInt(pageParam);
                        if (page < 1) page = 1;
                    } catch (NumberFormatException e) {
                        System.err.println("doPost: Invalid page number: " + pageParam);
                    }
                }

                String rowsPerPageParam = request.getParameter("rowsPerPage");
                int rowsPerPage = DEFAULT_ROWS_PER_PAGE;
                if (rowsPerPageParam != null && !rowsPerPageParam.isEmpty()) {
                    try {
                        rowsPerPage = Integer.parseInt(rowsPerPageParam);
                        if (rowsPerPage < 1) rowsPerPage = DEFAULT_ROWS_PER_PAGE;
                    } catch (NumberFormatException e) {
                        System.err.println("doPost: Invalid rows per page: " + rowsPerPageParam);
                    }
                }

                response.sendRedirect(request.getContextPath() + "/admin/manage-tickets?page=" + page + 
                    "&rowsPerPage=" + rowsPerPage + "&search=" + (request.getParameter("search") != null ? request.getParameter("search") : ""));
                return;
            } catch (IllegalArgumentException e) {
                System.err.println("doPost: IllegalArgumentException: " + e.getMessage());
                request.getSession().setAttribute("message", "Validation error: " + e.getMessage());
                handleError(request, response);
            } catch (Exception e) {
                System.err.println("doPost: Unexpected error: " + e.getMessage());
                request.getSession().setAttribute("message", "Error processing ticket: " + e.getMessage());
                handleError(request, response);
            }
        } else {
            System.err.println("doPost: Invalid action received");
            request.getSession().setAttribute("message", "Invalid action.");
            handleError(request, response);
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.err.println("handleError: Setting default values due to error");
        request.setAttribute("tickets", new ArrayList<>());
        request.setAttribute("currentPage", 1);
        request.setAttribute("totalPages", 1);
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-ticket.jsp").forward(request, response);
    }
}