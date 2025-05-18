package com.nplticket.service.admin;

import com.nplticket.config.DbConfig;
import com.nplticket.model.TicketModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ManageTicketService {

    // Fetch all tickets (no pagination or search on server side, handled client-side)
	// Fetch all tickets with search filtering
	public List<TicketModel> getAllTickets(String searchTerm) throws SQLException {
	    List<TicketModel> tickets = new ArrayList<>();
	    String query = "SELECT t.ticket_id, t.customer, u.fullName, t.match_no, m.team1, m.team2, t.date, t.seat_no, t.status " +
	                  "FROM tickets t " +
	                  "JOIN user u ON t.customer = u.id " +
	                  "JOIN matches m ON t.match_no = m.match_id " +
	                  "WHERE t.ticket_id LIKE ? OR u.fullName LIKE ? OR m.team1 LIKE ? OR m.team2 LIKE ? OR t.date LIKE ? OR t.seat_no LIKE ? OR t.status LIKE ? " +
	                  "ORDER BY t.date";

	    try (Connection conn = DbConfig.getDbConnection();
	         PreparedStatement stmt = conn.prepareStatement(query)) {
	        String searchPattern = "%" + searchTerm + "%";
	        stmt.setString(1, searchPattern); // ticket_id
	        stmt.setString(2, searchPattern); // fullName
	        stmt.setString(3, searchPattern); // team1
	        stmt.setString(4, searchPattern); // team2
	        stmt.setString(5, searchPattern); // date
	        stmt.setString(6, searchPattern); // seat_no
	        stmt.setString(7, searchPattern); // status

	        try (ResultSet rs = stmt.executeQuery()) {
	            while (rs.next()) {
	                TicketModel ticket = new TicketModel();
	                ticket.setId(rs.getString("ticket_id"));
	                ticket.setUserId(rs.getLong("customer"));
	                ticket.setMatchId(rs.getLong("match_no"));
	                String team1 = rs.getString("team1");
	                String team2 = rs.getString("team2");
	                ticket.setMatchName(team1 + " vs " + team2);
	                ticket.setDate(rs.getString("date"));
	                ticket.setSeat(rs.getString("seat_no"));
	                ticket.setStatus(rs.getString("status"));
	                ticket.setFullName(rs.getString("fullName"));
	                tickets.add(ticket);
	            }
	            System.out.println("getAllTickets: Fetched " + tickets.size() + " tickets with search term: " + searchTerm);
	        }
	    } catch (SQLException e) {
	        System.err.println("getAllTickets: SQL error: " + e.getMessage());
	        throw e;
	    }
	    return tickets;
	}

    // Check if a ticket exists based on ticketId
    public boolean ticketExists(String ticketId) throws SQLException {
        String query = "SELECT ticket_id FROM tickets WHERE ticket_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, ticketId);
            ResultSet rs = stmt.executeQuery();
            boolean exists = rs.next();
            System.out.println("ticketExists: Ticket ID " + ticketId + " exists: " + exists);
            return exists;
        } catch (SQLException e) {
            System.err.println("ticketExists: SQL error: " + e.getMessage());
            throw e;
        }
    }

    // Update an existing ticket (only status)
    public void updateTicket(String ticketId, TicketModel ticket) throws SQLException {
        String query = "UPDATE tickets SET status = ? WHERE ticket_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, ticket.getStatus());
            stmt.setString(2, ticketId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("updateTicket: Updated ticket ID " + ticketId + ", rows affected: " + rowsAffected);
        } catch (SQLException e) {
            System.err.println("updateTicket: SQL error: " + e.getMessage());
            throw e;
        }
    }

    // Delete a ticket by ticketId
    public void deleteTicket(String ticketId) throws SQLException {
        String query = "DELETE FROM tickets WHERE ticket_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, ticketId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("deleteTicket: Deleted ticket ID " + ticketId + ", rows affected: " + rowsAffected);
        } catch (SQLException e) {
            System.err.println("deleteTicket: SQL error: " + e.getMessage());
            throw e;
        }
    }
}