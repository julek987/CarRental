package WPFAT.controller;

import WPFAT.model.AppUser;
import WPFAT.model.VerificationToken;
import WPFAT.repository.VerificationTokenRepository;
import WPFAT.service.interfaces.AppUserService;
import WPFAT.service.interfaces.EmailService;
import WPFAT.service.interfaces.ReCaptchaService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
    public String registerUser(
            @Valid @ModelAttribute("appUser") AppUser appUser,
            BindingResult bindingResult,
            HttpServletRequest request,
            Model model) {

        boolean isCaptchaValid = reCaptchaService.verify(request.getParameter("g-recaptcha-response"));

        if (!isCaptchaValid) {
            model.addAttribute("error", "CAPTCHA verification failed");
            return "register";
        }

//        // If validation errors exist, show form again with errors
//        if (bindingResult.hasErrors()) {
//            return "register";
//        }

        // Check if login or email already exist
        if (appUserService.getAppUserByLogin(appUser.getLogin()) != null) {
            bindingResult.rejectValue("login", "error.appUser", "Login already exists");
            return "register";
        }
        if (appUserService.getUserByEmail(appUser.getEmail())) {
            bindingResult.rejectValue("email", "error.appUser", "Email already exists");
            return "register";
        }

        appUser.setVerified(false);
        appUserService.addAppUser(appUser);

        String token = UUID.randomUUID().toString();
        VerificationToken verificationToken = new VerificationToken();
        verificationToken.setToken(token);
        verificationToken.setUser(appUser);
        verificationToken.setExpiryDate(LocalDateTime.now().plusHours(24)); // valid for 24h

        verificationTokenRepository.save(verificationToken);

        String verificationUrl = request.getRequestURL().toString().replace("/register", "/verify?token=" + token);
        String emailContent = "Click the link to activate your account: " + verificationUrl;
        String subject = "CarRental Account Activation";

        emailService.sendEmail(appUser.getEmail(), emailContent, subject);

        return "redirect:/login";
    }
}