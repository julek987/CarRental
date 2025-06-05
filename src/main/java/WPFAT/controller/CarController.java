package WPFAT.controller;

import WPFAT.model.Car;
import WPFAT.service.interfaces.CarService;
import WPFAT.service.interfaces.PickupLocationService;
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
    private final PickupLocationService pickupLocationService;

    @Autowired
    public CarController(CarService carService,  PickupLocationService pickupLocationService) {
        this.carService = carService;
        this.pickupLocationService = pickupLocationService;
    }

    @GetMapping
    public String showAvailableCars(
            @RequestParam(required = false) String brand,
            @RequestParam(required = false) String model,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            Model modelView) {

        List<Car> availableCars = carService.getAvailableCars();

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

    @GetMapping("/{id}")
    public String showCarDetails(@PathVariable Long id, Model model) {
        Car car = carService.getCarById(id);
        model.addAttribute("car", car);
        model.addAttribute("today", LocalDate.now());
        model.addAttribute("maxDate", LocalDate.now().plusMonths(3));
        model.addAttribute("locations", pickupLocationService.getAllActiveLocations());
        return "car-details";
    }
}