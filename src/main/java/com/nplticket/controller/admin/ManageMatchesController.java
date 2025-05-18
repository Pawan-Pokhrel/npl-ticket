package com.nplticket.controller.admin;

import com.nplticket.model.MatchModel;
import com.nplticket.service.admin.ManageMatchesService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = {"/admin/manage-matches"})
public class ManageMatchesController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ManageMatchesService manageMatchService;
    private static final int DEFAULT_ROWS_PER_PAGE = 15;

    @Override
    public void init() throws ServletException {
        manageMatchService = new ManageMatchesService();
        System.out.println("ManageMatchesController initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("doGet: Fetching matches");

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
            // Fetch matches with search filtering
            List<MatchModel> allMatches = manageMatchService.getAllMatches(searchTerm);
            int totalMatches = allMatches.size();
            int totalPages = (int) Math.ceil((double) totalMatches / rowsPerPage);
            if (totalPages == 0) totalPages = 1;

            // Apply server-side pagination
            int startIndex = (page - 1) * rowsPerPage;
            int endIndex = Math.min(startIndex + rowsPerPage, totalMatches);
            List<MatchModel> paginatedMatches = allMatches.subList(startIndex, endIndex);

            // Set attributes for the JSP
            request.setAttribute("matches", paginatedMatches);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("/WEB-INF/pages/admin/manage-matches.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("doGet: Error: " + e.getMessage());
            request.getSession().setAttribute("message", "Error fetching match details: " + e.getMessage());
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
                    int matchId = Integer.parseInt(request.getParameter("matchId"));
                    System.out.println("doPost: Deleting match ID " + matchId);
                    manageMatchService.deleteMatch(matchId);
                    request.getSession().setAttribute("message", "Match deleted successfully.");
                } else if (action.equals("add") || action.equals("edit")) {
                    String team1 = request.getParameter("team1");
                    String team2 = request.getParameter("team2");
                    String date = request.getParameter("date");
                    String time = request.getParameter("time");
                    String venue = request.getParameter("venue");
                    String audienceStr = request.getParameter("audience");
                    String status = request.getParameter("status");

                    System.out.println("doPost: Processing " + action + " with team1=" + team1 + ", team2=" + team2 + ", date=" + date + ", time=" + time);

                    if (team1 == null || team1.trim().isEmpty() || team2 == null || team2.trim().isEmpty() ||
                        date == null || date.trim().isEmpty() || time == null || time.trim().isEmpty() ||
                        venue == null || venue.trim().isEmpty()) {
                        throw new IllegalArgumentException("Team 1, Team 2, Date, Time, and Venue are required.");
                    }

                    int audience = 0;
                    if (audienceStr != null && !audienceStr.trim().isEmpty()) {
                        audience = Integer.parseInt(audienceStr);
                    }
                    if (status == null || status.trim().isEmpty()) {
                        status = "Not Started";
                    }

                    MatchModel match = new MatchModel();
                    match.setTeam1(team1.trim());
                    match.setTeam2(team2.trim());
                    try {
                        match.setDate(java.time.LocalDate.parse(date));
                        match.setTime(java.time.LocalTime.parse(time));
                    } catch (DateTimeParseException e) {
                        throw new IllegalArgumentException("Invalid date or time format. Use YYYY-MM-DD for date and HH:MM for time.");
                    }
                    match.setVenue(venue.trim());
                    match.setAudience(audience);
                    match.setStatus(status.trim());

                    if (action.equals("add")) {
                        System.out.println("doPost: Adding new match");
                        manageMatchService.saveMatch(match);
                        request.getSession().setAttribute("message", "Match added successfully!");
                    } else if (action.equals("edit")) {
                        int matchId = Integer.parseInt(request.getParameter("matchId"));
                        System.out.println("doPost: Editing match ID " + matchId);
                        if (!manageMatchService.matchExists(matchId)) {
                            throw new IllegalArgumentException("Match ID " + matchId + " does not exist.");
                        }
                        manageMatchService.updateMatch(matchId, match);
                        request.getSession().setAttribute("message", "Match updated successfully!");
                    }
                }

                // Preserve the current page, rows per page, and search term after update/delete
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

                response.sendRedirect(request.getContextPath() + "/admin/manage-matches?page=" + page + 
                    "&rowsPerPage=" + rowsPerPage + "&search=" + (request.getParameter("search") != null ? request.getParameter("search") : ""));
                return;
            } catch (NumberFormatException e) {
                System.err.println("doPost: NumberFormatException: " + e.getMessage());
                request.getSession().setAttribute("message", "Invalid numeric input: " + e.getMessage());
                handleError(request, response);
            } catch (IllegalArgumentException e) {
                System.err.println("doPost: IllegalArgumentException: " + e.getMessage());
                request.getSession().setAttribute("message", "Validation error: " + e.getMessage());
                handleError(request, response);
            } catch (Exception e) {
                System.err.println("doPost: Unexpected error: " + e.getMessage());
                request.getSession().setAttribute("message", "Error processing match: " + e.getMessage());
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
        request.setAttribute("matches", new ArrayList<>());
        request.setAttribute("currentPage", 1);
        request.setAttribute("totalPages", 1);
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-matches.jsp").forward(request, response);
    }
}