package com.poly.Service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.poly.entity.MailInfo;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class MailerServiceImpl implements MailerService {
	@Autowired
	JavaMailSender sender;

	@Override
	public void send(MailInfo mail) throws MessagingException {
// TODO mã nguồn gửi email đặt ở đây
		// Tạo message
		MimeMessage message = sender.createMimeMessage();
		// Sử dụng Helper để thiết lập các thông tin cần thiết cho message
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
		helper.setFrom(mail.getFrom());
		helper.setTo(mail.getTo());
		helper.setSubject(mail.getSubject());
		helper.setText(mail.getBody(), true);
		helper.setReplyTo(mail.getFrom());
		String[] cc = mail.getCc();
		if (cc != null && cc.length > 0) {
			helper.setCc(cc);
		}
		String[] bcc = mail.getBcc();
		if (bcc != null && bcc.length > 0) {
			helper.setBcc(bcc);
		}
		
		
		// Lấy danh sách các tệp đính kèm từ đối tượng mail
		MultipartFile[] attachments = mail.getAttachments();

		// Kiểm tra xem danh sách tệp đính kèm có tồn tại và không rỗng
		if (attachments != null && attachments.length > 0) {
		    // Duyệt qua từng tệp đính kèm trong mảng
		    for (MultipartFile multipartFile : attachments) {
		        // Kiểm tra xem tệp đính kèm hiện tại có rỗng hay không
		        if (!multipartFile.isEmpty()) {
		            // Khai báo biến để lưu tạm thời tệp đính kèm
		            File tempFile;
		            try {
		                // Tạo một tệp tạm thời với tên bắt đầu bằng "attachment" và đuôi là tên gốc của tệp(.jpg)
		                tempFile = File.createTempFile("attachment", multipartFile.getOriginalFilename());
		                
		                // Chuyển nội dung của tệp đính kèm sang tệp tạm thời
		                multipartFile.transferTo(tempFile);
		                
		                // Thêm tệp đính kèm vào email, sử dụng tên gốc của tệp và tệp tạm thời đã tạo
		                helper.addAttachment(multipartFile.getOriginalFilename(), tempFile);
		            } catch (IOException e) {
		                // In thông tin chi tiết của ngoại lệ ra console để dễ dàng theo dõi lỗi
		                e.printStackTrace();
		            }
		        }
		    }
		}

		// Gửi message đến SMTP server
		sender.send(message);
	}

	@Override
	public void send(String to, String subject, String body) throws MessagingException {
		this.send(new MailInfo(to, subject, body));
	}

	List<MailInfo> list = new ArrayList<>();

	@Override
	public void queue(MailInfo mail) {
		list.add(mail);
	}

	@Override
	public void queue(String to, String subject, String body) {
		queue(new MailInfo(to, subject, body));
	}

	@Scheduled(fixedDelay = 5000)
	public void run() {
		while (!list.isEmpty()) {
			MailInfo mail = list.remove(0);
			try {
				this.send(mail);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
