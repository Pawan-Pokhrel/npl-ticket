package com.nplticket.util;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

/**
 * Utility class for handling image uploads in the nplticket project.
 */
public class ImageUtil {

    /**
     * Extracts the uploaded image's file name from the HTTP header.
     *
     * @param part the uploaded image part.
     * @return the extracted file name, or null if not found.
     */
    public String getImageNameFromPart(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        System.out.println("Content-Disposition header: " + contentDisposition);
        if (contentDisposition != null) {
            String[] tokens = contentDisposition.split(";");
            for (String token : tokens) {
                if (token.trim().startsWith("filename")) {
                    String fileName = token.substring(token.indexOf("=") + 1).trim().replace("\"", "");
                    System.out.println("Parsed filename: " + fileName);
                    return fileName.isEmpty() ? null : fileName;
                }
            }
        }
        System.out.println("No filename found in content-disposition.");
        return null;
    }

    /**
     * Saves the uploaded image to the specified folder under webapp/images with a given filename.
     *
     * @param filePart       the uploaded image part.
     * @param folderName     the folder where the image should be saved (e.g., "users").
     * @param contextPath    the servlet context path (from getServletContext().getRealPath("")).
     * @param targetFileName the desired filename (e.g., "<userId>.jpg").
     * @return true if upload succeeds, false otherwise.
     */
    public boolean uploadImage(Part filePart, String folderName, String contextPath, String targetFileName) {
        String uploadPath = contextPath + "images" + File.separator + folderName;
        File uploadDir = new File(uploadPath);

        // Debug: Print the upload path
        System.out.println("Attempting to upload to: " + uploadPath);

        if (!uploadDir.exists()) {
            System.out.println("Directory does not exist. Attempting to create...");
            boolean created = uploadDir.mkdirs();
            if (!created) {
                System.out.println("Failed to create directory: " + uploadPath);
                return false;
            }
            System.out.println("Directory created successfully.");
        }

        if (targetFileName == null || targetFileName.isEmpty()) {
            System.out.println("Invalid or empty target filename.");
            return false;
        }
        System.out.println("Target filename: " + targetFileName);

        try {
            File file = new File(uploadPath + File.separator + targetFileName);
            filePart.write(file.getAbsolutePath());
            System.out.println("Image saved to: " + file.getAbsolutePath());
            return true;
        } catch (IOException e) {
            System.out.println("IOException during file upload: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Saves the uploaded image to the specified folder under webapp/images with the original filename.
     *
     * @param filePart    the uploaded image part.
     * @param folderName  the folder where the image should be saved (e.g., "users").
     * @param contextPath the servlet context path (from getServletContext().getRealPath("")).
     * @return true if upload succeeds, false otherwise.
     */
    public boolean uploadImage(Part filePart, String folderName, String contextPath) {
        String fileName = getImageNameFromPart(filePart);
        return uploadImage(filePart, folderName, contextPath, fileName);
    }

    /**
     * Constructs the full save path for a folder under webapp/images.
     *
     * @param folderName  name of the subfolder (e.g., "users").
     * @param contextPath the servlet context path (from getServletContext().getRealPath("")).
     * @return the absolute save path on disk.
     */
    public String getSavePath(String folderName, String contextPath) {
        return contextPath + "images" + File.separator + folderName + File.separator;
    }
}