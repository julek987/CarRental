package WPFAT.service;

import WPFAT.model.AppUser;
import WPFAT.model.Car;
import WPFAT.model.Order;
import WPFAT.service.interfaces.PdfService;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Service
public class PdfServiceImpl implements PdfService {

    private static final Font TITLE_FONT = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
    private static final Font HEADER_FONT = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
    private static final Font NORMAL_FONT = new Font(Font.FontFamily.HELVETICA, 10);
    private static final Font HIGHLIGHT_FONT = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.BLUE);

    @Override
    public void generatePdfToResponse(Car car, Order order, AppUser appUser, HttpServletResponse response) throws IOException {
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=" + appUser.getLogin() + "_order_" + order.getId() + ".pdf");

            OutputStream outputStream = response.getOutputStream();
            generatePdfContent(car, order, appUser, outputStream);
            outputStream.close();
        } catch (DocumentException e) {
            throw new IOException("Failed to generate PDF", e);
        }
    }

    @Override
    public ByteArrayOutputStream generatePdfToStream(Car car, Order order, AppUser appUser) throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        try {
            generatePdfContent(car, order, appUser, outputStream);
            return outputStream;
        } catch (DocumentException e) {
            throw new IOException("Failed to generate PDF", e);
        }
    }

    private void generatePdfContent(Car car, Order order, AppUser appUser, OutputStream outputStream)
            throws DocumentException, IOException {
        Document document = new Document(PageSize.A4, 36, 36, 36, 36);
        PdfWriter.getInstance(document, outputStream);
        document.open();

        // Add title
        Paragraph title = new Paragraph("Car Rental Confirmation", TITLE_FONT);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);

        // Add order information section
        document.add(createSectionHeader("Order Information"));
        document.add(createKeyValueTable(
                new String[]{"Order ID:", "Status:", "Order Date:"},
                new String[]{
                        order.getId().toString(),
                        order.getStatus().toString(),
                        LocalDate.now().format(DateTimeFormatter.ISO_DATE)
                }
        ));

        // Add user information section
        document.add(createSectionHeader("Customer Information"));
        document.add(createKeyValueTable(
                new String[]{"Name:", "Email:", "Phone:", "Customer ID:"},
                new String[]{
                        appUser.getFirstName() + " " + appUser.getLastName(),
                        appUser.getEmail(),
                        appUser.getTelephone(),
                        appUser.getId().toString()
                }
        ));

        // Add car information section
        document.add(createSectionHeader("Vehicle Information"));
        document.add(createKeyValueTable(
                new String[]{"Make & Model:", "Year:", "License Plate:", "Color:", "Daily Rate:"},
                new String[]{
                        car.getBrand() + " " + car.getModel(),
                        car.getYear().toString(),
                        car.getLicensePlate(),
                        car.getColor(),
                        String.format("$%.2f", car.getDailyCost())
                }
        ));

        // Add rental details section
        document.add(createSectionHeader("Rental Details"));
        document.add(createKeyValueTable(
                new String[]{"Pickup Date:", "Return Date:", "Total Days:", "Pickup Location:", "Return Location:", "Total Price:"},
                new String[]{
                        order.getStartDate().format(DateTimeFormatter.ISO_DATE),
                        order.getEndDate().format(DateTimeFormatter.ISO_DATE),
                        String.valueOf(java.time.temporal.ChronoUnit.DAYS.between(order.getStartDate(), order.getEndDate())),
                        order.getPickupLocation().getCity() + ", " + order.getPickupLocation().getAddress(),
                        order.getReturnLocation().getCity() + ", " + order.getReturnLocation().getAddress(),
                        String.format("$%.2f", order.getTotalPrice())
                }
        ));

        // Add payment method section
        if (order.getPaymentMethod() != null) {
            document.add(createSectionHeader("Payment Information"));
            document.add(createKeyValueTable(
                    new String[]{"Payment Method:", "Amount Paid:"},
                    new String[]{
                            order.getPaymentMethod().toString(),
                            String.format("$%.2f", order.getTotalPrice())
                    }
            ));
        }

        // Add footer
        Paragraph footer = new Paragraph("Thank you for choosing our car rental service!", NORMAL_FONT);
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(20);
        document.add(footer);

        document.close();
    }

    private Paragraph createSectionHeader(String text) {
        Paragraph header = new Paragraph(text, HEADER_FONT);
        header.setSpacingBefore(15);
        header.setSpacingAfter(5);
        return header;
    }

    private PdfPTable createKeyValueTable(String[] keys, String[] values) throws DocumentException {
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setWidths(new int[]{1, 2});

        // Remove table border
        table.getDefaultCell().setBorder(Rectangle.NO_BORDER);

        for (int i = 0; i < keys.length; i++) {
            // Key cell
            PdfPCell keyCell = new PdfPCell(new Phrase(keys[i], NORMAL_FONT));
            keyCell.setBorder(Rectangle.NO_BORDER);
            table.addCell(keyCell);

            // Value cell
            PdfPCell valueCell = new PdfPCell(new Phrase(values[i], HIGHLIGHT_FONT));
            valueCell.setBorder(Rectangle.NO_BORDER);
            table.addCell(valueCell);
        }

        return table;
    }
}