package com.poly.dto;

public class ChatMessageDto {
    private String content;
    private String userName; // Thêm trường userName

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
