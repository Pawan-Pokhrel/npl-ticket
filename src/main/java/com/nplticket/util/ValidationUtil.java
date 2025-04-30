package com.nplticket.util;

import java.time.LocalDate;
import java.time.Period;
import java.util.regex.Pattern;
import jakarta.servlet.http.Part;

public class ValidationUtil {

    // 1. Validate if a field is null or empty
    public static boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    // 2. Validate if a string contains only letters (for user names or full names)
    public static boolean isAlphabetic(String value) {
        return value != null && value.matches("^[a-zA-Z\\s]+$");  // Allow spaces between words
    }

    // 3. Validate if a string starts with a letter and is alphanumeric (for usernames or IDs)
    public static boolean isAlphanumericStartingWithLetter(String value) {
        return value != null && value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
    }

    // 4. Validate if a string is "male" or "female" (gender validation)
    public static boolean isValidGender(String value) {
        return value != null && (value.equalsIgnoreCase("male") || value.equalsIgnoreCase("female"));
    }

    // 5. Validate if a string is a valid email address (for registration)
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }

    // 6. Validate if a phone number is valid for Nepal (10 digits starting with 98)
    public static boolean isValidPhoneNumber(String number) {
        return number != null && number.matches("^98\\d{8}$");
    }

    // 7. Validate if a password is strong (at least 1 capital letter, 1 number, and 1 symbol)
    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(passwordRegex);
    }

    // 8. Validate if an image file is in a valid format (jpg, jpeg, png, gif)
    public static boolean isValidImageExtension(Part imagePart) {
        if (imagePart == null || isNullOrEmpty(imagePart.getSubmittedFileName())) {
            return false;
        }
        String fileName = imagePart.getSubmittedFileName().toLowerCase();
        return fileName.endsWith(".jpg") || fileName.endsWith(".jpeg") || fileName.endsWith(".png") || fileName.endsWith(".gif");
    }

    // 9. Validate if password and retype password match
    public static boolean doPasswordsMatch(String password, String retypePassword) {
        return password != null && password.equals(retypePassword);
    }

    // 10. Validate if the date of birth is at least 16 years before today (for age restriction)
    public static boolean isAgeAtLeast16(LocalDate dob) {
        if (dob == null) {
            return false;
        }
        LocalDate today = LocalDate.now();
        return Period.between(dob, today).getYears() >= 16;
    }

    // 11. Validate if the ticket ID follows the format (e.g., TICKET-XXXX-YYYY)
    public static boolean isValidTicketID(String ticketId) {
        return ticketId != null && ticketId.matches("^TICKET-\\d{4}-\\d{4}$");
    }

    // 12. Validate if the seat number is within a valid range (e.g., 1 to 1000 for the number of seats)
    public static boolean isValidSeatNumber(int seatNumber) {
        return seatNumber > 0 && seatNumber <= 1000;  // Adjust the seat number range as per your system
    }

    // 13. Validate if a booking date is valid (not in the past)
    public static boolean isValidBookingDate(LocalDate bookingDate) {
        if (bookingDate == null) {
            return false;
        }
        return !bookingDate.isBefore(LocalDate.now());  // Ensure booking date is today or in the future
    }

    // 14. Validate if a ticket quantity is within a reasonable limit (e.g., max 5 tickets per user)
    public static boolean isValidTicketQuantity(int quantity) {
        return quantity > 0 && quantity <= 5;  // Adjust the limit based on your requirements
    }
}
