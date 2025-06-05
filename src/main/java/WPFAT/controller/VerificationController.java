package WPFAT.controller;

import WPFAT.model.AppUser;
import WPFAT.model.VerificationToken;
import WPFAT.repository.VerificationTokenRepository;
import WPFAT.service.interfaces.AppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;

@Controller
public class VerificationController {

    private final VerificationTokenRepository verificationTokenRepository;
    private final AppUserService appUserService;

    @Autowired
    public VerificationController(VerificationTokenRepository verificationTokenRepository, AppUserService appUserService) {
        this.verificationTokenRepository = verificationTokenRepository;
        this.appUserService = appUserService;
    }

    @GetMapping("/verify")
    public String verifyUser(@RequestParam("token") String token) {
        VerificationToken verificationToken = verificationTokenRepository.findByToken(token);

        if (verificationToken == null) {
            System.out.println("verification token is null");
            return "redirect:/login?error=Invalid+verification+token";
        }

        if (verificationToken.getExpiryDate().isBefore(LocalDateTime.now())) {
            System.out.println("verification token is expired");
            return "redirect:/login?error=Verification+token+has+expired";
        }

        AppUser user = verificationToken.getUser();
        user.setVerified(true);
        appUserService.editAppUser(user);

        return "redirect:/login?msg=Your+account+has+been+successfully+verified";
    }
}
