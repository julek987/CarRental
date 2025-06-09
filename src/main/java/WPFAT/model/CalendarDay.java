package WPFAT.model;

import java.time.LocalDate;

public class CalendarDay {
    private int dayOfMonth;
    private LocalDate date;
    private int dayOfWeek;
    private boolean available;
    private boolean today;
    private boolean currentMonth;

    public CalendarDay() {
    }

    public CalendarDay(int dayOfMonth, LocalDate localDate, int dayOfWeek, boolean available, boolean today, boolean currentMonth) {
        this.dayOfMonth = dayOfMonth;
        this.date = localDate;
        this.dayOfWeek = dayOfWeek;
        this.available = available;
        this.today = today;
        this.currentMonth = currentMonth;
    }

    public int getDayOfMonth() {
        return dayOfMonth;
    }

    public void setDayOfMonth(int dayOfMonth) {
        this.dayOfMonth = dayOfMonth;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public int getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(int dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public boolean isToday() {
        return today;
    }

    public void setToday(boolean today) {
        this.today = today;
    }

    public boolean isCurrentMonth() {
        return currentMonth;
    }

    public void setCurrentMonth(boolean currentMonth) {
        this.currentMonth = currentMonth;
    }
}
