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
import com.poly.Service.FileManagerService;
import com.poly.dao.CarDao;
import com.poly.entity.Car;
import com.poly.entity.CarBrand;

import jakarta.servlet.ServletContext;

@RequestMapping(value = "/admin")
@PreAuthorize("hasAuthority('ADMIN')")
@Controller
public class CarContronller {

	private final String UPLOAD_DIR = "src/main/resources/static/images/";

	@Autowired
	private CarDao carDao;

	@Autowired
	private FileManagerService fileManagerService;

	@Autowired
	private CarBrandSerivce carBrandSerivce;

	@Autowired
	ServletContext app;

	@GetMapping("/car")
	public String car(Model model) {
		String path = app.getRealPath("/images/");
		List<Car> cars = carDao.findAll();
		model.addAttribute("cars", cars);
		model.addAttribute("car", new Car());
		model.addAttribute("listCarbrand", carBrandSerivce.findAll());
		return "views/admin/Car";
	}

	@GetMapping("/car/edit/{id}")
	public String editCar(@PathVariable int id, Model model) {
		Car car = carDao.findById(id).orElse(null);
		List<Car> cars = carDao.findAll();
		model.addAttribute("listCarbrand", carBrandSerivce.findAll());
		model.addAttribute("cars", cars);

		if (car != null) {
			model.addAttribute("selectedCarBrand", car.getCarBrand().getCarBrandID());
		}
		model.addAttribute("car", car);
		return "views/admin/Car";
	}

	// hàm add
	@PostMapping("/car/create")
	public String createCar(@ModelAttribute Car car, @RequestParam("carBrandID") int carBrandID,
			@RequestParam("imageFile") MultipartFile imageFile) {
		//CarBrand carBrand = carBrandSerivce.findById(carBrandID).orElse(null);
		//car.setCarBrand(carBrand);
		handleImageUpload(car, imageFile);
		carDao.save(car);
		return "redirect:/admin/car";
	}

	// hàm update
	@PostMapping("/car/update")
	public String updateCar(@ModelAttribute Car car, @RequestParam("carBrandID") int carBrandID,
			@RequestParam("imageFile") MultipartFile imageFile) {
		CarBrand carBrand = carBrandSerivce.findById(carBrandID).orElse(null);
		car.setCarBrand(carBrand);
		if (!imageFile.isEmpty()) {
			handleImageUpload(car, imageFile);
		} else {

			Car existingCar = carDao.findById(car.getCarID()).orElse(null);
			if (existingCar != null) {
//				car.setImage(existingCar.getImage());
			}
		}
		carDao.save(car);
		return "redirect:/admin/car";
		
	}

	// hàm xóa
//	@PostMapping("/car/delete")
//	public String deleteCar(@RequestParam("carID") int carID) {
//		carDao.deleteById(carID);
//		return "redirect:/admin/car";
//	}
//			Car existingCar = carDao.findById(car.getCarID()).orElse(null);
//			if (existingCar != null) {
//				car.setImage(existingCar.getImage());
//			}
//		}
//		carDao.save(car);
//		return "redirect:/admin/car";
//	}

//	// hàm xóa
	@PostMapping("/car/delete")
	public String deleteCar(@RequestParam("carID") int carID) {
		carDao.deleteById(carID);
		return "redirect:/admin/car";
	}


	private void handleImageUpload(Car car, MultipartFile imageFile) {
		if (!imageFile.isEmpty()) {
			try {
				String fileName = imageFile.getOriginalFilename();
				Path uploadPath = Paths.get(UPLOAD_DIR + fileName);
				Files.copy(imageFile.getInputStream(), uploadPath, StandardCopyOption.REPLACE_EXISTING);
				List<String> imageList = new ArrayList<>();
				imageList.add("/images/" + fileName);
//				car.setImage(imageList);

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}


}

