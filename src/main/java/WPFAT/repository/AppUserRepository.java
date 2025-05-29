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
    List<AppUser> findByLogin(String login);

    AppUser findById(long id);

    // New method for filtering users by login (containing) and role
    List<AppUser> findByLoginContainingIgnoreCaseAndRole(String login, UserRole role);

    // Optional convenience method: filter only by login if role is null/empty
    List<AppUser> findByLoginContainingIgnoreCase(String login);

    // Optional convenience method: filter only by role if login is null/empty
    List<AppUser> findByRole(UserRole role);
}
