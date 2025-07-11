package WPFAT.controller;

import WPFAT.model.CalendarDay;
import WPFAT.model.Car;
import WPFAT.service.interfaces.CarService;
import WPFAT.service.interfaces.PickupLocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.Comparator;

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
            @RequestParam(required = false) String sort,
            Model modelView) {

        List<Car> availableCars = carService.getAvailableCars();

        // Apply filters
        if (brand != null && !brand.isEmpty()) {
            availableCars = availableCars.stream()
                    .filter(car -> car.getBrand().equalsIgnoreCase(brand))
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

        // Apply sorting
        if (sort != null && !sort.isEmpty()) {
            availableCars = sortCars(availableCars, sort);
        }

        modelView.addAttribute("cars", availableCars);
        modelView.addAttribute("brands", carService.getAllCars().stream()
                .map(Car::getBrand)
                .distinct()
                .toList());

        return "car-list";
    }

    private List<Car> sortCars(List<Car> cars, String sortOption) {
        return switch (sortOption) {
            case "brand_asc" -> cars.stream()
                    .sorted(Comparator.comparing(Car::getBrand, String.CASE_INSENSITIVE_ORDER))
                    .toList();
            case "brand_desc" -> cars.stream()
                    .sorted(Comparator.comparing(Car::getBrand, String.CASE_INSENSITIVE_ORDER).reversed())
                    .toList();
            case "price_asc" -> cars.stream()
                    .sorted(Comparator.comparing(Car::getDailyCost))
                    .toList();
            case "price_desc" -> cars.stream()
                    .sorted(Comparator.comparing(Car::getDailyCost).reversed())
                    .toList();
            case "year_asc" -> cars.stream()
                    .sorted(Comparator.comparing(Car::getYear))
                    .toList();
            case "year_desc" -> cars.stream()
                    .sorted(Comparator.comparing(Car::getYear).reversed())
                    .toList();
            default -> cars;
        };
    }

    @GetMapping("/{id}")
    public String showCarDetails(
            @PathVariable Long id,
            @RequestParam(required = false, defaultValue = "0") int monthOffset,
            @RequestParam(required = false) LocalDate startDate,
            @RequestParam(required = false) LocalDate endDate,
            Model model) {

        Car car = carService.getCarById(id);
        LocalDate today = LocalDate.now();
        LocalDate currentMonth = today.plusMonths(monthOffset);
        LocalDate maxDate = today.plusMonths(3);

        // Ensure start date is before end date
        if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
            // Swap them if they're in wrong order
            LocalDate temp = startDate;
            startDate = endDate;
            endDate = temp;
        }

        // Generate calendar data for the current month
        List<CalendarDay> calendarDays = generateCalendarDays(currentMonth, car);

        // Calculate days between if both dates are present
        Long daysBetween = null;
        if (startDate != null && endDate != null) {
            daysBetween = ChronoUnit.DAYS.between(startDate, endDate);
        }

        model.addAttribute("car", car);
        model.addAttribute("today", today);
        model.addAttribute("currentMonth", currentMonth);
        model.addAttribute("monthOffset", monthOffset);
        model.addAttribute("maxDate", maxDate);
        model.addAttribute("locations", pickupLocationService.getAllActiveLocations());
        model.addAttribute("calendarDays", calendarDays);
        model.addAttribute("selectedStartDate", startDate);
        model.addAttribute("selectedEndDate", endDate);
        model.addAttribute("daysBetween", daysBetween);

        return "car-order";
    }

    private List<CalendarDay> generateCalendarDays(LocalDate month, Car car) {
        List<CalendarDay> days = new ArrayList<>();
        List<LocalDate> bookedDates = carService.getBookedDatesForCar(car.getId());
        LocalDate today = LocalDate.now();

        // Get the first day of the month
        LocalDate firstDayOfMonth = month.withDayOfMonth(1);

        // Find out how many days from previous month we need to show
        int daysFromPrevMonth = firstDayOfMonth.getDayOfWeek().getValue() % 7; // Sunday=0

        // Start from the first day to show in calendar (might be from previous month)
        LocalDate currentDate = firstDayOfMonth.minusDays(daysFromPrevMonth);

        // Generate exactly 6 weeks of calendar data (42 days - covers all cases)
        for (int i = 0; i < 42; i++) {
            LocalDate date = currentDate.plusDays(i);
            boolean isPastDate = date.isBefore(today);
            boolean isBooked = bookedDates.contains(date);
            boolean isAvailable = !isPastDate && !isBooked;
            boolean isToday = date.equals(today);
            boolean isCurrentMonth = date.getMonth() == month.getMonth();

            days.add(new CalendarDay(
                    date.getDayOfMonth(),
                    date,
                    date.getDayOfWeek().getValue() % 7, // Sunday=0
                    isAvailable,
                    isToday,
                    isCurrentMonth
            ));
        }

        return days;
    }

    @GetMapping("/admin/manage")
    public String manageCars(
            @RequestParam(required = false) String brand,
            @RequestParam(required = false) String sort,
            Model model) {

        List<Car> cars = carService.getAllCars();

        if (brand != null && !brand.isEmpty()) {
            cars = cars.stream()
                    .filter(car -> car.getBrand().equalsIgnoreCase(brand))
                    .toList();
        }

        if (sort != null && !sort.isEmpty()) {
            cars = sortCars(cars, sort);
        }

        model.addAttribute("cars", cars);
        model.addAttribute("brands", carService.getAllCars().stream()
                .map(Car::getBrand)
                .filter(b -> b != null && !b.isBlank())
                .distinct()
                .sorted(String.CASE_INSENSITIVE_ORDER)
                .toList());

        return "adminPanel/admin-panel-cars";
    }

    @GetMapping("/manager")
    public String manageCars2(
            @RequestParam(required = false) String brand,
            @RequestParam(required = false) String sort,
            Model model) {

        List<Car> cars = carService.getAllCars();

        if (brand != null && !brand.isEmpty()) {
            cars = cars.stream()
                    .filter(car -> car.getBrand().equalsIgnoreCase(brand))
                    .toList();
        }

        if (sort != null && !sort.isEmpty()) {
            cars = sortCars(cars, sort);
        }

        model.addAttribute("cars", cars);
        model.addAttribute("brands", carService.getAllCars().stream()
                .map(Car::getBrand)
                .filter(b -> b != null && !b.isBlank())
                .distinct()
                .sorted(String.CASE_INSENSITIVE_ORDER)
                .toList());

        return "managerPanel/manager-panel-cars";
    }


    @GetMapping("/admin/edit/{id}")
    public String editCarForm(@PathVariable Long id, Model model) {
        Car car = carService.getCarById(id);
        model.addAttribute("car", car);
        return "adminPanel/admin-panel-car-edit";
    }
    @GetMapping("/manager/edit/{id}")
    public String editCarFormManager(@PathVariable Long id, Model model) {
        Car car = carService.getCarById(id);
        model.addAttribute("car", car);
        return "managerPanel/manager-panel-car-edit";
    }

    @PostMapping("/admin/edit")
    public String updateCar(@ModelAttribute Car car) {
        carService.saveCar(car);
        return "redirect:/cars/admin/manage";
    }

    @PostMapping("/manager/edit")
    public String updateCar2(@ModelAttribute Car car) {
        carService.saveCar(car);
        return "redirect:/cars/manager";
    }

    @GetMapping("/admin/add")
    public String addCarForm(Model model) {
        model.addAttribute("car", new Car());
        return "adminPanel/admin-panel-car-edit";
    }

    @GetMapping("/manager/add")
    public String addCarFormManager(Model model) {
        model.addAttribute("car", new Car());
        return "managerPanel/manager-panel-car-edit";
    }

    @GetMapping("/delete/{id}")
    public String deleteCar(@PathVariable Long id) {
        carService.deleteCarById(id);
        return "redirect:/cars/admin/manage";
    }

}