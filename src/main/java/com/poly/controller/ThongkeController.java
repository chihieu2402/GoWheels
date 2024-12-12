package com.poly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.repositories.CarRepositorie;
import com.poly.repositories.ThongkeRepositorie;
import com.poly.repositories.accountRepositorie;

@RequestMapping(value = "/admin")
@PreAuthorize("hasAuthority('ADMIN')")
@Controller
public class ThongkeController {

    @Autowired
    private ThongkeRepositorie thongkeRepositorie;

    @Autowired
    private accountRepositorie customerRepository;
    @Autowired
    private CarRepositorie carRepository; // tai khoan nay chi co quyen admin nen khi goi countCustomers thi se bi loi

    // Tổng doanh thu
    @GetMapping("/thongke")
    public String showDashboard(Model model) {
        Double totalRevenue = thongkeRepositorie.getTotalRevenue();
        model.addAttribute("totalRevenue", totalRevenue != null ? totalRevenue : 0.0);

        // Thống kê số lượng khách hàng
        long customerCount = customerRepository.countCustomers();
        model.addAttribute("customerCount", customerCount);
        
        // thong ke xe co trong du lieu 
        long carCount =carRepository.countCar();
        model.addAttribute("carCount", carCount);

        return "views/admin/Thongke"; // Trả về trang Thongke.html
        
    }
}
