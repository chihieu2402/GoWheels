package com.poly.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.poly.dto.NotificationDto;

@Service
public class NotificationServiceImpl implements NotificationService {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Override
    public void sendNotification(String message) {
        NotificationDto notificationDto = new NotificationDto(message);
        notificationDto.setMessage(message);
        messagingTemplate.convertAndSend("/topic/notifications", notificationDto);
    }

}