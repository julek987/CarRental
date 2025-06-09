package WPFAT.repository;

import WPFAT.model.Order;
import WPFAT.model.AppUser;
import WPFAT.model.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(AppUser user);
    List<Order> findByCarId(Long carId);
    boolean existsByCarIdAndStartDateLessThanEqualAndEndDateGreaterThanEqual(
            Long carId,
            LocalDate endDate,
            LocalDate startDate
    );

    List<Order> findByStatusAndCreatedDateBefore(OrderStatus orderStatus, LocalDateTime cutoff);
}