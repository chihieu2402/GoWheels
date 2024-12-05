package com.poly.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.poly.Service.CarBrandSerivce;
import com.poly.Service.CarService;
import com.poly.Service.FileManagerService;
import com.poly.dao.CarDao;
import com.poly.entity.Car;
import com.poly.entity.CarBrand;
import com.poly.entity.ImageCar;

import jakarta.servlet.ServletContext;

@RequestMapping(value = "/admin")
@PreAuthorize("hasAuthority('ADMIN')")
@Controller
public class CarAdminContronller {

	private final String UPLOAD_DIR = "src/main/resources/static/images/";
	

	@Autowired
	private CarDao carDao;

	@Autowired
	private FileManagerService fileManagerService;

	@Autowired
	private CarBrandSerivce carBrandSerivce;
	@Autowired
	private CarService carservice;

	@Autowired
	ServletContext app;

	@GetMapping("/car")
	public String car(Model model) {
		String path = app.getRealPath("/images/");
		List<Car> cars = carDao.findAll();
		model.addAttribute("cars", cars);
		model.addAttribute("car", new Car());
		model.addAttribute("listCarbrand", carBrandSerivce.findAll());
	//	 model.addAttribute("cars", carservice.getAllCars());
		return "views/admin/Car";
	}

	@GetMapping("/car/edit/{id}")
	public String editCar(@PathVariable int id, Model model) {
		Car car = carDao.findById(id).orElse(new Car());
		List<Car> cars = carDao.findAll();
		List<CarBrand> carBrands = carBrandSerivce.findAll();
		model.addAttribute("car", car);
		model.addAttribute("cars", cars);
		model.addAttribute("listCarbrand", carBrands);
		return "views/admin/Car";
	}

	// hàm add
	@PostMapping("/car/create")
	public String createCar(@ModelAttribute Car car, @RequestParam("carBrandID") int carBrandID,
			@RequestParam("imageFile") MultipartFile imageFile) {
		// CarBrand carBrand = carBrandSerivce.findById(carBrandID).orElse(null);
		// car.setCarBrand(carBrand);
		//handleImageUpload(car, imageFile);
		carDao.save(car);
		return "redirect:/admin/car";
	}

	@PostMapping("/car/update")
	public String updateCar(@ModelAttribute Car car, @RequestParam("carBrandID") int carBrandID,
			@RequestParam("image1") MultipartFile image1, @RequestParam("image2") MultipartFile image2,
			@RequestParam("ownershipDocument1") MultipartFile ownershipDocument1,
			@RequestParam("ownershipDocument2") MultipartFile ownershipDocument2) {

		CarBrand carBrand = carBrandSerivce.findById(carBrandID).orElse(null);
		car.setCarBrand(carBrand);

		handleImageUpload(car, image1, image2, ownershipDocument1, ownershipDocument2);

		// Save the updated car information
		carDao.save(car);

		return "redirect:/admin/car";
	}

	private void handleImageUpload(Car car, MultipartFile image1, MultipartFile image2,
			MultipartFile ownershipDocument1, MultipartFile ownershipDocument2) {
		try {
// Save the uploaded images
			if (!image1.isEmpty()) {
				String imageName1 = saveFile(image1);
				if (car.getImageCar() == null) {
					car.setImageCar(new ImageCar()); // Ensure the imageCar object exists
				}
				car.getImageCar().setImage1(imageName1); // Set image1 for ImageCar
			}
			if (!image2.isEmpty()) {
				String imageName2 = saveFile(image2);
				if (car.getImageCar() == null) {
					car.setImageCar(new ImageCar());
				}
				car.getImageCar().setImage2(imageName2); // Set image2 for ImageCar
			}
			if (!ownershipDocument1.isEmpty()) {
				String docName1 = saveFile(ownershipDocument1);
				if (car.getImageCar() == null) {
					car.setImageCar(new ImageCar());
				}
				car.getImageCar().setImgOwnershipCertificate1(docName1); // Set ownershipCertificate1
			}
			if (!ownershipDocument2.isEmpty()) {
				String docName2 = saveFile(ownershipDocument2);
				if (car.getImageCar() == null) {
					car.setImageCar(new ImageCar());
				}
				car.getImageCar().setImgOwnershipCertificate2(docName2); // Set ownershipCertificate2
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// Save file to the server and return the file name
	private String saveFile(MultipartFile file) throws IOException {
		String fileName = file.getOriginalFilename();
		Path filePath = Paths.get(UPLOAD_DIR, fileName);
		Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
		return fileName;
	}

	// hàm xóa
	@PostMapping("/car/delete")
	public String deleteCar(@RequestParam("carID") int carID) {
		carDao.deleteById(carID);
		return "redirect:/admin/car";
	}

}
