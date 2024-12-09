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
	public String updateCar(
	        @ModelAttribute Car car, 
	        @RequestParam("carBrandID") int carBrandID, 
	        @RequestParam("imageFile") MultipartFile imageFile, 
	        Model model) {

	    try {
	        // Lấy thông tin xe hiện tại từ cơ sở dữ liệu
	        Car existingCar = carDao.findById(car.getCarID()).orElse(null);
	        if (existingCar == null) {
	            model.addAttribute("message", "Car not found!");
	            return "redirect:/admin/car";
	        }

	        // Gán thông tin carBrand vào đối tượng car
	        CarBrand carBrand = carBrandSerivce.findById(carBrandID).orElse(null);
	        car.setCarBrand(carBrand);
	        if (!imageFile.isEmpty()) {
	            // Xóa ảnh cũ nếu có
	            String oldImage = existingCar.getImageCar() != null ? existingCar.getImageCar().getImage1() : null;
	            if (oldImage != null) {
	                Path oldImagePath = Paths.get(UPLOAD_DIR + oldImage);
	                Files.deleteIfExists(oldImagePath);
	            }

	            // Lưu ảnh mới
	            String newImageName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
	            Path newImagePath = Paths.get(UPLOAD_DIR + newImageName);
	            Files.copy(imageFile.getInputStream(), newImagePath, StandardCopyOption.REPLACE_EXISTING);

	            // Cập nhật thông tin ảnh
	            ImageCar imageCar = existingCar.getImageCar() != null ? existingCar.getImageCar() : new ImageCar();
	            imageCar.setImage1(newImageName);
	            existingCar.setImageCar(imageCar);
	        }

	        // Cập nhật thông tin xe
	        existingCar.setCarName(car.getCarName());
	        existingCar.setColor(car.getColor());
	        existingCar.setPriceHoursCar(car.getPriceHoursCar());
	        existingCar.setAddress(car.getAddress());
	        existingCar.setStatus(car.isStatus());
	        existingCar.setCarBrand(car.getCarBrand());

	        // Lưu thông tin cập nhật
	        carDao.save(existingCar);
	        model.addAttribute("message", "Car updated successfully!");

	    } catch (IOException e) {
	        e.printStackTrace();
	        model.addAttribute("message", "Error updating car!");
	    }

	    return "redirect:/admin/car";
	}





	// hàm xóa
	@PostMapping("/car/delete")
	public String deleteCar(@RequestParam("carID") int carID) {
		carDao.deleteById(carID);
		return "redirect:/admin/car";
	}

}
