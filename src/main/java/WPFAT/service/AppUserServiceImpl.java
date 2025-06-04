package WPFAT.service;

import WPFAT.model.AppUser;
import WPFAT.model.UserRole;
import WPFAT.repository.AppUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AppUserServiceImpl implements AppUserService {

    private final AppUserRepository appUserRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public AppUserServiceImpl(AppUserRepository appUserRepository,  PasswordEncoder passwordEncoder) {
        this.appUserRepository = appUserRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    public void addAppUser(AppUser appUser) {
        appUser.setRole(UserRole.USER);
        appUser.setPassword(passwordEncoder.encode(appUser.getPassword()));
        appUserRepository.save(appUser);
    }

    @Transactional
    public void editAppUser(AppUser appUser) {
        appUser.setPassword(passwordEncoder.encode(appUser.getPassword()));
        appUserRepository.save(appUser);
    }

    @Transactional
    public void deleteAppUser(long id) {
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
}
