package WPFAT.service;

import WPFAT.model.AppUser;
import WPFAT.model.enums.UserRole;
import WPFAT.repository.AppUserRepository;
import WPFAT.repository.OrderRepository;
import WPFAT.repository.VerificationTokenRepository;
import WPFAT.service.interfaces.AppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AppUserServiceImpl implements AppUserService {

    private final AppUserRepository appUserRepository;
    private final PasswordEncoder passwordEncoder;
    private final OrderRepository orderRepository;
    private final VerificationTokenRepository verificationTokenRepository;

    @Autowired
    public AppUserServiceImpl(AppUserRepository appUserRepository, PasswordEncoder passwordEncoder, OrderRepository orderRepository, VerificationTokenRepository verificationTokenRepository) {
        this.appUserRepository = appUserRepository;
        this.passwordEncoder = passwordEncoder;
        this.orderRepository = orderRepository;
        this.verificationTokenRepository = verificationTokenRepository;
    }

    @Transactional
    public void addAppUser(AppUser appUser) {
        appUser.setRole(UserRole.USER);
        appUser.setPassword(passwordEncoder.encode(appUser.getPassword()));
        appUserRepository.save(appUser);
    }

    @Transactional
    public void editAppUser(AppUser appUser) {
        appUserRepository.save(appUser);
    }

    @Transactional
    public void deleteAppUser(long id) {
        verificationTokenRepository.deleteByUserId(id);
        orderRepository.deleteByUserId(id);
        appUserRepository.deleteById(id);
    }


    @Transactional
    public AppUser getAppUserById(long id) {
        return appUserRepository.findById(id);
    }


    @Override
    public AppUser getAppUserByLogin(String login) {
        return appUserRepository.findByLogin(login);
    }

    @Override
    public List<AppUser> listAppUsers() {
        return appUserRepository.findAll();
    }

    @Override
    public List<AppUser> listAppUsersByLoginAndRole(String login, String role) {
        boolean loginIsEmpty = (login == null || login.trim().isEmpty());
        boolean roleIsEmpty = (role == null || role.trim().isEmpty());

        if (!loginIsEmpty && !roleIsEmpty) {
            // Filter by both login and role
            return appUserRepository.findByLoginContainingIgnoreCaseAndRole(login, UserRole.valueOf(role));
        } else if (!loginIsEmpty) {
            // Filter only by login
            return appUserRepository.findByLoginContainingIgnoreCase(login);
        } else if (!roleIsEmpty) {
            // Filter only by role
            return appUserRepository.findByRole(UserRole.valueOf(role));
        } else {
            // No filters, return all users
            return appUserRepository.findAll();
        }
    }

    @Override
    public List<AppUser> getUsersByRole(String roleUser) {
        if (roleUser == null || roleUser.trim().isEmpty()) {
            return List.of();
        }
        UserRole role;
        try {
            role = UserRole.valueOf(roleUser);
        } catch (IllegalArgumentException e) {
            return List.of();
        }
        return appUserRepository.findByRole(role);
    }

    @Override
    public boolean getUserByEmail(String email) {
        return appUserRepository.findByEmail(email).isPresent();
    }


}
