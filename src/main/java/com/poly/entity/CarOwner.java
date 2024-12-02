 package com.poly.entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="CarOwner")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CarOwner {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OwnerID")
    private int ownerID;

    @Column(name="CustomerID")
    private int customerID;
 
    @Column(name="CustomerName")
    private String customerName; // Thêm thuộc tính để lưu tên người cho thuê

    @OneToOne
    @JoinColumn(name = "CustomerID", insertable = false, updatable = false)
    private Customer customer;
    
    @OneToMany(mappedBy = "carOwner")
    private List<Car> car;
}
