package WPFAT.controller;

import WPFAT.model.AppUser;
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

@Controller
public class RegisterController {

    private final AppUserService appUserService;
    private final ReCaptchaService reCaptchaService;
    private final EmailService emailService;

    @Autowired
    public RegisterController(AppUserService appUserService, ReCaptchaService reCaptchaService, EmailService emailService) {
        this.appUserService = appUserService;
        this.reCaptchaService = reCaptchaService;
        this.emailService = emailService;
    }

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("appUser", new AppUser());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute AppUser appUser, HttpServletRequest request, Model model) {
        boolean isCaptchaValid = reCaptchaService.verify(request.getParameter("g-recaptcha-response"));

        if(!isCaptchaValid) {
            model.addAttribute("error", "CAPTCHA verification failed");
            return "register";
        }

        appUserService.addAppUser(appUser);
        emailService.SendEmail(appUser.getEmail(), "Thanks for registration",  "CarRental account creation");
        return "redirect:/login";
    }
}