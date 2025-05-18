package com.nplticket.service;

import com.nplticket.config.DbConfig;
import com.nplticket.model.BookingModel;

import java.sql.*;
import java.time.LocalDateTime;

public class PaymentService {

    private BookingService bookingService;

    public PaymentService() {
        this.bookingService = new BookingService();
    }

    public int processPayment(int bookingId, long userId, double amount, String paymentMethod, String identifier, String bankName) throws SQLException {
        Connection conn = null;
        int paymentId = -1;
        int maxRetries = 3;
        int retryCount = 0;

        // Pre-check foreign key constraints
        if (!checkBookingExists(bookingId)) {
            throw new SQLException("Booking ID " + bookingId + " does not exist in the bookings table.");
        }
        if (!checkUserExists(userId)) {
            throw new SQLException("User ID " + userId + " does not exist in the user table.");
        }

        // Determine organization name based on payment method
        String organizationName;
        switch (paymentMethod) {
            case "Debit Card":
                organizationName = "VISA";
                break;
            case "Bank Transfer":
                organizationName = bankName != null && !bankName.isEmpty() ? bankName : "Unknown Bank";
                break;
            case "FonePay":
                organizationName = "FonePay";
                break;
            case "Esewa":
                organizationName = "Esewa";
                break;
            case "Khalti":
                organizationName = "Khalti";
                break;
            case "ImePay":
                organizationName = "IME";
                break;
            default:
                organizationName = "Unknown";
        }
        System.out.println("Setting organizationName to: " + organizationName);

        while (retryCount < maxRetries) {
            try {
                conn = DbConfig.getDbConnection();
                if (conn == null) {
                    throw new SQLException("Failed to establish database connection.");
                }
                conn.setAutoCommit(false);

                // Insert payment record
                String paymentQuery = "INSERT INTO payments (booking_id, user_id, amount, payment_method, payment_status, payment_date, transaction_id, organization_name) " +
                                     "VALUES (?, ?, ?, ?, 'Completed', ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(paymentQuery, Statement.RETURN_GENERATED_KEYS)) {
                    stmt.setInt(1, bookingId);
                    stmt.setLong(2, userId);
                    stmt.setDouble(3, amount);
                    stmt.setString(4, paymentMethod);
                    stmt.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
                    System.out.println("Identifier = " + identifier);
                    stmt.setString(6, identifier != null && !identifier.isEmpty() ? identifier : "N/A");
                    stmt.setString(7, organizationName);
                    int rowsAffected = stmt.executeUpdate();
                    System.out.println("processPayment: Inserted payment for booking ID " + bookingId + ", rows affected: " + rowsAffected);

                    // Retrieve the generated payment_id
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            paymentId = generatedKeys.getInt(1);
                            System.out.println("processPayment: Generated payment_id: " + paymentId);
                        } else {
                            throw new SQLException("Failed to retrieve payment_id, no ID obtained.");
                        }
                    }
                }

                // Update booking status to Confirmed using the same connection
                bookingService.confirmBooking(bookingId, conn);
                if (bookingService.getLastRowsAffected() == 0) {
                    throw new SQLException("Failed to confirm booking ID " + bookingId + ", no rows updated.");
                }

                conn.commit();
                System.out.println("processPayment: Transaction committed successfully for payment_id: " + paymentId);
                return paymentId;
            } catch (SQLException e) {
                if (conn != null) {
                    try {
                        conn.rollback();
                        System.err.println("processPayment: Rolled back transaction due to: " + e.getMessage());
                    } catch (SQLException rollbackEx) {
                        System.err.println("processPayment: Rollback error: " + rollbackEx.getMessage());
                    }
                }
                if (e.getMessage().contains("Lock wait timeout exceeded") && retryCount < maxRetries - 1) {
                    retryCount++;
                    System.out.println("Lock wait timeout detected, retrying (" + retryCount + "/" + maxRetries + ")...");
                    try {
                        Thread.sleep(2000);
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                    }
                    continue;
                } else if (e.getMessage().contains("foreign key constraint fails")) {
                    throw new SQLException("Foreign key constraint violation: Check booking_id or user_id exists in their respective tables.", e);
                }
                System.err.println("processPayment: SQL error: " + e.getMessage());
                e.printStackTrace();
                throw e;
            } finally {
                if (conn != null) {
                    try {
                        conn.setAutoCommit(true);
                        conn.close();
                    } catch (SQLException closeEx) {
                        System.err.println("processPayment: Connection close error: " + closeEx.getMessage());
                    }
                }
            }
        }
        throw new SQLException("Failed to process payment after " + maxRetries + " retries due to lock wait timeout.");
    }

    private boolean checkBookingExists(int bookingId) throws SQLException {
        String query = "SELECT 1 FROM bookings WHERE booking_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                boolean exists = rs.next();
                System.out.println("checkBookingExists: Booking ID " + bookingId + " exists: " + exists);
                return exists;
            }
        }
    }

    private boolean checkUserExists(long userId) throws SQLException {
        String query = "SELECT 1 FROM user WHERE id = ?"; // Corrected to 'user' table
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setLong(1, userId);
            System.out.println("checkUserExists: Checking user ID " + userId);
            try (ResultSet rs = stmt.executeQuery()) {
                boolean exists = rs.next();
                System.out.println("checkUserExists: User ID " + userId + " exists: " + exists);
                return exists;
            }
        }
    }

    public BookingModel getBookingById(int bookingId) throws SQLException {
        String query = "SELECT b.booking_id, b.user_id, b.match_no, b.ticket_quantity, b.booking_status, " +
                      "m.team1, m.team2, m.date, m.venue " +
                      "FROM bookings b " +
                      "JOIN matches m ON b.match_no = m.match_id " +
                      "WHERE b.booking_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    BookingModel booking = new BookingModel();
                    booking.setBookingId(rs.getInt("booking_id"));
                    booking.setUserId(rs.getLong("user_id"));
                    booking.setMatchId(rs.getInt("match_no"));
                    booking.setTeam1(rs.getString("team1"));
                    booking.setTeam2(rs.getString("team2"));
                    booking.setDate(rs.getDate("date").toLocalDate());
                    booking.setVenue(rs.getString("venue"));
                    booking.setTickets(rs.getInt("ticket_quantity"));
                    booking.setStatus(rs.getString("booking_status"));
                    return booking;
                }
            }
        } catch (SQLException e) {
            System.err.println("getBookingById: SQL error: " + e.getMessage());
            throw e;
        }
        return null;
    }
}