package com.poly.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

public class MultipartFileConverter {

    private static final String UPLOAD_DIR = "src/main/resources/static/images/carPost/";

    public List<String> convertToPaths(List<MultipartFile> multipartFiles) throws IOException {
        List<String> filePaths = new ArrayList<>();
        for (MultipartFile file : multipartFiles) {
            if (!file.isEmpty()) {
                String fileName = file.getOriginalFilename();
                String uniqueId = Long.toString(System.currentTimeMillis()); // Generate a unique ID
                String targetPath = UPLOAD_DIR + uniqueId + "_" + fileName;
                Files.copy(file.getInputStream(), Paths.get(targetPath), StandardCopyOption.REPLACE_EXISTING);
                filePaths.add("/images/carPost/" + uniqueId + "_" + fileName);
            }
        }
        return filePaths;
    }
}
