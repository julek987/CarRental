package WPFAT.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

import java.util.List;

@Entity
@Table(name = "car")
public class Car {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @Column(name = "brand", nullable = false)
    private String brand;

    @NotBlank
    @Column(name = "model", nullable = false)
    private String model;

    @NotNull
    @Min(value = 1886, message = "Year must be greater or equal 1886")
    @Max(value = 2100, message = "Year must be realistic")
    @Column(name = "year", nullable = false)
    private Integer year;

    @NotBlank
    @Size(min = 1, max = 15)
    @Column(name = "license_plate", nullable = false, unique = true)
    private String licensePlate;

    @NotBlank
    @Column(name = "color", nullable = false)
    private String color;

    @NotNull
    @PositiveOrZero(message = "Daily cost must be zero or positive")
    @Column(name = "daily_cost", nullable = false)
    private Double dailyCost;

    @Column(name = "available", nullable = false)
    private boolean available = true;

    @Column(name = "image_url")
    private String imageUrl;

    @OneToMany(mappedBy = "car", cascade = CascadeType.ALL)
    private List<Order> orders;



    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String make) {
        this.brand = make;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Double getDailyCost() {
        return dailyCost;
    }

    public void setDailyCost(Double dailyRate) {
        this.dailyCost = dailyRate;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imagePath) {
        this.imageUrl = imagePath;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

}