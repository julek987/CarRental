package WPFAT.service.interfaces;

import WPFAT.model.AppUser;

import java.util.List;

public interface AppUserService {

    public void addAppUser(AppUser appUser);
    public void editAppUser(AppUser appUser);
    public void deleteAppUser(long id);
    public AppUser getAppUserById(long id);
    public AppUser getAppUserByLogin(String login);
    public List<AppUser> listAppUsers();
    List<AppUser> listAppUsersByLoginAndRole(String login, String role);

    List<AppUser> getUsersByRole(String roleUser);

    boolean getUserByEmail(String email);
}
