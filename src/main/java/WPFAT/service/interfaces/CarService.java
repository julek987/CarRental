package WPFAT.service.interfaces;

import WPFAT.model.Car;
import java.util.List;

public interface CarService {
    List<Car> getAllCars();
    Car getCarById(Long id);
    List<Car> getAvailableCars();
    Car saveCar(Car car);
    void deleteCar(Long id);
}