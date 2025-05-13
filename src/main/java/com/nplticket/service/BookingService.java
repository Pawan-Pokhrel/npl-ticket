package com.nplticket.service;

import com.nplticket.config.DbConfig;
import com.nplticket.model.BookingModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingService {

    public List<BookingModel> getUserBookings(long userId) throws SQLException {
        List<BookingModel> bookings = new ArrayList<>();
        String query = "SELECT b.booking_id, b.user_id, b.match_no, b.ticket_quantity, b.booking_status, " +
                      "m.team1, m.team2, m.date, m.venue " +
                      "FROM bookings b " +
                      "JOIN matches m ON b.match_no = m.match_id " +
                      "WHERE b.user_id = ? " +
                      "ORDER BY m.date DESC";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setLong(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
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
                    bookings.add(booking);
                }
            }
            System.out.println("getUserBookings: Fetched " + bookings.size() + " bookings for user ID " + userId);
        } catch (SQLException e) {
            System.err.println("getUserBookings: SQL error: " + e.getMessage());
            throw e;
        }

        return bookings;
    }

    public void confirmBooking(int bookingId) throws SQLException {
        String query = "UPDATE bookings SET status = 'Confirmed' WHERE booking_id = ? AND status = 'Pending'";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("confirmBooking: Confirmed booking ID " + bookingId + ", rows affected: " + rowsAffected);
            if (rowsAffected == 0) {
                System.out.println("confirmBooking: No booking updated. Either booking ID " + bookingId + " doesn't exist or status is not Pending.");
            }
        } catch (SQLException e) {
            System.err.println("confirmBooking: SQL error: " + e.getMessage());
            throw e;
        }
    }

    public void deleteBooking(int bookingId) throws SQLException {
        String query = "DELETE FROM bookings WHERE booking_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("deleteBooking: Deleted booking ID " + bookingId + ", rows affected: " + rowsAffected);
            if (rowsAffected == 0) {
                System.out.println("deleteBooking: No booking deleted. Booking ID " + bookingId + " may not exist.");
            }
        } catch (SQLException e) {
            System.err.println("deleteBooking: SQL error: " + e.getMessage());
            throw e;
        }
    }
}