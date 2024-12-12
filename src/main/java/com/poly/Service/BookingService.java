package com.poly.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.poly.dao.BookingDao;
import com.poly.dao.BillDao; // Assuming you have a BillDao for Bill entity
import com.poly.entity.Bill;
import com.poly.entity.Booking;

import java.util.Optional;

@Service
public class BookingService {

    private static final Logger logger = LoggerFactory.getLogger(BookingService.class);

    @Autowired
    private BookingDao bookingRepository;

    @Autowired
    private BillDao billRepository;

    // Approve a booking and create a corresponding Bill
    public void approveBooking(int bookingID) {
        Optional<Booking> optionalBooking = bookingRepository.findById(bookingID);
        
        if (optionalBooking.isPresent()) {
            Booking booking = optionalBooking.get();

            // Check for existing Bill and delete it if present
            Optional<Bill> existingBill = billRepository.findById(booking.getBookingID()); // Assuming Booking has a reference to Bill ID
            if (existingBill.isPresent()) {
                billRepository.delete(existingBill.get()); // Delete the existing Bill
                logger.info("Deleted existing bill ID: {}", existingBill.get().getBillID());
            }

            // Create a new Bill object from booking details
            Bill bill = createBillFromBooking(booking);
            billRepository.save(bill); // Save the new Bill to the database

            // Log the creation of the new bill
            logger.info("Created new bill ID: {}", bill.getBillID());

            // Delete the booking after creating the bill
            bookingRepository.delete(booking); // Delete the booking from the repository
            logger.info("Approved and deleted booking ID: {}", bookingID);
        } else {
            logger.warn("Attempted to approve a non-existent booking with ID: {}", bookingID);
            throw new IllegalArgumentException("Invalid booking ID: " + bookingID);
        }
    }

    // Helper method to create a Bill from a Booking
    private Bill createBillFromBooking(Booking booking) {
        Bill bill = new Bill();
        bill.setCustomerName(booking.getCustomerName());
        bill.setRentalDay(booking.getRentalDay());
        bill.setReturnDay(booking.getReturnDay());
        bill.setTotalPrice(booking.getTotalPrice());
        bill.setStatus(true); // Set status as approved
        
        return bill; // Return the newly created Bill
    }

    public void rejectBooking(int bookingID) {
        Optional<Booking> optionalBooking = bookingRepository.findById(bookingID);
        
        if (optionalBooking.isPresent()) {
            Booking booking = optionalBooking.get();
            bookingRepository.delete(booking); // Delete the booking from the repository
            
            logger.info("Rejected booking ID: {}", bookingID);
        } else {
            logger.warn("Attempted to reject a non-existent booking with ID: {}", bookingID);
            throw new IllegalArgumentException("Invalid booking ID: " + bookingID);
        }
    }
}
