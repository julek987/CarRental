package WPFAT.repository;

import WPFAT.model.AppUser;
import WPFAT.model.UserRole;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Transactional
@Repository
public interface AppUserRepository extends JpaRepository<AppUser, Long> {
    AppUser findByLogin(String login);

    AppUser findById(long id);

    List<AppUser> findByLoginContainingIgnoreCaseAndRole(String login, UserRole role);

    List<AppUser> findByLoginContainingIgnoreCase(String login);

    List<AppUser> findByRole(UserRole role);
}
