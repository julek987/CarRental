package WPFAT.service.interfaces;

public interface EmailService {
    void SendEmail(String receiver, String content, String subject);
}
