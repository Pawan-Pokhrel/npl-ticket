package com.nplticket.service;

import com.nplticket.config.DbConfig;
import com.nplticket.model.UserModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class RegisterService {

    /**
     * Checks if the email already exists in the user table.
     *
     * @param email the email to check
     * @return true if the email exists, false otherwise
     * @throws SQLException if a database error occurs
     */
    public boolean emailExists(String email) throws SQLException {
        String query = "SELECT id FROM user WHERE email = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    /**
     * Generates the next user ID by finding the maximum ID and incrementing it.
     *
     * @param conn the database connection
     * @return the next available user ID
     * @throws SQLException if a database error occurs
     */
    private long getNextUserId(Connection conn) throws SQLException {
        String query = "SELECT MAX(id) FROM user";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getLong(1) + 1; // Increment max ID
            }
            return 1; // Start at 1 if table is empty
        }
    }

    /**
     * Registers a new user in the database with a generated ID.
     *
     * @param user the UserModel containing user details
     * @return the generated user ID
     * @throws SQLException if a database error occurs
     */
    public long registerUser(UserModel user) throws SQLException {
        String query = "INSERT INTO user (id, fullName, email, password, phoneNumber, address, image, role, isVerified, createdAt, updatedAt) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DbConfig.getDbConnection();
            conn.setAutoCommit(false); // Start transaction

            // Generate unique ID
            long userId = getNextUserId(conn);
            user.setId(userId); // Set ID in UserModel

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setLong(1, userId);
                stmt.setString(2, user.getFullName());
                stmt.setString(3, user.getEmail());
                stmt.setString(4, user.getPassword());
                stmt.setString(5, user.getPhoneNumber());
                stmt.setString(6, user.getAddress());
                stmt.setString(7, "images/users/default-user.jpg"); // Default image
                stmt.setString(8, "customer");
                stmt.setBoolean(9, false);
                stmt.setTimestamp(10, Timestamp.valueOf(LocalDateTime.now()));
                stmt.setTimestamp(11, Timestamp.valueOf(LocalDateTime.now()));
                stmt.executeUpdate();
            }

            conn.commit(); // Commit transaction
            System.out.println("Registered user with ID: " + userId);
            return userId;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback on error
                    System.err.println("Rolled back transaction due to: " + e.getMessage());
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    /**
     * Updates the user's image path in the database.
     *
     * @param userId    the ID of the user
     * @param imagePath the path to the user's image
     * @throws SQLException if a database error occurs
     */
    public void updateUserImage(long userId, String imagePath) throws SQLException {
        String query = "UPDATE user SET image = ?, updatedAt = ? WHERE id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, imagePath);
            stmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setLong(3, userId);
            stmt.executeUpdate();
            System.out.println("Updated image for user ID: " + userId + " to: " + imagePath);
        }
    }
}