package WPFAT.controller;

import WPFAT.model.AppUser;
import WPFAT.service.interfaces.AppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class ManagerRestController {

    private final AppUserService appUserService;

    @Autowired
    public ManagerRestController(AppUserService appUserService) {
        this.appUserService = appUserService;
    }

    @GetMapping("/clients")
    public ResponseEntity<List<AppUser>> getAllClients() {
        List<AppUser> clients = appUserService.getUsersByRole("USER");
        return ResponseEntity.ok(clients);
    }
}
