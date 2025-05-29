package WPFAT.service;

import WPFAT.model.AppUser;
import WPFAT.repository.AppUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AppUserServiceImpl implements AppUserService {

    private AppUserRepository appUserRepository;

    @Autowired
    public AppUserServiceImpl(AppUserRepository appUserRepository) {
        this.appUserRepository = appUserRepository;
    }

    @Transactional
    public void addAppUser(AppUser appUser) {
        appUserRepository.save(appUser);
    }

    @Transactional
    public void editAppUser(AppUser appUser) {
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
    public List<AppUser> listAppUsers() {
        return appUserRepository.findAll();
    }
}
