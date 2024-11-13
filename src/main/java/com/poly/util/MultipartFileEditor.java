package com.poly.util;
import org.springframework.web.multipart.MultipartFile;

import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

public class MultipartFileEditor extends PropertyEditorSupport {

    private static final String UPLOAD_DIR = "src/main/resources/static/images/carPost/";

    @Override
    public void setValue(Object value) {
        List<MultipartFile> multipartFiles = (List<MultipartFile>) value;
        List<String> filePaths = new ArrayList<>();
        for (MultipartFile file : multipartFiles) {
            if (!file.isEmpty()) {
                try {
                    String fileName = file.getOriginalFilename();
                    String uniqueId = Long.toString(System.currentTimeMillis()); // Generate a unique ID
                    String targetPath = UPLOAD_DIR + uniqueId + "_" + fileName;
                    Files.copy(file.getInputStream(), Paths.get(targetPath), StandardCopyOption.REPLACE_EXISTING);
                    filePaths.add("/images/carPost/" + uniqueId + "_" + fileName);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        super.setValue(filePaths);
    }

    @Override
    public String getAsText() {
        return super.getValue().toString();
    }
}
