package WPFAT.repository;

import WPFAT.model.Order;
import WPFAT.model.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
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
}