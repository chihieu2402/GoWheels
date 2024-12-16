package com.poly.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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
import com.poly.Service.CustomerService;
import com.poly.entity.Customer;
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
	private CustomerService customerService;

	@GetMapping("/index/postcar")
    @PreAuthorize("hasAuthority('OWNER')")
    public String showPostCarForm(Model model ) {
		
		
		// Lấy thông tin người dùng hiện tại từ Spring Security
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName(); // Hoặc bạn có thể sử dụng các thông tin khác của người dùng
        	
        // Lấy CustomerID của người dùng từ cơ sở dữ liệu hoặc service
        Customer customer = customerService.findByUsername(username);
        if (customer != null) {
            model.addAttribute("customerID", customer.getCustomerID());
        }
		
        model.addAttribute("pendingCarPost", new PendingCarPost());
        model.addAttribute("carBrands", brandService.findAll());
        
        return "views/postcar";  // Trả về view postcar
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
			return "views/thatbai";
		}

		try {
			ImagePending imagePending = new ImagePending();
			imagePending.setImage1(saveFile(image1));
			imagePending.setImage2(saveFile(image2));
			imagePending.setImage3(saveFile(image3));
			imagePending.setImage4(saveFile(image4));
			imagePending.setImgOwnershipCertificate1(saveFile(ownershipDocument1));
			imagePending.setImgOwnershipCertificate2(saveFile(ownershipDocument2));

			pendingCarPost.setImagePending(imagePending);

			carPostService.addPost(pendingCarPost);
			redirectAttributes.addFlashAttribute("successMessage", "Bài đăng đã được thêm thành công!");
		} catch (IOException e) {
			redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi thêm bài đăng.");
		}

		return "views/thanhcong";
	}

	private String saveFile(MultipartFile file) throws IOException {
		if (!file.isEmpty()) {
			String fileName = file.getOriginalFilename();
			Path uploadPath = Paths.get(UPLOAD_DIR + fileName);
			Files.copy(file.getInputStream(), uploadPath, StandardCopyOption.REPLACE_EXISTING);
			return fileName;
		}
		return null;
	}

	@GetMapping("/index/managePosts")
	@PreAuthorize("hasAuthority('ADMIN')")
	public String managePosts(Model model) {
		model.addAttribute("pendingPosts", carPostService.getAllPendingPosts());
		return "views/managePosts";
	}

	@PostMapping("/index/approvePost")
	@PreAuthorize("hasAuthority('ADMIN')")
	public String approvePost(@RequestParam("postID") int postID, RedirectAttributes redirectAttributes) {
		carPostService.approvePost(postID);
		redirectAttributes.addFlashAttribute("successMessage", "Bài đăng đã được duyệt thành công!");
		return "redirect:/admin/PendingCar";
	}

	@PostMapping("/index/rejectPost")
	@PreAuthorize("hasAuthority('ADMIN')")
	public String rejectPost(@RequestParam("postID") int postID, RedirectAttributes redirectAttributes) {
		carPostService.rejectPost(postID);
		redirectAttributes.addFlashAttribute("successMessage", "Bài đăng đã bị từ chối.");
		return "redirect:/admin/PendingCar";
	}

}
