package com.nplticket.service;

import com.nplticket.config.DbConfig;
import com.nplticket.model.MatchModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookTicketService {

    public List<MatchModel> getTBDScheduledMatches() throws SQLException {
        List<MatchModel> matches = new ArrayList<>();
        String query = "SELECT match_id, team1, team2, date, time, venue, audience, status " +
                      "FROM matches " +
                      "WHERE status = 'TBD' " +
                      "ORDER BY date ASC";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                MatchModel match = new MatchModel();
                match.setMatchId(rs.getInt("match_id"));
                match.setTeam1(rs.getString("team1"));
                match.setTeam2(rs.getString("team2"));
                match.setDate(rs.getDate("date").toLocalDate());
                match.setTime(rs.getTime("time").toLocalTime());
                match.setVenue(rs.getString("venue"));
                match.setAudience(rs.getInt("audience"));
                match.setStatus(rs.getString("status"));
                matches.add(match);
            }
            System.out.println("getTBDScheduledMatches: Fetched " + matches.size() + " TBD matches");
        } catch (SQLException e) {
            System.err.println("getTBDScheduledMatches: SQL error: " + e.getMessage());
            throw e;
        }

        return matches;
    }

    public void bookTicket(long userId, int matchId, int ticketQuantity) throws SQLException {
        // Generate a unique booking_id (using max + 1)
        int newBookingId = getNextBookingId();
        
        String query = "INSERT INTO bookings (booking_id, match_no, ticket_quantity, user_id, booking_status) " +
                      "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, newBookingId);
            stmt.setInt(2, matchId);
            stmt.setInt(3, ticketQuantity);
            stmt.setLong(4, userId);
            stmt.setString(5, "Pending"); // 0 for Pending status
            int rowsAffected = stmt.executeUpdate();
            System.out.println("bookTicket: Inserted booking for user ID " + userId + ", match ID " + matchId + 
                              ", booking ID " + newBookingId + ", rows affected: " + rowsAffected);
            if (rowsAffected == 0) {
                System.out.println("bookTicket: No booking inserted for user ID " + userId + ", match ID " + matchId);
            }
        } catch (SQLException e) {
            System.err.println("bookTicket: SQL error: " + e.getMessage());
            throw e;
        }
    }

    private int getNextBookingId() throws SQLException {
        int nextId = 1; // Default starting value
        String query = "SELECT MAX(booking_id) as max_id FROM bookings";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                int maxId = rs.getInt("max_id");
                nextId = maxId + 1;
            }
            System.out.println("getNextBookingId: Generated next booking ID: " + nextId);
        } catch (SQLException e) {
            System.err.println("getNextBookingId: SQL error: " + e.getMessage());
            throw e;
        }
        return nextId;
    }
}