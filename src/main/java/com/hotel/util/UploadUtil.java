package com.hotel.util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

public class UploadUtil {

    public static String saveFile(Part part, String uploadDir) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }

        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String fileExtension = "";
        int dotIndex = submittedFileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileExtension = submittedFileName.substring(dotIndex);
        }

        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
        String filePath = uploadDir + File.separator + uniqueFileName;
        
        part.write(filePath);
        
        return uniqueFileName;
    }
}
