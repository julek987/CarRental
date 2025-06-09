package WPFAT.controller;

import WPFAT.model.AppUser;
import WPFAT.service.interfaces.AppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/users")
public class AppUserController {

    private final AppUserService appUserService;

    @Autowired
    public AppUserController(AppUserService appUserService) {
        this.appUserService = appUserService;
    }

    @GetMapping
    public String listAppUsers(@RequestParam(required = false) String login,
                               @RequestParam(required = false) String role,
                               Model model) {
        List<AppUser> filteredUsers = appUserService.listAppUsersByLoginAndRole(login, role);
        model.addAttribute("users", filteredUsers);
        return "admin-panel";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("user", new AppUser());
        return "add-user";
    }

    @PostMapping("/add")
    public String addAppUser(@ModelAttribute AppUser appUser) {
        appUserService.addAppUser(appUser);
        return "redirect:/admin/users";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable long id, Model model) {
        AppUser user = appUserService.getAppUserById(id);
        model.addAttribute("user", user);
        return "edit-user";
    }

    @PostMapping("/edit/{id}")
    public String editAppUser(@PathVariable long id, @ModelAttribute AppUser appUser) {
        appUserService.editAppUser(appUser);
        return "redirect:/admin/users";
    }

    @GetMapping("/delete/{id}")
    public String deleteAppUser(@PathVariable long id) {
        appUserService.deleteAppUser(id);
        return "redirect:/admin/users";
    }
}
