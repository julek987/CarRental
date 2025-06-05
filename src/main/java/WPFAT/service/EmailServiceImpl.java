package WPFAT.service;

import WPFAT.service.interfaces.EmailService;
import WPFAT.service.interfaces.PdfService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;

@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    @Override
    public void sendEmail(String receiver, String content, String subject) {
        SimpleMailMessage mail = new SimpleMailMessage();
        mail.setFrom("CarRental.com");
        mail.setTo(receiver);
        mail.setSubject(subject);
        mail.setText(content);
        javaMailSender.send(mail);
    }

    @Override
    public void sendEmailWithAttachment(String receiver, String content, String subject,
                                        String attachmentName, ByteArrayOutputStream attachment) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom("CarRental.com");
            helper.setTo(receiver);
            helper.setSubject(subject);
            helper.setText(content);

            // Attach the PDF
            helper.addAttachment(attachmentName,
                    new ByteArrayResource(attachment.toByteArray()),
                    "application/pdf");

            javaMailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send email with attachment", e);
        }
    }
}