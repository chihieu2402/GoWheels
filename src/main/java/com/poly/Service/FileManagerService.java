package com.poly.Service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.criteria.Path;
import jakarta.servlet.ServletContext;


@Service
public class FileManagerService {

	@Service
	public class UploadService {
		@Autowired
		ServletContext app;
		
		public File save(MultipartFile file,String folder) {
			File dir = new File(app.getRealPath(folder));
			if (!dir.exists())  dir.mkdir();
			try {
				File saveFile = new File(dir,file.getOriginalFilename());
				file.transferTo(saveFile);
				return saveFile;
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}

}
	

	public void delete(String string, String image) {
		// TODO Auto-generated method stub
		
	}

	public String save(MultipartFile file, String string) {
		// TODO Auto-generated method stub
		return null;
	}

	public String saveFile(MultipartFile imageFile) {
		// TODO Auto-generated method stub
		return null;
	}
}