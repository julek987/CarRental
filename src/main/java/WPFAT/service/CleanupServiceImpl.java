package WPFAT.service;

import WPFAT.model.AppUser;
import WPFAT.model.VerificationToken;
import WPFAT.repository.VerificationTokenRepository;
import WPFAT.service.interfaces.AppUserService;
import WPFAT.service.interfaces.CleanupService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CleanupServiceImpl implements CleanupService {

    private final VerificationTokenRepository tokenRepo;
    private final AppUserService userService;

    @Autowired
    public CleanupServiceImpl(VerificationTokenRepository tokenRepo, AppUserService userService) {
        this.tokenRepo = tokenRepo;
        this.userService = userService;
    }

    @Scheduled(fixedRate = 60000)
    @Transactional
    public void deleteUnverifiedUsers() {
        LocalDateTime threshold = LocalDateTime.now().minusMinutes(5);
        List<VerificationToken> expiredTokens = tokenRepo.findAllByUser_VerifiedFalseAndCreatedDateBefore(threshold);

        for (VerificationToken token : expiredTokens) {
            AppUser user = token.getUser();
            tokenRepo.delete(token);
            userService.deleteAppUser(user.getId());
        }
    }
}
