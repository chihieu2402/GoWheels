package com.poly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.poly.Service.MailerService;
import com.poly.dao.AccountDao;
import com.poly.dao.CustomerDao;
import com.poly.entity.Account;
import com.poly.entity.Customer;
import com.poly.entity.MailInfo;

import jakarta.mail.MessagingException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
@Controller
@RequestMapping("/account")
public class QuenMatKhauController{
    @Autowired
    private MailerService mailerService;
    
    @Autowired
    private CustomerDao customerDao;
    
    @Autowired
    private AccountDao accountDao;

    private final Map<String, String> verificationCodes = new HashMap<>();

    @PostMapping("/send-code")
    public String sendVerificationCode(@RequestParam("email") String email, Model model) {
        if (email == null || email.isEmpty()) {
            throw new IllegalArgumentException("Email không được để trống!");
        }

        // Generate verification code
        String code = String.format("%06d", new Random().nextInt(999999));

        try {
            // Send email
            mailerService.send(new MailInfo(email, "Mã xác minh của bạn", "Mã xác minh của bạn là: " + code));
        } catch (MessagingException e) {
            throw new RuntimeException("Lỗi khi gửi email: " + e.getMessage());
        }

        // Save verification code
        verificationCodes.put(email, code);

        // Add the email to the model for use on the confirmation page
        model.addAttribute("email", email);

        // Return the confirmation page
        return "views/verifyCode"; // Trang xác minh mã (verifyCode.html)
    }
    
    @RequestMapping(value = "/verify-code", method = RequestMethod.POST)
    public String verifyCode(@RequestParam("email") String email, @RequestParam("code") String code, Model model) {
        // Kiểm tra mã xác minh
        String storedCode = verificationCodes.get(email);
        
        if (storedCode != null && storedCode.equals(code)) {
            // Mã đúng, chuyển hướng đến trang thay đổi mật khẩu
            return "redirect:/account/change-password?email=" + email;
        } else {
            // Mã sai, thông báo lỗi
            model.addAttribute("error", "Mã xác minh không đúng. Vui lòng thử lại.");
            return "verifyCode"; // Trả lại trang xác minh với thông báo lỗi
        }
    }

 // Trang hiển thị form đổi mật khẩu
    @RequestMapping(value = "/change-password", method = RequestMethod.GET)
    public String changePasswordPage(@RequestParam("email") String email, Model model) {
        // Đưa email vào model để sử dụng trong form
        model.addAttribute("email", email);
        return "views/doiMatKhauTuEmail"; // Tên file giao diện (VD: changePassword.html)
    }
    
 // Xử lý form đổi mật khẩu
    @RequestMapping(value = "/change-password", method = RequestMethod.POST)
    public String changePassword(@RequestParam("email") String email,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 Model model) {

    	System.out.println(email);
        // Tìm thông tin khách hàng và tài khoản
        Customer c = customerDao.findByEmail(email);
        if (c == null) {
            model.addAttribute("error", "Không tìm thấy email trong hệ thống.");
            return "views/doiMatKhauTuEmail"; // Trả lại trang lỗi
        }

        int id = c.getAccountID();
        Account a = accountDao.findByAccountID(id);
        if (a == null) {
            model.addAttribute("error", "Không tìm thấy tài khoản liên kết với email.");
            return "views/doiMatKhauTuEmail"; // Trả lại trang lỗi
        }

        // Kiểm tra xem hai mật khẩu có khớp không
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            model.addAttribute("email", email); // Giữ email để hiển thị lại trong form
            return "views/doiMatKhauTuEmail"; // Trả lại trang với thông báo lỗi
        }
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(newPassword);
       
        // Cập nhật mật khẩu
        a.setPassWord(encodedPassword); // Thay đổi giá trị mật khẩu
        try {
            accountDao.save(a); // Lưu đối tượng Account vào database
            return "redirect:/index/login"; // Thành công, chuyển đến trang đăng nhập
        } catch (Exception e) {
            model.addAttribute("error", "Đã xảy ra lỗi khi thay đổi mật khẩu. Vui lòng thử lại.");
            model.addAttribute("email", email);
            return "views/doiMatKhauTuEmail"; // Trả lại trang với thông báo lỗi
        }
    }

}
