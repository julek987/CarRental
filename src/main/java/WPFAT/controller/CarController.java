package WPFAT.controller;

import WPFAT.model.Car;
import WPFAT.service.interfaces.CarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/cars")
public class CarController {

    private final CarService carService;

    @Autowired
    public CarController(CarService carService) {
        this.carService = carService;
    }

    // Main page - Show available cars with filters
    @GetMapping
    public String showAvailableCars(
            @RequestParam(required = false) String brand,
            @RequestParam(required = false) String model,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            Model modelView) {

        List<Car> availableCars = carService.getAvailableCars();

        // Apply filters if provided
        if (brand != null && !brand.isEmpty()) {
            availableCars = availableCars.stream()
                    .filter(car -> car.getBrand().equalsIgnoreCase(brand))
                    .toList();
        }

        if (model != null && !model.isEmpty()) {
            availableCars = availableCars.stream()
                    .filter(car -> car.getModel().equalsIgnoreCase(model))
                    .toList();
        }

        if (minPrice != null) {
            availableCars = availableCars.stream()
                    .filter(car -> car.getDailyCost() >= minPrice)
                    .toList();
        }

        if (maxPrice != null) {
            availableCars = availableCars.stream()
                    .filter(car -> car.getDailyCost() <= maxPrice)
                    .toList();
        }

        modelView.addAttribute("cars", availableCars);
        modelView.addAttribute("brands", carService.getAllCars().stream()
                .map(Car::getBrand)
                .distinct()
                .toList());

        return "car-list";
    }

    // Show car details and reservation form
    @GetMapping("/{id}")
    public String showCarDetails(@PathVariable Long id, Model model) {
        Car car = carService.getCarById(id);
        model.addAttribute("car", car);
        model.addAttribute("today", LocalDate.now());
        model.addAttribute("maxDate", LocalDate.now().plusMonths(3)); // Allow booking up to 3 months ahead
        return "car-details";
    }
}