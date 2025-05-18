package com.nplticket.service.admin;

import com.nplticket.model.TicketTypeModel;
import com.nplticket.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ManageTicketTypesService {

    // Fetch all ticket types
    public List<TicketTypeModel> getAllTicketTypes() throws SQLException {
        List<TicketTypeModel> ticketTypes = new ArrayList<>();
        String query = "SELECT ticket_type_id, ticket_type, unit_price, ticket_desc FROM ticket_types";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                TicketTypeModel ticket = new TicketTypeModel();
                ticket.setTicketTypeId(rs.getInt("ticket_type_id"));
                ticket.setTicketType(rs.getString("ticket_type"));
                ticket.setUnitPrice(rs.getInt("unit_price"));
                ticket.setTicketDesc(rs.getString("ticket_desc"));
                ticketTypes.add(ticket);
            }
            System.out.println("getAllTicketTypes: Fetched " + ticketTypes.size() + " ticket types");
        } catch (SQLException e) {
            System.err.println("getAllTicketTypes: SQL error: " + e.getMessage());
            throw e;
        }
        return ticketTypes;
    }

    // Add a new ticket type
    public void addTicketType(TicketTypeModel ticket) throws SQLException {
        String query = "INSERT INTO ticket_types (ticket_type, unit_price, ticket_desc) VALUES (?, ?, ?)";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, ticket.getTicketType());
            stmt.setInt(2, ticket.getUnitPrice());
            stmt.setString(3, ticket.getTicketDesc());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    ticket.setTicketTypeId(generatedKeys.getInt(1));
                }
            }
            System.out.println("addTicketType: Added ticket type with ID " + ticket.getTicketTypeId());
        } catch (SQLException e) {
            System.err.println("addTicketType: SQL error: " + e.getMessage());
            throw e;
        }
    }

    // Update an existing ticket type
    public void updateTicketType(TicketTypeModel ticket) throws SQLException {
        String query = "UPDATE ticket_types SET ticket_type = ?, unit_price = ?, ticket_desc = ? WHERE ticket_type_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, ticket.getTicketType());
            stmt.setInt(2, ticket.getUnitPrice());
            stmt.setString(3, ticket.getTicketDesc());
            stmt.setInt(4, ticket.getTicketTypeId());
            int rowsAffected = stmt.executeUpdate();
            System.out.println("updateTicketType: Updated ticket type ID " + ticket.getTicketTypeId() + ", rows affected: " + rowsAffected);
        } catch (SQLException e) {
            System.err.println("updateTicketType: SQL error: " + e.getMessage());
            throw e;
        }
    }

    // Delete a ticket type
    public void deleteTicketType(int ticketTypeId) throws SQLException {
        String query = "DELETE FROM ticket_types WHERE ticket_type_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, ticketTypeId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("deleteTicketType: Deleted ticket type ID " + ticketTypeId + ", rows affected: " + rowsAffected);
        } catch (SQLException e) {
            System.err.println("deleteTicketType: SQL error: " + e.getMessage());
            throw e;
        }
    }
}