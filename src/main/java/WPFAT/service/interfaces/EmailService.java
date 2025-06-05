package WPFAT.service.interfaces;

import java.io.ByteArrayOutputStream;


public interface EmailService {
    void sendEmail(String receiver, String content, String subject);
    void sendEmailWithAttachment(String receiver, String content, String subject,
                                 String attachmentName, ByteArrayOutputStream attachment);
}
