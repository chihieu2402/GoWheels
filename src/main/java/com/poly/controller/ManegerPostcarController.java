package com.poly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.Service.CarPostService;

import jakarta.servlet.ServletContext;

@RequestMapping(value = "/admin")
@PreAuthorize("hasAuthority('ADMIN')")
@Controller
public class ManegerPostcarController {

    @Autowired
    private CarPostService carPostService;
    

    @RequestMapping("/PendingCar")
    public String managePosts(Model model) {
        model.addAttribute("posts", carPostService.getAllPendingPosts());
        return "views/admin/managePosts";
    }

    @PostMapping("/approvePost")
    public String approvePost(@RequestParam int postID) {
        carPostService.approvePost(postID);
        return "redirect:/admin/PendingCar"; // Redirect to the manage posts page
    }

    @PostMapping("/rejectPost")
    public String rejectPost(@RequestParam int postID) {
        carPostService.rejectPost(postID);
        return "redirect:/admin/PendingCar"; // Redirect to the manage posts page
    }
}
