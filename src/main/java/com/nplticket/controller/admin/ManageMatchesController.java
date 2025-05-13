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

    @Override
    public void init() throws ServletException {
        manageMatchService = new ManageMatchesService();
        System.out.println("ManageMatchesController initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("doGet: Fetching matches");
        try {
            List<MatchModel> matches = manageMatchService.getAllMatches();
            System.out.println("doGet: Fetched " + (matches != null ? matches.size() : 0) + " matches");
            request.setAttribute("matches", matches);
            request.getRequestDispatcher("/WEB-INF/pages/admin/manage-matches.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("doGet: Error: " + e.getMessage());
            request.getSession().setAttribute("message", "Error fetching match details: " + e.getMessage());
            request.setAttribute("matches", new ArrayList<>());
            request.getRequestDispatcher("/WEB-INF/pages/admin/manage-matches.jsp").forward(request, response);
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

                List<MatchModel> matches = manageMatchService.getAllMatches();
                request.setAttribute("matches", matches);
                request.getRequestDispatcher("/WEB-INF/pages/admin/manage-matches.jsp").forward(request, response);
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
        try {
            List<MatchModel> matches = manageMatchService.getAllMatches();
            request.setAttribute("matches", matches);
        } catch (Exception e) {
            System.err.println("handleError: Error fetching matches: " + e.getMessage());
            request.setAttribute("matches", new ArrayList<>());
        }
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-matches.jsp").forward(request, response);
    }
}