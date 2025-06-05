package WPFAT.service.interfaces;

import WPFAT.model.AppUser;
import WPFAT.model.Car;
import WPFAT.model.Order;
import jakarta.servlet.http.HttpServletResponse;

import java.io.ByteArrayOutputStream;
import java.io.IOException;


public interface PdfService {
    void generatePdfToResponse(Car car, Order order, AppUser appUser, HttpServletResponse response) throws IOException;
    ByteArrayOutputStream generatePdfToStream(Car car, Order order, AppUser appUser) throws IOException;
}