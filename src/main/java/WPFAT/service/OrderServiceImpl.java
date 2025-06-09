package WPFAT.service;

import WPFAT.model.Order;
import WPFAT.model.AppUser;
import WPFAT.repository.OrderRepository;
import WPFAT.service.interfaces.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;

    @Autowired
    public OrderServiceImpl(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    @Override
    @Transactional
    public Order createOrder(Order order) {
        // Check if car is available for the selected dates
        if (!isCarAvailable(order.getCar().getId(), order.getStartDate(), order.getEndDate())) {
            throw new IllegalStateException("Car is not available for the selected dates");
        }

        // Calculate total price based on daily rate and days
        long days = ChronoUnit.DAYS.between(order.getStartDate(), order.getEndDate());
        double totalPrice = order.getCar().getDailyCost() * days;
        order.setTotalPrice(totalPrice);

        return orderRepository.save(order);
    }

    @Override
    @Transactional
    public Order updateOrder(Order order) {
        return orderRepository.save(order);
    }

    @Override
    public Order getOrderById(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }

    @Override
    public List<Order> getOrdersByUser(AppUser user) {
        return orderRepository.findByUser(user);
    }

    @Override
    @Transactional
    public void cancelOrder(Long orderId) {
        Order order = getOrderById(orderId);
        orderRepository.delete(order);
    }

    @Override
    public boolean isCarAvailable(Long carId, LocalDate startDate, LocalDate endDate) {
        return !orderRepository.existsByCarIdAndStartDateLessThanEqualAndEndDateGreaterThanEqual(
                carId, endDate, startDate);
    }

    @Override
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

}