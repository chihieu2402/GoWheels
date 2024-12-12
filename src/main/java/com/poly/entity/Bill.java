package com.poly.entity;

import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="Bill")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Bill {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "BillID")
    private int billID;

    @Column(name="CustomerName",columnDefinition = "NVARCHAR(255)")
    private String customerName;

    @Column(name="RentalDay")
    private LocalDate rentalDay;

    @Column(name="ReturnDay")
    private LocalDate returnDay;
    
    @Column(name="TotalPrice")
    private double totalPrice;
    
    @Column(name="Status")
    private Boolean status;

    @ManyToOne
    @JoinColumn(name = "CustomerID")
    private Customer customer;
    
    @OneToMany(mappedBy = "bill")
    private List<BillDetail> billDetail;
    
    @OneToOne(mappedBy = "bill")
    private Payment payment;
}
