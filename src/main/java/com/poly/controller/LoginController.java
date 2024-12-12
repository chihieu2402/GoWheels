package com.poly.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.poly.auth.UserRoot;
import com.poly.dao.AccountDao;
import com.poly.dao.CustomerDao;
import com.poly.entity.Account;
import com.poly.entity.Customer;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	@Autowired
	AccountDao accDao;
	@Autowired
	HttpSession ses;
    @Autowired
    private CustomerDao customerDao;
	@Bean
	public PasswordEncoder passwordEncoderLogin() {
		return new BCryptPasswordEncoder();
	}
	@RequestMapping(value = "/index/login")
	public String login(@ModelAttribute Account user, Model model) {

//		List<Account> accs = accDao.findAll();
//		for (Account acc : accs) {
//			// Mã hóa mật khẩu hiện tại và lưu lại
//			String encodedPassword = passwordEncoderLogin().encode(acc.getPassWord());
//			acc.setPassWord(encodedPassword);
//			accDao.save(acc);
//		}

		model.addAttribute("user", user);
		return "/views/login";
	}

//	@RequestMapping(value = "/index/login", method = RequestMethod.POST)
//	public String loginP(@RequestParam("username") String ur, @RequestParam("password") String pw, Model model) {
//		Account a  = (Account) ses.getAttribute("userSes");
//		if(a!=null) {
//			ses.removeAttribute("userSes");
//		}
//		if (ur.isBlank() || pw.isBlank()) {
//			model.addAttribute("mes", "Enter complete information");
//			return "/views/login";
//		} else {
//			try {
//				Account acc = accDao.findByUserName(ur).get();
//				if(acc.getPassWord().equals(pw)) {
//					ses.setAttribute("userSes",acc);
//					model.addAttribute("mes", "Login Success!");
//					return "redirect:/index";
//				} else {
//					model.addAttribute("mes", "Invalid Username or Password");
//					return "/views/login";
//				}
//			} catch (Exception e) {
//				model.addAttribute("mes", "Invalid Username or Password");
//				return "/views/login";
//			}
//
//		}
//	}

	@RequestMapping(value = "/index/logout", method = RequestMethod.GET)
	@ResponseBody
	public String log() {
		ses.removeAttribute("userSes");
		return "lú";
	}

	@RequestMapping("/account/login/failure")
	public String handleLoginFailure(Model model) {
		model.addAttribute("mes", "Invalid Username or Password");
		return "/views/login";
	}

	@RequestMapping(value = "/account/login/success", method = RequestMethod.GET)
	public String success(@ModelAttribute Account user,Authentication auth, Model model) {
		UserRoot userRoot = (UserRoot) auth.getPrincipal();
		
		//start: lấy email để kiểm tra
		Customer customer = userRoot.getUser().getCustomer();
	
		  if (customer == null || customer.getEmail() == null || customer.getEmail().isEmpty()) {
		        model.addAttribute("customer",customer);
		        return "/views/updateCustomer";
		    }
			//end: lấy email để kiểm tra	
		System.out.println("::::::::::::::"
				+ userRoot.getAuthorities().stream().map(v -> v.getAuthority()).collect(Collectors.joining(", ")));
		ses.setAttribute("userSes", userRoot);
		return "redirect:/index";
	}
	@RequestMapping("/accessDenied")
	public String accessDenied() {
		return "/views/denied";
	}
	
	
	// user tự update khi mới vào
	@PostMapping("/customer/update")
	public String updateCustomer(@ModelAttribute("customer") Customer customer, Authentication auth) {
	    try {
	        Customer existingCustomer = customerDao.findByCustomerID(customer.getCustomerID());
	        if (existingCustomer != null) {
	            existingCustomer.setCustomerName(customer.getCustomerName());
	            existingCustomer.setEmail(customer.getEmail());
	            existingCustomer.setPhoneNumber(customer.getPhoneNumber());
	            existingCustomer.setAddress(customer.getAddress());
	            existingCustomer.setGender(customer.getGender());
	            existingCustomer.setIdCard(customer.getIdCard());
	            
	            customerDao.save(existingCustomer);  // Lưu lại đối tượng đã cập nhật
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Xử lý lỗi nếu có
	    }
		UserRoot userRoot = (UserRoot) auth.getPrincipal();
	    System.out.println("::::::::::::::"
				+ userRoot.getAuthorities().stream().map(v -> v.getAuthority()).collect(Collectors.joining(", ")));
		ses.setAttribute("userSes", userRoot);
	    return "redirect:/index";
	}

	  @GetMapping("/quenMatKhau")
	    public String quenMatKhau() {
	        return "views/quenMatKhau";
	    }
	  @RequestMapping(value="/customer/update", method=RequestMethod.GET)
	  public String updateCus(@ModelAttribute Account user,Authentication auth, Model model) {
		 UserRoot userRoot = (UserRoot) auth.getPrincipal();
		 Customer customer = userRoot.getUser().getCustomer();
		 model.addAttribute("customer",customer);
	  	return "/views/updateCustomer";
	  }
	  
}
