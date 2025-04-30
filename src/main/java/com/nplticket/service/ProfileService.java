package com.nplticket.service;

import com.nplticket.config.DbConfig;
import com.nplticket.model.UserModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class ProfileService {

    // Fetch user profile based on user ID
    public UserModel getUserProfile(String username) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM user WHERE SUBSTRING_INDEX(email, '@', 1) = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                UserModel user = new UserModel();
                user.setId((long) rs.getInt("id"));
                user.setFullName(rs.getString("fullName"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setAddress(rs.getString("address"));
                user.setImage(rs.getString("image"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("createdAt") != null ? rs.getTimestamp("createdAt").toLocalDateTime() : null);
                System.out.println(rs.getString("address"));
                return user;
            } else {
                return null; // User not found
            }
        }
    }

    public boolean updateUserProfile(UserModel user) throws SQLException, ClassNotFoundException {
        String query = "UPDATE user SET fullName = ?, email = ?, phoneNumber = ?, address = ?, image = ?, updatedAt = ? WHERE id = ?;";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            System.out.println("Updating user with ID: " + user.getId());
            System.out.println("User data: " + user);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhoneNumber());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getImage());
            stmt.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setLong(7, user.getId());
            int rowsUpdated = stmt.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated);
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            throw e;
        }          
    }

    // Check if email already exists (for profile editing validation)
    public boolean emailExists(String email, String userId) throws SQLException, ClassNotFoundException {
        String query = "SELECT id FROM user WHERE email = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // true if email already exists for another user
        }
    }
}
