package WPFAT.service;

import WPFAT.model.AppUser;
import WPFAT.model.Order;
import WPFAT.model.OrderStatus;
import WPFAT.model.VerificationToken;
import WPFAT.repository.OrderRepository;
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
    private final OrderRepository orderRepository;
    private final AppUserService userService;

    @Autowired
    public CleanupServiceImpl(VerificationTokenRepository tokenRepo, AppUserService userService, OrderRepository orderRepository) {
        this.tokenRepo = tokenRepo;
        this.userService = userService;
        this.orderRepository = orderRepository;
    }

    @Scheduled(fixedRate = 60000)
    @Transactional
    public void deleteUnverifiedUsers() {
        LocalDateTime threshold = LocalDateTime.now().minusMinutes(2);
        List<VerificationToken> expiredTokens = tokenRepo.findAllByUser_VerifiedFalseAndCreatedDateBefore(threshold);

        for (VerificationToken token : expiredTokens) {
            AppUser user = token.getUser();
            tokenRepo.delete(token);
            userService.deleteAppUser(user.getId());
        }
    }

    @Scheduled(fixedRate = 60000)
    @Transactional
    public void deleteUnpaidOrders() {
        LocalDateTime cutoff = LocalDateTime.now().minusMinutes(2);
        List<Order> expiredOrders = orderRepository.findByStatusAndCreatedDateBefore(OrderStatus.PENDING, cutoff);
        for (Order order : expiredOrders) {
            orderRepository.delete(order);
        }
    }
}
