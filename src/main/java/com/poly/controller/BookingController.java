package com.poly.controller;

import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.poly.dao.BookingDao;
import com.poly.dao.CarDao;
import com.poly.entity.Booking;
import com.poly.entity.Car;

import jakarta.servlet.ServletContext;

@Controller
public class BookingController {

    @Autowired
    private BookingDao bookingRepository;
    
    @Autowired
    private CarDao carRepository;
    
    private Booking Tbooking; 
	@Autowired
	ServletContext app;

    @RequestMapping("/booking/views/Booking")
    public String showBookingForm(@RequestParam int carID, Model model) {
    	String path = app.getRealPath("/images/");
        Booking booking = new Booking();
        Car car = carRepository.findById(carID).orElse(null);
        if (car != null) {
            model.addAttribute("car", car);
        } else {
            model.addAttribute("error", "Car not found");
        }
        booking.setCarID(carID);
        model.addAttribute("booking", booking);
        return "views/Booking"; // Trả về view booking form
    }

    @PostMapping("/booking/submit")
    public String submitBooking(
            @ModelAttribute Booking booking,
            @RequestParam int carID,
            Model model) {

        booking.setStatus(false); // Set initial status
        Car car = carRepository.findById(carID).orElse(null);

        // Calculate total price based on rental days
        long daysBetween = ChronoUnit.DAYS.between(booking.getRentalDay(), booking.getReturnDay());
        double pricePerDay = car.getPriceHoursCar(); // Giá thuê mỗi ngày của xe
        booking.setTotalPrice(daysBetween * pricePerDay);

        // Save data in the temporary Tbooking variable
        this.Tbooking = booking;

        model.addAttribute("mes", "Data saved temporarily!");
        return "redirect:/booking/confirm"; // Redirect to the confirmation page
    }
    @GetMapping("/admin/BookingCar")
    @PreAuthorize("hasAuthority('ADMIN')")
    public String showBookingPost(Model model) {
        List<Booking> bookings = bookingRepository.findAll();
        model.addAttribute("bookings", bookings);
        return "views/BookingPost"; // Ensure this path matches your HTML file location
    }

    @PostMapping("/admin/approveBooking")
    public String approveBooking(@RequestParam("bookingID") int bookingID, RedirectAttributes redirectAttributes) {
        Booking booking = bookingRepository.findById(bookingID).orElseThrow(() -> new IllegalArgumentException("Invalid booking ID:" + bookingID));
        booking.setStatus(true); // Approve booking
        bookingRepository.save(booking);

        redirectAttributes.addFlashAttribute("message", "Booking approved successfully!");

        return "redirect:/admin/BookingCar";
    }

    @PostMapping("/admin/rejectBooking")
    public String rejectBooking(@RequestParam("bookingID") int bookingID, RedirectAttributes redirectAttributes) {
        Booking booking = bookingRepository.findById(bookingID).orElseThrow(() -> new IllegalArgumentException("Invalid booking ID:" + bookingID));
        bookingRepository.delete(booking);

        redirectAttributes.addFlashAttribute("message", "Booking rejected successfully!");

        return "redirect:/admin/BookingCar";
    }
    @RequestMapping("/booking/confirm")
    public String showConfirmBooking( Model model) {
//    	String path = app.getRealPath("/images/");
//        Booking booking = new Booking();
//        Car car = carRepository.findById(carID).orElse(null);
//        if (car != null) {
//            model.addAttribute("car", car);
//        } else {
//            model.addAttribute("error", "Car not found");
//        }
//        booking.setCarID(carID);
//        model.addAttribute("booking", booking);
        model.addAttribute("Tbooking", Tbooking); // Add Tbooking to model
        return "views/ConfirmBooking"; // Ensure this matches the name of your Thymeleaf template
    }
    @RequestMapping("/booking/success")
    public String showsuccess( Model model) {
        return "views/success"; // Ensure this matches the name of your Thymeleaf template
    }
    @RequestMapping("/booking/error")
    public String showerror( Model model) {
        return "views/error"; // Ensure this matches the name of your Thymeleaf template
    }
    @PostMapping("/booking/submit2")
    public String submitFinalBooking(RedirectAttributes redirectAttributes, Model model) {
        if (Tbooking == null) {
            model.addAttribute("error", "No booking data available!");
            return "redirect:/booking/error"; // Redirect to form if no data available
        }

        // Save the temporary Tbooking data into the database
        Car car = carRepository.findById(Tbooking.getCarID()).orElse(null);
        if (car != null) {
            Tbooking.setStatus(true); // Set booking status to true (approved)
            // Calculate total price based on rental days
            long daysBetween = ChronoUnit.DAYS.between(Tbooking.getRentalDay(), Tbooking.getReturnDay());
            double pricePerDay = car.getPriceHoursCar(); // Assume a price per day
            Tbooking.setTotalPrice(daysBetween * pricePerDay);

            // Save booking to the database
            bookingRepository.save(Tbooking);

            // Add the booking object to the redirect attributes
            redirectAttributes.addFlashAttribute("booking", Tbooking);
            model.addAttribute("mes", "Booking successfully submitted!");

            // Redirect to the booking post page after submission
            return "redirect:/booking/success";
        } else {
            model.addAttribute("error", "Car not found!");
            return "redirect:/booking/form"; // Redirect to form if car not found
        }

}}
