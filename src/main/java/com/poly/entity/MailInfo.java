package com.poly.entity;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MailInfo implements Serializable{

	String from;
	String to;
	String[] cc;
	String[] bcc;
	String subject;
	String body;
	MultipartFile[] attachments;

	public MailInfo(String to, String subject, String body) {
		this.from = "quanbui.brvt@gmail.com";
		this.to = to;
		this.subject = subject;
		this.body = body;
	}
}
