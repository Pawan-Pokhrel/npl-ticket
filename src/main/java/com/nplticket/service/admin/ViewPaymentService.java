package com.nplticket.service.admin;

import com.nplticket.config.DbConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ViewPaymentService {

    public static class Payment {
        private int paymentId;
        private String matchDetails; // Team1 vs Team2
        private String userFullName; // User's full name
        private double amount;
        private String paymentStatus;
        private String paymentDate;

        public Payment(int paymentId, String matchDetails, String userFullName, double amount, String paymentStatus, String paymentDate) {
            this.paymentId = paymentId;
            this.matchDetails = matchDetails != null ? matchDetails : "N/A";
            this.userFullName = userFullName != null ? userFullName : "N/A";
            this.amount = amount;
            this.paymentStatus = paymentStatus;
            this.paymentDate = paymentDate;
        }

        // Getters
        public int getPaymentId() { return paymentId; }
        public String getMatchDetails() { return matchDetails; }
        public String getUserFullName() { return userFullName; }
        public double getAmount() { return amount; }
        public String getPaymentStatus() { return paymentStatus; }
        public String getPaymentDate() { return paymentDate; }
    }

    public List<Payment> getPayments(int page, int rowsPerPage, String search) {
        List<Payment> payments = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT p.payment_id, p.amount, p.payment_status, p.payment_date, " +
            "CONCAT(m.team1, ' vs ', m.team2) AS match_details, " +
            "u.fullName " +
            "FROM payments p " +
            "LEFT JOIN bookings b ON p.booking_id = b.booking_id " +
            "LEFT JOIN matches m ON b.match_no = m.match_id " +
            "LEFT JOIN user u ON p.user_id = u.id"
        );
        if (search != null && !search.trim().isEmpty()) {
            query.append(" WHERE p.payment_id LIKE ? OR p.payment_status LIKE ?");
        }
        query.append(" LIMIT ? OFFSET ?");

        int offset = (page - 1) * rowsPerPage;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                stmt.setString(paramIndex++, searchPattern);
                stmt.setString(paramIndex++, searchPattern);
            }
            stmt.setInt(paramIndex++, rowsPerPage);
            stmt.setInt(paramIndex, offset);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                payments.add(new Payment(
                    rs.getInt("payment_id"),
                    rs.getString("match_details"),
                    rs.getString("fullName"),
                    rs.getDouble("amount"),
                    rs.getString("payment_status"),
                    rs.getString("payment_date")
                ));
            }
            System.out.println("Fetched " + payments.size() + " payments for page " + page + " with rowsPerPage " + rowsPerPage);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }

    public int getTotalPayments(String search) {
        String query = "SELECT COUNT(*) FROM payments p";
        if (search != null && !search.trim().isEmpty()) {
            query += " WHERE p.payment_id LIKE ? OR p.payment_status LIKE ?";
        }

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                stmt.setString(1, searchPattern);
                stmt.setString(2, searchPattern);
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int total = rs.getInt(1);
                System.out.println("Total payments count: " + total);
                return total;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}