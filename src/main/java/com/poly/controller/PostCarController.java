package com.poly.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.poly.Service.CarBrandSerivce;
import com.poly.Service.CarPostService;
import com.poly.Service.CustomUserDetails;
import com.poly.Service.CustomUserDetailsService;
import com.poly.dao.PendingCarPostDao;
import com.poly.entity.Account;
import com.poly.entity.ImagePending;
import com.poly.entity.PendingCarPost;

@Controller
public class PostCarController {

	private final String UPLOAD_DIR = "src/main/resources/static/images/";

	@Autowired
	private CarPostService carPostService;

	@Autowired
	private CarBrandSerivce brandService;

	@Autowired
	private PendingCarPostDao pendingCarPostDao;

	@Autowired
	private CustomUserDetailsService customerService;

	@GetMapping("/index/postcar")
	@PreAuthorize("hasAuthority('OWNER')")
	public String showPostCarForm(Model model, Principal principal) {
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
//		Account account = userDetails.getAccount();
//		int customerID = account.getCustomer().getCustomerID();
		
//		model.addAttribute("customerID", customerID);
		model.addAttribute("pendingCarPost", new PendingCarPost());
		model.addAttribute("carBrands", brandService.findAll());

		return "views/postcar";
	}

	@PostMapping("/index/addPost")
	public String addPost(@Validated @ModelAttribute PendingCarPost pendingCarPost,
			@RequestParam("image1") MultipartFile image1, @RequestParam("image2") MultipartFile image2,
			@RequestParam("image3") MultipartFile image3, @RequestParam("image4") MultipartFile image4,
			@RequestParam("ownershipDocument1") MultipartFile ownershipDocument1,
			@RequestParam("ownershipDocument2") MultipartFile ownershipDocument2, BindingResult result,
			RedirectAttributes redirectAttributes) {

		if (result.hasErrors()) {
			redirectAttributes.addFlashAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
			return "views/postcar";
		}

		try {
			// Xử lý hình ảnh
			handleUploadImage(pendingCarPost, image1);
			handleUploadImage(pendingCarPost, image2);
			handleUploadImage(pendingCarPost, image3);
			handleUploadImage(pendingCarPost, image4);

			// Xử lý giấy tờ sở hữu
			handleUploadOwnershipDocument(pendingCarPost, ownershipDocument1, ownershipDocument2);

			// Thêm bài đăng vào cơ sở dữ liệu
			carPostService.addPost(pendingCarPost);

			redirectAttributes.addFlashAttribute("successMessage", "Bài đăng đã được thêm thành công!");
		} catch (IOException e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi thêm bài đăng.");
		}

		return "views/postcar";
	}

	private void handleUploadImage(PendingCarPost pendingCarPost, MultipartFile imageFile) throws IOException {
		if (!imageFile.isEmpty()) {
			String fileName = imageFile.getOriginalFilename();
			Path uploadPath = Paths.get(UPLOAD_DIR + fileName);
			Files.copy(imageFile.getInputStream(), uploadPath, StandardCopyOption.REPLACE_EXISTING);

			// Lưu tên hình ảnh vào đối tượng ImagePending
			if (pendingCarPost.getImagePending() == null) {
				pendingCarPost.setImagePending(new ImagePending()); // Khởi tạo nếu chưa có
			}

			// Gán tên file vào các trường image1, image2, image3, image4
			switch (imageFile.getName()) {
			case "image1":
				pendingCarPost.getImagePending().setImage1(fileName);
				break;
			case "image2":
				pendingCarPost.getImagePending().setImage2(fileName);
				break;
			case "image3":
				pendingCarPost.getImagePending().setImage3(fileName);
				break;
			case "image4":
				pendingCarPost.getImagePending().setImage4(fileName);
				break;
			}
		}
	}

	private void handleUploadOwnershipDocument(PendingCarPost pendingCarPost, MultipartFile doc1, MultipartFile doc2)
			throws IOException {
		if (!doc1.isEmpty()) {
			String fileName = doc1.getOriginalFilename();
			Path uploadPath = Paths.get(UPLOAD_DIR + fileName);
			Files.copy(doc1.getInputStream(), uploadPath, StandardCopyOption.REPLACE_EXISTING);
			if (pendingCarPost.getImagePending() == null) {
				pendingCarPost.setImagePending(new ImagePending());
			}
			pendingCarPost.getImagePending().setImgOwnershipCertificate1(fileName);
		}

		if (!doc2.isEmpty()) {
			String fileName = doc2.getOriginalFilename();
			Path uploadPath = Paths.get(UPLOAD_DIR + fileName);
			Files.copy(doc2.getInputStream(), uploadPath, StandardCopyOption.REPLACE_EXISTING);
			if (pendingCarPost.getImagePending() == null) {
				pendingCarPost.setImagePending(new ImagePending());
			}
			pendingCarPost.getImagePending().setImgOwnershipCertificate2(fileName);
		}
	}

	@GetMapping("/views/admin/managePosts")
	public String managePosts(Model model) {
		List<PendingCarPost> posts = pendingCarPostDao.findAll();
		model.addAttribute("posts", posts);
		return "views/admin/managePosts";
	}

	@PostMapping("/index/approvePost")
	public String approvePost(@RequestParam int postID) {
		carPostService.approvePost(postID);
		return "redirect:/index/managePosts";
	}

	@PostMapping("/index/rejectPost")
	public String rejectPost(@RequestParam int postID) {
		carPostService.rejectPost(postID);
		return "redirect:/index/managePosts";
	}
}
