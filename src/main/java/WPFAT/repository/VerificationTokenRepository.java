package WPFAT.repository;

import WPFAT.model.VerificationToken;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface VerificationTokenRepository extends JpaRepository<VerificationToken, Long> {
    VerificationToken findByToken(String token);

    List<VerificationToken> findAllByUser_VerifiedFalseAndCreatedDateBefore(LocalDateTime threshold);
}

