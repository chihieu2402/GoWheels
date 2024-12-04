package com.poly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.poly.Service.MailerService;
import com.poly.entity.MailInfo;

import jakarta.mail.MessagingException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Controller
@RequestMapping("/account")
public class QuenMatKhauController{
    @Autowired
    private MailerService mailerService;

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

}
