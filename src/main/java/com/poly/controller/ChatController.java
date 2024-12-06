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
        // Log để kiểm tra nội dung tin nhắn
        System.out.println("Received message: " + message.getContent());
        return message; // Tin nhắn sẽ được gửi tới tất cả các client qua "/topic/public"
    }
}



