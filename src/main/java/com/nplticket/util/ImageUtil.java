package com.nplticket.util;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.http.Part;

/**
 * Utility class for handling image uploads in the nplticket project.
 */
public class ImageUtil {

    /**
     * Extracts the uploaded image's file name from the HTTP header.
     *
     * @param part the uploaded image part.
     * @return the extracted file name, or "default.png" if not found.
     */
    public String getImageNameFromPart(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String item : contentDisp.split(";")) {
            if (item.trim().startsWith("filename")) {
                String fileName = item.substring(item.indexOf('=') + 2, item.length() - 1);
                return fileName.isEmpty() ? "default.png" : fileName;
            }
        }
        return "default.png";
    }

    /**
     * Saves the uploaded image to the specified folder under resources/images.
     *
     * @param part       the uploaded image part.
     * @param folderName the folder where the image should be saved (e.g., "teams").
     * @return true if upload succeeds, false otherwise.
     */
    public boolean uploadImage(Part part, String folderName) {
        String savePath = getSavePath(folderName);
        File saveDir = new File(savePath);

        if (!saveDir.exists() && !saveDir.mkdirs()) {
            return false;
        }

        try {
            String fileName = getImageNameFromPart(part);
            part.write(savePath + File.separator + fileName);
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Constructs the full save path for a folder under resources/images.
     *
     * @param folderName name of the subfolder.
     * @return the absolute save path on disk.
     */
    public String getSavePath(String folderName) {
        return "C:/Users/Prithivi/eclipse-workspace/nplticket/src/main/webapp/resources/images/" + folderName + "/";
    }
}
