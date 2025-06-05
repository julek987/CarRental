package WPFAT.controller;

import WPFAT.model.*;
import WPFAT.service.interfaces.AppUserService;
import WPFAT.service.interfaces.CarService;
import WPFAT.service.interfaces.OrderService;
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

    @Autowired
    public OrderController(OrderService orderService,
                           CarService carService,
                           AppUserService appUserService) {
        this.orderService = orderService;
        this.carService = carService;
        this.appUserService = appUserService;
    }

    @PostMapping
    public String createOrder(@RequestParam Long carId,
                              @RequestParam LocalDate startDate,
                              @RequestParam LocalDate endDate,
                              Principal principal,
                              RedirectAttributes redirectAttributes) {

        AppUser user = appUserService.getAppUserByLogin(principal.getName());
        Car car = carService.getCarById(carId);

        Order order = new Order();
        order.setUser(user);
        order.setCar(car);
        order.setStartDate(startDate);
        order.setEndDate(endDate);

        Order savedOrder = orderService.createOrder(order);
        redirectAttributes.addFlashAttribute("order", savedOrder);

        return "redirect:/orders/success";
    }

    @GetMapping("/success")
    public String orderSuccess(Model model) {
        Order order = (Order) model.getAttribute("order");
        if (order != null) {
            model.addAttribute("startDate", java.sql.Date.valueOf(order.getStartDate()));
            model.addAttribute("endDate", java.sql.Date.valueOf(order.getEndDate()));
        }
        return "order-success";
    }
}