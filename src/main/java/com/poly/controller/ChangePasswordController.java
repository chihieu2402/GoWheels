package com.poly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.auth.UserRoot;
import com.poly.dao.AccountDao;
import com.poly.entity.Account;

@Controller
@RequestMapping("/index")
public class ChangePasswordController {

    @Autowired
    private AccountDao accDao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/change-password")
    public String changePassword(
            @RequestParam("currentPassword") String currentPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            Authentication authentication,
            Model model) {

        // Lấy thông tin người dùng đã đăng nhập
        UserRoot userRoot = (UserRoot) authentication.getPrincipal();
        String username = userRoot.getUsername(); // Giả sử username là duy nhất

        // Tìm tài khoản dựa trên username
        Account account = accDao.findByUserName(username).orElse(null);

        if (account == null) {
            model.addAttribute("error", "Không tìm thấy tài khoản.");
            return "/views/changePassword";
        }

        // Kiểm tra mật khẩu hiện tại
        if (!passwordEncoder.matches(currentPassword, account.getPassWord())) {
            model.addAttribute("error", "Mật khẩu hiện tại không đúng.");
            return "/views/changePassword";
        }

        // Kiểm tra mật khẩu mới và xác nhận
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp.");
            return "/views/changePassword";
        }

        // Cập nhật mật khẩu mới
        account.setPassWord(passwordEncoder.encode(newPassword));
        accDao.save(account);

        model.addAttribute("message", "Đổi mật khẩu thành công.");
        return "/views/changePassword";
    }
}
