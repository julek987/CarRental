package WPFAT.controller;

import WPFAT.model.AppUser;
import WPFAT.model.VerificationToken;
import WPFAT.repository.VerificationTokenRepository;
import WPFAT.service.interfaces.AppUserService;
import WPFAT.service.interfaces.EmailService;
import WPFAT.service.interfaces.ReCaptchaService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.time.LocalDateTime;
import java.util.UUID;

@Controller
public class RegisterController {

    private final AppUserService appUserService;
    private final ReCaptchaService reCaptchaService;
    private final EmailService emailService;
    private final VerificationTokenRepository verificationTokenRepository;

    @Autowired
    public RegisterController(AppUserService appUserService,
                              ReCaptchaService reCaptchaService,
                              EmailService emailService,
                              VerificationTokenRepository verificationTokenRepository) {
        this.appUserService = appUserService;
        this.reCaptchaService = reCaptchaService;
        this.emailService = emailService;
        this.verificationTokenRepository = verificationTokenRepository;
    }

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("appUser", new AppUser());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute AppUser appUser,
                               HttpServletRequest request,
                               Model model) {
        boolean isCaptchaValid = reCaptchaService.verify(request.getParameter("g-recaptcha-response"));

        if (!isCaptchaValid) {
            model.addAttribute("error", "CAPTCHA verification failed");
            return "register";
        }

        appUser.setVerified(false);
        appUserService.addAppUser(appUser);

        // Create token
        String token = UUID.randomUUID().toString();
        VerificationToken verificationToken = new VerificationToken();
        verificationToken.setToken(token);
        verificationToken.setUser(appUser);
        verificationToken.setExpiryDate(LocalDateTime.now().plusHours(24)); // valid for 24h

        verificationTokenRepository.save(verificationToken);

        // Send email
        String verificationUrl = request.getRequestURL().toString().replace("/register", "/verify?token=" + token);
        String emailContent = "Click the link to activate your account: " + verificationUrl;
        String subject = "CarRental Account Activation";

        // Use the simple email method without attachments
        emailService.sendEmail(appUser.getEmail(), emailContent, subject);

        return "redirect:/login";
    }
}