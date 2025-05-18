package com.nplticket.service.admin;

import com.nplticket.config.DbConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDashboardService {

    public int getTotalMatches() {
        String query = "SELECT COUNT(*) FROM matches";
        return executeCountQuery(query);
    }

    public int getTotalTicketsSold() {
        String query = "SELECT SUM(ticket_quantity) FROM bookings WHERE booking_status = 'Confirmed'";
        return executeCountQuery(query);
    }

    public int getTotalUsers() {
        String query = "SELECT COUNT(*) FROM user"; 
        return executeCountQuery(query);
    }

    public double getTotalRevenue() {
        String query = "SELECT SUM(amount) FROM payments WHERE payment_status = 'Completed'";
        return executeDoubleQuery(query);
    }

    public int getTotalBookings() {
        String query = "SELECT COUNT(*) FROM bookings";
        return executeCountQuery(query);
    }

    public int getPendingPayments() {
        String query = "SELECT COUNT(*) FROM payments WHERE payment_status = 'Pending'";
        return executeCountQuery(query);
    }


    private int executeCountQuery(String query) {
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private double executeDoubleQuery(String query) {
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
}