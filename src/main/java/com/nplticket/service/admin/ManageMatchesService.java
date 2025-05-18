package com.nplticket.service.admin;

import com.nplticket.model.MatchModel;
import com.nplticket.config.DbConfig;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class ManageMatchesService {

    // Fetch all matches with search filtering
    public List<MatchModel> getAllMatches(String searchTerm) throws SQLException {
        List<MatchModel> matches = new ArrayList<>();
        String query = "SELECT * FROM matches WHERE match_id LIKE ? OR team1 LIKE ? OR team2 LIKE ? OR " +
                       "date LIKE ? OR time LIKE ? OR venue LIKE ? OR status LIKE ? ORDER BY date, time";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern); // match_id
            stmt.setString(2, searchPattern); // team1
            stmt.setString(3, searchPattern); // team2
            stmt.setString(4, searchPattern); // date
            stmt.setString(5, searchPattern); // time
            stmt.setString(6, searchPattern); // venue
            stmt.setString(7, searchPattern); // status

            try (ResultSet rs = stmt.executeQuery()) {
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
                System.out.println("getAllMatches: Fetched " + matches.size() + " matches with search term: " + searchTerm);
            }
        } catch (SQLException e) {
            System.err.println("getAllMatches: SQL error: " + e.getMessage());
            throw e;
        }

        return matches;
    }

    // Check if a match exists based on matchId
    public boolean matchExists(int matchId) throws SQLException {
        String query = "SELECT match_id FROM matches WHERE match_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, matchId);
            ResultSet rs = stmt.executeQuery();
            boolean exists = rs.next();
            System.out.println("matchExists: Match ID " + matchId + " exists: " + exists);
            return exists;
        } catch (SQLException e) {
            System.err.println("matchExists: SQL error: " + e.getMessage());
            throw e;
        }
    }

    // Register a new match
    public void saveMatch(MatchModel match) throws SQLException {
        int newMatchId = getNextMatchId();
        match.setMatchId(newMatchId);

        String query = "INSERT INTO matches (match_id, team1, team2, date, time, venue, audience, status) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, match.getMatchId());
            stmt.setString(2, match.getTeam1());
            stmt.setString(3, match.getTeam2());
            stmt.setDate(4, Date.valueOf(match.getDate()));
            stmt.setTime(5, Time.valueOf(match.getTime()));
            stmt.setString(6, match.getVenue());
            stmt.setInt(7, match.getAudience());
            stmt.setString(8, match.getStatus());
            stmt.executeUpdate();
            System.out.println("saveMatch: Saved match ID " + newMatchId);
        } catch (SQLException e) {
            System.err.println("saveMatch: SQL error: " + e.getMessage());
            throw e;
        }
    }

    // Update an existing match
    public void updateMatch(int matchId, MatchModel match) throws SQLException {
        String query = "UPDATE matches SET team1 = ?, team2 = ?, date = ?, time = ?, venue = ?, audience = ?, status = ? WHERE match_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, match.getTeam1());
            stmt.setString(2, match.getTeam2());
            stmt.setDate(3, Date.valueOf(match.getDate()));
            stmt.setTime(4, Time.valueOf(match.getTime()));
            stmt.setString(5, match.getVenue());
            stmt.setInt(6, match.getAudience());
            stmt.setString(7, match.getStatus());
            stmt.setInt(8, matchId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("updateMatch: Updated match ID " + matchId + ", rows affected: " + rowsAffected);
        } catch (SQLException e) {
            System.err.println("updateMatch: SQL error: " + e.getMessage());
            throw e;
        }
    }

    // Delete a match by matchId
    public void deleteMatch(int matchId) throws SQLException {
        String query = "DELETE FROM matches WHERE match_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, matchId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("deleteMatch: Deleted match ID " + matchId + ", rows affected: " + rowsAffected);
        } catch (SQLException e) {
            System.err.println("deleteMatch: SQL error: " + e.getMessage());
            throw e;
        }
    }

    // Helper method to get the next available matchId
    private int getNextMatchId() throws SQLException {
        String query = "SELECT MAX(match_id) AS max_id FROM matches";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                int maxId = rs.getInt("max_id");
                System.out.println("getNextMatchId: Next ID is " + (maxId + 1));
                return maxId + 1;
            }
            System.out.println("getNextMatchId: No matches, starting with ID 1");
            return 1;
        } catch (SQLException e) {
            System.err.println("getNextMatchId: SQL error: " + e.getMessage());
            throw e;
        }
    }
}