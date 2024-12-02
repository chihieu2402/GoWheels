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
    public String submitBooking(@ModelAttribute Booking booking, RedirectAttributes redirectAttributes, @RequestParam int carID, Model model) {
        booking.setStatus(false); // Set to false initially until approved by admin
        Car car = carRepository.findById(carID).orElse(null);
        // Calculate total price based on rental days (e.g., price per day is 100)
        long daysBetween = ChronoUnit.DAYS.between(booking.getRentalDay(), booking.getReturnDay());
        double pricePerDay = car.getPriceHoursCar(); // Assume a price per day
        booking.setTotalPrice(daysBetween * pricePerDay);

        bookingRepository.save(booking);

        // Add the booking object to the redirect attributes
        redirectAttributes.addFlashAttribute("booking", booking);
        model.addAttribute("mes", "Đã gửi yêu cầu!");

        // Redirect to the booking post page after submission
       // return "forward:/booking/views/Booking";
        return "redirect:payment";
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
    
    
    @GetMapping("/confim")
    private String pulblic() {
		return "views/ConfimBooking";

	}
}
