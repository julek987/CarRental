package WPFAT.controller;

import WPFAT.model.AppUser;
import WPFAT.service.AppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class RegisterController {

    AppUserService appUserService;

    @Autowired
    public RegisterController(AppUserService appUserService) {
        this.appUserService = appUserService;
    }

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("appUser", new AppUser());
        return "register";
    }


    @PostMapping("/register")
    public String registerUser(@ModelAttribute AppUser appUser){
        appUserService.addAppUser(appUser);
        return "login";
    }
}
