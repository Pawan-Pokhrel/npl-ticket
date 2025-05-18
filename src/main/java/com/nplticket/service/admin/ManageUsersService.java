package com.nplticket.service.admin;

import com.nplticket.model.UserModel;
import com.nplticket.config.DbConfig;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ManageUsersService {

    // Fetch all users with search filtering
    public List<UserModel> getAllUsers(String searchTerm) throws SQLException {
        List<UserModel> users = new ArrayList<>();
        String query = "SELECT id, fullName, email, phoneNumber, address, image, role, isVerified, createdAt, updatedAt " +
                       "FROM user WHERE fullName LIKE ? OR email LIKE ? OR phoneNumber LIKE ? OR address LIKE ? " +
                       "OR role LIKE ? ORDER BY createdAt DESC";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setString(5, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    UserModel user = new UserModel();
                    user.setId(rs.getLong("id"));
                    user.setFullName(rs.getString("fullName"));
                    user.setEmail(rs.getString("email"));
                    user.setPhoneNumber(rs.getString("phoneNumber"));
                    user.setAddress(rs.getString("address"));
                    user.setImage(rs.getString("image"));
                    user.setRole(rs.getString("role"));
                    user.setVerified(rs.getBoolean("isVerified"));
                    user.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());
                    user.setUpdatedAt(rs.getTimestamp("updatedAt") != null ? rs.getTimestamp("updatedAt").toLocalDateTime() : null);
                    users.add(user);
                }
                System.out.println("getAllUsers: Fetched " + users.size() + " users with search term: " + searchTerm);
            }
        } catch (SQLException e) {
            System.err.println("getAllUsers: SQL error: " + e.getMessage());
            throw e;
        }
        return users;
    }

    // Update user role
    public void updateUserRole(Long userId, String role) throws SQLException {
        String query = "UPDATE user SET role = ? WHERE id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, role);
            stmt.setLong(2, userId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("updateUserRole: Updated role for user ID " + userId + ", rows affected: " + rowsAffected);
        } catch (SQLException e) {
            System.err.println("updateUserRole: SQL error: " + e.getMessage());
            throw e;
        }
    }
}