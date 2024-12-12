package com.poly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.Service.NotificationService;
import com.poly.dto.NotificationDto;


@Controller
@RequestMapping(value = "/admin")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @GetMapping("/Notification")
    public String showNotificationForm(Model model) {
        model.addAttribute("notification", new NotificationDto(null));
        return "views/admin/Notification";
    }
    
    @MessageMapping("/sendNotification")
    public void sendNotification(String message) {
        notificationService.sendNotification(message);
    }
}
