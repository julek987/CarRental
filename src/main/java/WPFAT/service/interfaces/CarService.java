package WPFAT.service.interfaces;

import WPFAT.model.Car;

import java.time.LocalDate;
import java.util.List;

public interface CarService {
    List<Car> getAllCars();
    Car getCarById(Long id);
    List<Car> getAvailableCars();
    Car saveCar(Car car);
    void deleteCarById(Long id);
    List<LocalDate> getBookedDatesForCar(Long carId);
}