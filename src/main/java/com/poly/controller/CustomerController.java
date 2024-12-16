package com.poly.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

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

import com.poly.dao.CustomerDao;
import com.poly.entity.Account;
import com.poly.entity.Customer;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasAuthority('ADMIN')")
public class CustomerController {
    
    @Autowired
    private CustomerDao customerDao;

    @GetMapping("/Customer")
    public String customers(Model model) {
        List<Customer> customers = customerDao.findAll();
        model.addAttribute("customers", customers);
        model.addAttribute("customer", new Customer());
        return "views/admin/Customer";
    }

    @PostMapping("/customer/create")
    public String createCustomer(@ModelAttribute("customer") Customer customer) {
        customerDao.save(customer);
        return "redirect:/admin/Customer";
    }

    @PostMapping("/customer/update")
    public String updateCustomer(@ModelAttribute("customer") Customer customer,
                                 @RequestParam("image11") MultipartFile image1, 
                                 @RequestParam("image22") MultipartFile image2,
                                 @RequestParam("image33") MultipartFile image3) {
        try {
            // Tạo thư mục lưu ảnh
            String uploadDir = "src/main/resources/static/images/";

            // Lưu các hình ảnh và lấy đường dẫn
            String image1Path = saveImage(image1, uploadDir);
            String image2Path = saveImage(image2, uploadDir);
            String image3Path = saveImage(image3, uploadDir);

            // Tải lại khách hàng từ cơ sở dữ liệu
            Customer u = customerDao.findByCustomerID(customer.getCustomerID());

//            // Cập nhật các đường dẫn hình ảnh vào đối tượng customer
//            if (image1Path != null) u.setImage1(image1Path);
//            if (image2Path != null) u.setImage2(image2Path);
//            if (image3Path != null) u.setImage3(image3Path);

            // Cập nhật thông tin khách hàng
            customerDao.save(u);  // Lưu đối tượng đã cập nhật

        } catch (Exception e) {
            System.out.println("Đã có lỗi xảy ra khi cập nhật hình ảnh: " + e.getMessage());
        }

        return "redirect:/admin/Customer";
    }

    private String saveImage(MultipartFile image, String uploadDir) {
        if (image.isEmpty()) {
            return null;
        }

        try {
            String fileName = UUID.randomUUID().toString() + "_" + image.getOriginalFilename();
            Path uploadPath = Paths.get(uploadDir + fileName);

            // Tạo thư mục nếu không tồn tại
            Files.createDirectories(uploadPath.getParent());

            // Lưu file
            image.transferTo(uploadPath.toFile());

            System.out.println("Saved image to: " + uploadPath.toString()); // Kiểm tra đường dẫn

            return "/images/" + fileName; // Lưu đường dẫn ảnh vào cơ sở dữ liệu
        } catch (IOException e) {
            System.out.println("Đã có lỗi xảy ra khi lưu ảnh: " + e.getMessage());
            return null;
        }
    }
    
    
    @GetMapping("/customer/edit/{id}")
    public String editCustomer(@PathVariable("id") Integer customerID, Model model) {
    	model.addAttribute("able", true);
        Customer customer = customerDao.findById(customerID).orElse(null);
        model.addAttribute("customer", customer);
        List<Customer> customers = customerDao.findAll();
        model.addAttribute("customers", customers);
        return "views/admin/Customer";
    }

    @PostMapping("/customer/delete/{id}")
    public String deleteCustomer(@PathVariable("id") Integer customerID) {
        customerDao.deleteById(customerID);
        return "redirect:/admin/Customer";
    }
    @PostMapping("/customer/reset")
    public String reset(Model model) {
      
        return "redirect:/admin/Customer";
    }
}
