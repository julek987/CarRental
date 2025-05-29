package WPFAT.controller;

import WPFAT.model.AppUser;
import WPFAT.service.AppUserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AppUserController {

    private AppUserService appUserService;
    @Autowired
    public AppUserController(AppUserService appUserService) {
        this.appUserService = appUserService;
    }

    @RequestMapping(value = "/appUsers")
    public String listAppUsers(Model model, HttpServletRequest request) {
        int appUserId = ServletRequestUtils.getIntParameter(request, "appUserId", -1);
        if (appUserId > 0) {
            model.addAttribute("appUser", appUserService.getAppUserById(appUserId));
        }else
            model.addAttribute("appUser", new AppUser());
        model.addAttribute("appUserList", appUserService.listAppUsers());
        return "appUser";
    }
}
