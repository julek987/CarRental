package WPFAT.service;

import WPFAT.model.AppUser;

import java.util.List;

public interface AppUserService {

    public void addAppUser(AppUser appUser);
    public void editAppUser(AppUser appUser);
    public void deleteAppUser(long id);
    public AppUser getAppUserById(long id);
    public List<AppUser> listAppUsers();
    List<AppUser> listAppUsersByLoginAndRole(String login, String role);
}
