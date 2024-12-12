package com.poly.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.poly.dto.ChatMessageDto;

@Controller
public class ChatController {

    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public ChatMessageDto sendMessage(ChatMessageDto message) {
        System.out.println("User: " + message.getUserName() + ", Message: " + message.getContent());
        return message; // Tin nhắn gửi kèm userName và content
    }
}
