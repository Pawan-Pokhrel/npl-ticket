package com.nplticket.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DbConfig is a configuration class for managing database connections for
 * the NPL Ticket Reservation System. It handles the connection to the MySQL
 * database using JDBC.
 */
public class DbConfig {

    // Database configuration information
    private static final String DB_NAME = "npl_ticket";
    private static final String URL = "jdbc:mysql://localhost:3306/" + DB_NAME + "?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root"; // Replace with your actual DB username
    private static final String PASSWORD = ""; // Replace with your actual DB password

    /**
     * Establishes a connection to the database.
     *
     * @return Connection object for the database
     * @throws SQLException if a database access error occurs
     */
    public static Connection getDbConnection() throws SQLException {
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("DbConfig: Database connection established");
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("DbConfig: MySQL JDBC driver not found: " + e.getMessage());
            throw new SQLException("JDBC driver not found", e);
        } catch (SQLException e) {
            System.err.println("DbConfig: Failed to connect to database: " + e.getMessage());
            throw e;
        }
    }
}