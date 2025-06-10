package WPFAT.service;

import WPFAT.model.Car;
import WPFAT.model.Order;
import WPFAT.model.enums.OrderStatus;
import WPFAT.repository.CarRepository;
import WPFAT.repository.OrderRepository;
import WPFAT.service.interfaces.CarService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class CarServiceImpl implements CarService {

    private final CarRepository carRepository;
    private final OrderRepository orderRepository;

    @Autowired
    public CarServiceImpl(CarRepository carRepository, OrderRepository orderRepository) {
        this.carRepository = carRepository;
        this.orderRepository = orderRepository;
    }

    @Override
    public List<Car> getAllCars() {
        return carRepository.findAll();
    }

    @Override
    public Car getCarById(Long id) {
        return carRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Car not found"));
    }

    @Override
    public List<Car> getAvailableCars() {
        return carRepository.findByAvailable(true);
    }

    @Override
    public Car saveCar(Car car) {
        return carRepository.save(car);
    }


    @Override
    public void deleteCarById(Long id) {
        Car car = getCarById(id);
        orderRepository.deleteByCarId(id);
        carRepository.delete(car);
    }

    @Transactional
    @Override
    public List<LocalDate> getBookedDatesForCar(Long carId) {
        List<Order> orders = orderRepository.findByCarIdAndStatusIn(
                carId,
                List.of(OrderStatus.CONFIRMED, OrderStatus.PENDING)
        );

        return orders.stream()
                .flatMap(order -> {
                    LocalDate start = order.getStartDate();
                    LocalDate end = order.getEndDate();
                    return Stream.iterate(start, date -> date.plusDays(1))
                            .limit(ChronoUnit.DAYS.between(start, end) + 1);
                })
                .collect(Collectors.toList());
    }

}