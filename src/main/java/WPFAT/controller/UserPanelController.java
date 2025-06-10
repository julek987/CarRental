package WPFAT.controller;

import WPFAT.model.AppUser;
import WPFAT.model.Order;
import WPFAT.service.interfaces.AppUserService;
import WPFAT.service.interfaces.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserPanelController {

    private final AppUserService appUserService;
    private final OrderService orderService;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserPanelController(AppUserService appUserService, OrderService orderService, PasswordEncoder passwordEncoder) {
        this.appUserService = appUserService;
        this.orderService = orderService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/panel")
    public String showUserPanel(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        AppUser user = appUserService.getAppUserByLogin(userDetails.getUsername());
        List<Order> orders = orderService.getOrdersByUser(user);

        model.addAttribute("user", user);
        model.addAttribute("orders", orders);
        return "user-panel";
    }

    @PostMapping("/update-info")
    public String updateUserInfo(@AuthenticationPrincipal UserDetails userDetails,
                                 @RequestParam String firstName,
                                 @RequestParam String lastName,
                                 @RequestParam String email,
                                 @RequestParam String telephone) {

        AppUser user = appUserService.getAppUserByLogin(userDetails.getUsername());
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setTelephone(telephone);

        appUserService.editAppUser(user);
        return "redirect:/user/panel";
    }

    @PostMapping("/change-password")
    public String changePassword(@AuthenticationPrincipal UserDetails userDetails,
                                 @RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 RedirectAttributes redirectAttributes) {

        AppUser user = appUserService.getAppUserByLogin(userDetails.getUsername());

        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            redirectAttributes.addFlashAttribute("error", "Current password is incorrect");
            return "redirect:/user/panel";
        }


        user.setPassword(passwordEncoder.encode(newPassword));
        appUserService.editAppUser(user);

        redirectAttributes.addFlashAttribute("success", "Password changed successfully");
        return "redirect:/user/panel";
    }
}