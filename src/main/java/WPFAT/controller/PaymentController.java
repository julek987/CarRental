package WPFAT.controller;

import WPFAT.model.Order;
import WPFAT.model.OrderStatus;
import WPFAT.model.PaymentMethod;
import WPFAT.service.interfaces.EmailService;
import WPFAT.service.interfaces.OrderService;
import WPFAT.service.interfaces.PdfService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

@Controller
@RequestMapping("/payments")
public class PaymentController {

    private final OrderService orderService;
    private final EmailService emailService;
    private final PdfService pdfService;

    @Autowired
    public PaymentController(OrderService orderService,
                             EmailService emailService,
                             PdfService pdfService) {
        this.orderService = orderService;
        this.emailService = emailService;
        this.pdfService = pdfService;
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
        order = orderService.updateOrder(order);

        try {
            // Generate PDF to memory stream using the new method
            ByteArrayOutputStream pdfStream = pdfService.generatePdfToStream(
                    order.getCar(),
                    order,
                    order.getUser()
            );

            // Prepare email content
            String emailContent = String.format(
                    "Dear %s,\n\n" +
                            "Thank you for your order!\n\n" +
                            "Your rental details:\n" +
                            "Car: %s %s\n" +
                            "Dates: %s to %s\n" +
                            "Total Price: $%.2f\n\n" +
                            "Please find attached your rental confirmation.\n\n" +
                            "Best regards,\n" +
                            "CarRental Team",
                    order.getUser().getFirstName(),
                    order.getCar().getBrand(),
                    order.getCar().getModel(),
                    order.getStartDate(),
                    order.getEndDate(),
                    order.getTotalPrice()
            );

            // Send email with PDF attachment
            String attachmentName = String.format("Rental_Confirmation_%d.pdf", order.getId());
            emailService.sendEmailWithAttachment(
                    order.getUser().getEmail(),
                    emailContent,
                    "Your Car Rental Confirmation #" + order.getId(),
                    attachmentName,
                    pdfStream
            );

        } catch (IOException e) {
            // Fallback to simple email if PDF generation fails
            String errorContent = String.format(
                    "Dear %s,\n\n" +
                            "Thank you for your order!\n\n" +
                            "Your rental details:\n" +
                            "Car: %s %s\n" +
                            "Dates: %s to %s\n" +
                            "Total Price: $%.2f\n\n" +
                            "We couldn't attach your confirmation PDF, but your order is confirmed.\n\n" +
                            "Best regards,\n" +
                            "CarRental Team",
                    order.getUser().getFirstName(),
                    order.getCar().getBrand(),
                    order.getCar().getModel(),
                    order.getStartDate(),
                    order.getEndDate(),
                    order.getTotalPrice()
            );

            emailService.sendEmail(
                    order.getUser().getEmail(),
                    "Your Car Rental Confirmation #" + order.getId(),
                    errorContent
            );
        }

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