package WPFAT.service;

import WPFAT.model.AppUser;
import WPFAT.model.enums.UserRole;
import WPFAT.service.interfaces.AppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class MyAppUserDetailsService implements UserDetailsService {

    private AppUserService appUserService;

    @Autowired
    public MyAppUserDetailsService(AppUserService appUserService) {
        this.appUserService = appUserService;
    }

    @Transactional(readOnly = true)
    @Override
    public UserDetails loadUserByUsername(final String login) throws UsernameNotFoundException {
        AppUser appUser = appUserService.getAppUserByLogin(login);
        if (appUser == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return User.builder()
                .username(appUser.getLogin())
                .password(appUser.getPassword())
                .roles(appUser.getRole().name())
                .build();
    }

    private User buildUserForAuthentication(AppUser appUser, List<GrantedAuthority> authorities) {
        return new User(appUser.getLogin(), appUser.getPassword(), authorities);
    }

    private List<GrantedAuthority> buildUserAuthority(UserRole userRole) {
        return List.of(new SimpleGrantedAuthority(userRole.name()));
    }
}
