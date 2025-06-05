package WPFAT.controller;

import WPFAT.model.Order;
import WPFAT.model.OrderStatus;
import WPFAT.model.PaymentMethod;
import WPFAT.service.interfaces.EmailService;
import WPFAT.service.interfaces.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/payments")
public class PaymentController {

    private final OrderService orderService;
    private final EmailService emailService;

    @Autowired
    public PaymentController(OrderService orderService, EmailService emailService) {
        this.orderService = orderService;
        this.emailService = emailService;
    }

    @GetMapping("/{orderId}")
    public String showPaymentForm(@PathVariable Long orderId, Model model) {
        model.addAttribute("orderId", orderId);
        return "payment-method";
    }

    @PostMapping("/process")
    public String processPayment(@RequestParam Long orderId,
                                 @RequestParam PaymentMethod paymentMethod,
                                 @RequestParam(required = false) String blikCode,
                                 @RequestParam(required = false) String cardNumber,
                                 @RequestParam(required = false) String expiryDate,
                                 @RequestParam(required = false) String cvv,
                                 Model model) {

        Order order = orderService.getOrderById(orderId);
        order.setPaymentMethod(paymentMethod);
        order.setStatus(OrderStatus.CONFIRMED);
        orderService.updateOrder(order);

        String emailContent = String.format(
                "Your order has been confirmed.\n\n" +
                        "Car: %s %s\n" +
                        "Dates: %s to %s\n" +
                        "Total Price: $%.2f\n" +
                        "Payment Method: %s",
                order.getCar().getBrand(),
                order.getCar().getModel(),
                order.getStartDate(),
                order.getEndDate(),
                order.getTotalPrice(),
                paymentMethod
        );

        emailService.SendEmail(
                order.getUser().getEmail(),
                "Your Car Rental Confirmation",
                emailContent
        );

        return "redirect:/payments/success?orderId=" + orderId;
    }

    @GetMapping("/success")
    public String paymentSuccess(@RequestParam Long orderId, Model model) {
        Order order = orderService.getOrderById(orderId);
        model.addAttribute("order", order);
        model.addAttribute("startDate", java.sql.Date.valueOf(order.getStartDate()));
        model.addAttribute("endDate", java.sql.Date.valueOf(order.getEndDate()));
        return "payment-success";
    }
}
