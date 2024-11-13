package com.poly.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.auth.UserRoot;
import com.poly.dao.AccountDao;
import com.poly.dao.CarDao;
import com.poly.dao.ReviewDao;
import com.poly.entity.Account;
import com.poly.entity.Car;
import com.poly.entity.ImageCar;
import com.poly.entity.Review;

@Controller
public class CarDetailController {

	@Autowired
	CarDao carDao;

	@Autowired
	ReviewDao reviewDao;

	@Autowired
	AccountDao accountDao;

	@RequestMapping(value = "/index/cars/{id}", method = RequestMethod.GET)
	public String getCarDetail(@PathVariable("id") int idcar, Model model) {

		Car carDetail = carDao.findBycarID(idcar);
		if (carDetail.getImageCar() != null) {
			model.addAttribute("carImage","/images"+ carDetail.getImageCar().getImage1());
		} else {
			model.addAttribute("carImage","/images/default-image.png");
		}
		model.addAttribute("carDetail", carDetail);

//		tìm cardetail theo carid
//		Car carDetail = carDao.findBycarID(idcar);
//		model.addAttribute("carDetail",carDetail);

//		tìm review theo carID
		List<Review> reviewByCarID = reviewDao.findByCarID(idcar);
		model.addAttribute("reviewByCarID", reviewByCarID);

//		tim sao trung bình theo carID		
		Double ratingTB = reviewDao.findByCarID(idcar).stream().mapToDouble(Review::getRating) // chuyển kiểu
				.average() // trung bình
				.orElse(0.0);
		ratingTB = Math.round(ratingTB * 100.0) / 100.0; // làm tròn 2 chữ số thập phân

		model.addAttribute("ratingTB", ratingTB);
		return "/views/carDetail";

	}

	@RequestMapping(value = "/index/cars/{id}", method = RequestMethod.POST)
	public String postCarDetail(Review review, @RequestParam("rateCarDetail") int rating, Model model,
			@PathVariable("id") int idcar, Authentication auth) {
		// lấy thông tin của người dùng đã đăng nhập

		// kiểm tra người dùng có tồn tại, đã đăng nhập chưa
		if (auth != null && auth.isAuthenticated()) {
			UserRoot userRoot = (UserRoot) auth.getPrincipal();
			String username = userRoot.getName();
			Account accountLogin = accountDao.findByUserName(username).get();
			review.setRating(rating);
			review.setCustomerID(accountLogin.getAccountID());
			review.setCarID(idcar);
			review.setReviewDate(new Date());

			reviewDao.save(review);
			return "redirect:/index/cars/{id}";
		}
		return "redirect:/index/login";

	}
}
