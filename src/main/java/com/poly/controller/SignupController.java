package com.poly.controller;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.dao.AccountDao;
import com.poly.dto.RegisterDto;
import com.poly.entity.Account;
import com.poly.entity.Customer;
import com.poly.dao.CustomerDao;


@Controller
public class SignupController {
	@Autowired
	AccountDao accDao;
	@Autowired
	CustomerDao cusDao;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	List<Account> account;
	
	@RequestMapping(value = "/index/signup")
	public String show() {
		return "/views/signup";
	}

//	@RequestMapping(value = "/index/signup", method = RequestMethod.POST)
//	public String create(Model model, @RequestParam("user") String username, @RequestParam("pass") String pw,
//			@RequestParam("passconfirm") String pwconfirm) {
//		if (username.isBlank()||pw.isBlank()||pwconfirm.isBlank()) {
//			model.addAttribute("mes", "Vui lòng điền đầy đủ thông tin");
//		} else {
//			account = accDao.findAll();
//			for (Account acc : account) {
//				if (acc.getUserName().equals(username)) {
//					model.addAttribute("mes", "Username đã tồn tại");
//					return "/views/signup";
//				} else if (!pw.equals(pwconfirm)){
//					model.addAttribute("mes", "Mật khẩu không trùng khớp");
//					return "/views/signup";
//				} else {
//					Account a = new Account();
//					a.setUserName(username);
//					a.setPassWord(pw);
//
//					accDao.save(a);
//					model.addAttribute("mes", "Đăng kí thành công!");
//				}
//			}
//		}
//		return "/views/signup";
//	}
	@PostMapping("/account/handle-register")
	public String handleRegister(@ModelAttribute RegisterDto registerDto, Model model) {
		List<Account> list = accDao.findAll();		
		
		List<String> name = list.stream().map(Account::getUserName).collect(Collectors.toList());
		
		Boolean check = !name.contains(registerDto.getName());
		System.out.println(registerDto.getName());
		Boolean checkpass = registerDto.getPassword().equals(registerDto.getPasswordconfirm());
		System.out.println("check:"+check);
		System.out.println("check pas :"+checkpass);
		if(!check) {
			model.addAttribute("mes", "Username is exist");
	        return "/views/signup"; 
		} else if (!checkpass) {
			model.addAttribute("mes", "Passwords do not match");
	        return "/views/signup"; 
		}
		
	   
	    accDao.save(Account.builder()
	            .userName(registerDto.getName())
	            .passWord(passwordEncoder.encode(registerDto.getPassword()))
	            .build());
	    int id = accDao.findByUserName(registerDto.getName()).get().getAccountID();
	    System.out.println("ID: "+id);
	    Customer cus = new Customer();
	    cus.setAccountID(id);
	    cusDao.save(cus);
	    return "redirect:/index/login";
	}

}
