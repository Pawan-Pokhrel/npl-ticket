package com.nplticket.service;

import com.nplticket.config.DbConfig;
import com.nplticket.model.UserModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class RegisterService {

    public boolean emailExists(String email) throws Exception {
        String query = "SELECT id FROM user WHERE email = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // true if email already exists
        }
    }

    public void registerUser(UserModel user) throws Exception {
        String query = "INSERT INTO user (fullName, email, password, phoneNumber, address, image, role, isVerified, createdAt, updatedAt"
        		+ ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getDbConnection();
            PreparedStatement stmt = conn.prepareStatement(query)) {
        	stmt.setString(1, user.getFullName());
        	stmt.setString(2, user.getEmail());
        	stmt.setString(3, user.getPassword());
        	stmt.setString(4, user.getPhoneNumber());
        	stmt.setString(5, user.getAddress());
        	stmt.setString(6, "");
        	stmt.setString(7, "customer");
        	stmt.setBoolean(8, false);
        	stmt.setTimestamp(9, Timestamp.valueOf(LocalDateTime.now()));
        	stmt.setTimestamp(10, Timestamp.valueOf(LocalDateTime.now()));
            stmt.executeUpdate();
        }
    }
}
