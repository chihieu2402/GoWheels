package com.poly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; // Importing Controller annotation
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.poly.Service.BookingService; // Import your BookingService
import com.poly.entity.Booking;
import org.slf4j.Logger; // Importing SLF4J Logger for logging
import org.slf4j.LoggerFactory;

@Controller // Annotating the class as a Spring Controller
public class ManegerBookingController {

    private static final Logger logger = LoggerFactory.getLogger(ManegerBookingController.class); // Logger for this class

    @Autowired
    private BookingService bookingService; // Injecting BookingService

    @PostMapping("/admin/approveBooking")
    public String approveBooking(@RequestParam("bookingID") int bookingID, RedirectAttributes redirectAttributes) {
        try {
            bookingService.approveBooking(bookingID); // Call service method to approve and create Bill
            redirectAttributes.addFlashAttribute("message", "Booking approved successfully!");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            logger.error("Error approving booking: {}", e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An unexpected error occurred while approving the booking.");
            logger.error("Unexpected error while approving booking ID {}: {}", bookingID, e.getMessage());
        }

        return "redirect:/admin/BookingCar";
    }

    @PostMapping("/admin/rejectBooking")
    public String rejectBooking(@RequestParam("bookingID") int bookingID, RedirectAttributes redirectAttributes) {
        try {
            bookingService.rejectBooking(bookingID); // Call service method to reject the Booking
            redirectAttributes.addFlashAttribute("message", "Booking rejected successfully!");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            logger.error("Error rejecting booking: {}", e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An unexpected error occurred while rejecting the booking.");
            logger.error("Unexpected error while rejecting booking ID {}: {}", bookingID, e.getMessage());
        }

        return "redirect:/admin/BookingCar";
    }
}
