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
    private static final String DB_NAME = "NPL_Ticket"; // Replace with your actual DB name
    private static final String URL = "jdbc:mysql://localhost:3306/" + DB_NAME;
    private static final String USERNAME = "root"; // Replace with your actual DB username
    private static final String PASSWORD = ""; // Replace with your actual DB password

    /**
     * Establishes a connection to the database.
     *
     * @return Connection object for the database
     * @throws SQLException           if a database access error occurs
     * @throws ClassNotFoundException if the JDBC driver class is not found
     */
    public static Connection getDbConnection() throws SQLException, ClassNotFoundException {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Return a new connection to the database
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
