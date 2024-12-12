package com.poly.dto;

public class NotificationDto {
    private String message;

    // Constructor
    public NotificationDto(String message) {
        this.message = message;
    }

    // Getter
    public String getMessage() {
        return message;
    }

    // Setter
    public void setMessage(String message) {
        this.message = message;
    }
}
