package WPFAT.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AccessDeniedController {

    @RequestMapping(value = "accessDenied")
    public String accessDenied() {
        return "accessDenied";
    }
}
