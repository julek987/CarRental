package WPFAT.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {


    @RequestMapping(value = "/login")
    public String login(@RequestParam(value = "error", required = false) String error,
                        @RequestParam(value = "logout", required = false) String logout,
                        Model model) {
        if (error != null) {
            model.addAttribute("error", "Your username and/or password is invalid.");
        }
        if (logout != null) {
            model.addAttribute("msg", "You have been logged out successfully.");
        }
        return "login";
    }

    @RequestMapping(value = "/AccessDenied")
    public String accessDenied() {
        return "AccessDenied";
    }
}
