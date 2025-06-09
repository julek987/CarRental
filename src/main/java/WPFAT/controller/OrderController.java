package WPFAT.controller;

import WPFAT.model.*;
import WPFAT.model.enums.OrderStatus;
import WPFAT.service.interfaces.AppUserService;
import WPFAT.service.interfaces.CarService;
import WPFAT.service.interfaces.OrderService;
import WPFAT.service.interfaces.PickupLocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.time.LocalDate;

@Controller
@RequestMapping("/orders")
public class OrderController {

    private final OrderService orderService;
    private final CarService carService;
    private final AppUserService appUserService;
    private final PickupLocationService pickupLocationService;

    @Autowired
    public OrderController(OrderService orderService,
                           CarService carService,
                           AppUserService appUserService,
                           PickupLocationService pickupLocationService) {
        this.orderService = orderService;
        this.carService = carService;
        this.appUserService = appUserService;
        this.pickupLocationService = pickupLocationService;
    }

    @GetMapping("/create/{carId}")
    public String showOrderForm(@PathVariable Long carId, Model model) {
        model.addAttribute("car", carService.getCarById(carId));
        model.addAttribute("locations", pickupLocationService.getAllActiveLocations());
        model.addAttribute("today", LocalDate.now());
        model.addAttribute("maxDate", LocalDate.now().plusMonths(3));
        return "car-order";
    }

    @PostMapping
    public String createOrder(@RequestParam Long carId,
                              @RequestParam LocalDate startDate,
                              @RequestParam LocalDate endDate,
                              @RequestParam Long pickupLocationId,
                              @RequestParam Long returnLocationId,
                              Principal principal,
                              RedirectAttributes redirectAttributes) {

        AppUser user = appUserService.getAppUserByLogin(principal.getName());
        Car car = carService.getCarById(carId);
        PickupLocation pickupLocation = pickupLocationService.getById(pickupLocationId);
        PickupLocation returnLocation = pickupLocationService.getById(returnLocationId);

        Order order = new Order();
        order.setUser(user);
        order.setCar(car);
        order.setStartDate(startDate);
        order.setEndDate(endDate);
        order.setPickupLocation(pickupLocation);
        order.setReturnLocation(returnLocation);

        Order savedOrder = orderService.createOrder(order);
        return "redirect:/payments/" + savedOrder.getId();
    }

    @GetMapping("/manage")
    public String listOrders(Model model) {
        model.addAttribute("orders", orderService.getAllOrders());
        model.addAttribute("statuses", OrderStatus.values());
        model.addAttribute("locations", pickupLocationService.getAllActiveLocations());
        return "adminPanel/admin-panel-orders";
    }

    @PostMapping("/update")
    public String updateOrder(@RequestParam Long orderId,
                              @RequestParam OrderStatus status,
                              @RequestParam Long pickupLocationId,
                              @RequestParam Long returnLocationId,
                              RedirectAttributes redirectAttributes) {
        Order order = orderService.getOrderById(orderId);
        order.setStatus(status);
        order.setPickupLocation(pickupLocationService.getById(pickupLocationId));
        order.setReturnLocation(pickupLocationService.getById(returnLocationId));
        orderService.updateOrder(order);
        redirectAttributes.addFlashAttribute("message", "Order updated successfully.");
        return "redirect:/orders/manage";
    }

    @PostMapping("/delete/{orderId}")
    public String deleteOrder(@PathVariable Long orderId, RedirectAttributes redirectAttributes) {
        orderService.cancelOrder(orderId);
        redirectAttributes.addFlashAttribute("message", "Order deleted successfully.");
        return "redirect:/orders/manage";
    }

}