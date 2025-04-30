package com.nplticket.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.nplticket.config.DbConfig;
import com.nplticket.model.UserModel;

/**
 * Service class for handling login operations for the NPL Ticket Reservation System.
 */
public class LogInService {

    private Connection dbConn;
    private boolean isConnectionError = false;

    /**
     * Constructor initializes the database connection. Sets the connection error flag if the connection fails.
     */
    public LogInService() {
        try {
            dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            isConnectionError = true;
        }
    }

    /**
     * Retrieves the user by email.
     *
     * @param email the email of the user to retrieve
     * @return UserModel object if the user is found, null if not
     */
    public UserModel getUserByEmail(String email) {
        if (isConnectionError) {
            System.out.println("Connection Error!");
            return null;
        }

        String query = "SELECT * FROM user WHERE email = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                return mapUser(result);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Maps the ResultSet to a UserModel object.
     *
     * @param result the ResultSet containing user data
     * @return UserModel object with user details
     * @throws SQLException if a database access error occurs
     */
    private UserModel mapUser(ResultSet result) throws SQLException {
        UserModel user = new UserModel();
        user.setId(result.getLong("id"));
        user.setFullName(result.getString("fullName"));
        user.setEmail(result.getString("email"));
        user.setPassword(result.getString("password"));
        user.setPhoneNumber(result.getString("phoneNumber"));
        user.setAddress(result.getString("address"));
        user.setImage(result.getString("image"));
        user.setRole(result.getString("role"));
        user.setVerified(result.getBoolean("isVerified"));
        user.setCreatedAt(result.getTimestamp("createdAt").toLocalDateTime());
        user.setUpdatedAt(result.getTimestamp("updatedAt").toLocalDateTime());
        return user;
    }
}
