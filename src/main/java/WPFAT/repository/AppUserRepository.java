package WPFAT.repository;

import WPFAT.model.AppUser;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Transactional
@Repository
public interface AppUserRepository extends JpaRepository<AppUser, Long> {
    List<AppUser> findByLogin(String login);
    AppUser findById(long id);
}
