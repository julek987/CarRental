package WPFAT.service.interfaces;

import WPFAT.model.Order;
import WPFAT.model.AppUser;

import java.time.LocalDate;
import java.util.List;

public interface OrderService {
    Order createOrder(Order order);
    Order getOrderById(Long id);
    Order updateOrder(Order order);
    List<Order> getOrdersByUser(AppUser user);
    List<Order> getAllOrders();
    void cancelOrder(Long orderId);
    boolean isCarAvailable(Long carId, LocalDate startDate, LocalDate endDate);
}