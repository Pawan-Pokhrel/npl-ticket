package com.nplticket.controller.admin;

import com.nplticket.model.TicketTypeModel;
import com.nplticket.service.admin.ManageTicketTypesService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/admin/ticket-types" })
public class ManageTicketTypesController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ManageTicketTypesService ticketService;

    @Override
    public void init() throws ServletException {
        ticketService = new ManageTicketTypesService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<TicketTypeModel> ticketTypes = ticketService.getAllTicketTypes();
            request.setAttribute("ticketTypes", ticketTypes);
            request.getRequestDispatcher("/WEB-INF/pages/admin/ticket-types.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error fetching ticket types: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/admin/ticket-types.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                TicketTypeModel ticket = new TicketTypeModel();
                ticket.setTicketType(request.getParameter("ticketName"));
                ticket.setUnitPrice(Integer.parseInt(request.getParameter("price")));
                ticket.setTicketDesc(request.getParameter("description"));
                ticketService.addTicketType(ticket);
                request.setAttribute("message", "Ticket type added successfully!");
            } else if ("update".equals(action)) {
                TicketTypeModel ticket = new TicketTypeModel();
                ticket.setTicketTypeId(Integer.parseInt(request.getParameter("ticketTypeId")));
                ticket.setTicketType(request.getParameter("ticketName"));
                ticket.setUnitPrice(Integer.parseInt(request.getParameter("price")));
                ticket.setTicketDesc(request.getParameter("description"));
                ticketService.updateTicketType(ticket);
                request.setAttribute("message", "Ticket type updated successfully!");
            } else if ("delete".equals(action)) {
                int ticketTypeId = Integer.parseInt(request.getParameter("ticketTypeId"));
                ticketService.deleteTicketType(ticketTypeId);
                request.setAttribute("message", "Ticket type deleted successfully!");
            }
            List<TicketTypeModel> ticketTypes = ticketService.getAllTicketTypes();
            request.setAttribute("ticketTypes", ticketTypes);
            request.getRequestDispatcher("/WEB-INF/pages/admin/ticket-types.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid numeric input: " + e.getMessage());
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error processing request: " + e.getMessage());
            doGet(request, response);
        }
    }
}