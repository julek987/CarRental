package WPFAT.controller;

import WPFAT.model.AppUser;
import WPFAT.service.AppUserService;
import WPFAT.service.ReCaptchaService;
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

    @Autowired
    public RegisterController(AppUserService appUserService, ReCaptchaService reCaptchaService) {
        this.appUserService = appUserService;
        this.reCaptchaService = reCaptchaService;
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
        return "redirect:/login";
    }
}