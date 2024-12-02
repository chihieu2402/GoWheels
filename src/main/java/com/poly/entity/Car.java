package com.poly.entity;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
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
import lombok.ToString;

@Entity
@Table(name = "Car")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Car {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CarID")
    private int carID;

    @Column(name = "CarName", columnDefinition = "NVARCHAR(255)")
    private String carName;

    @Column(name = "CarType")
    private String carType;

    @Column(name = "Color")
    private String color;

    @Column(name = "TypeGear")
    private String type_gear;

    @Column(name = "CarNumber")
    private String car_number;

    @Column(name = "TypeFuel")
    private String type_fuel;

    @Column(name = "YearOfManufacture")
    private int year_of_manufacture;

    @Column(name = "muctieuthu")
    private String muctieuthu;

    @Column(name = "limit")
    private String limit;

    @Column(name = "fee_limit")
    private String fee_limit;

    @Column(name = "location", columnDefinition = "NVARCHAR(255)")
    private String address;

    @Column(name = "describe", columnDefinition = "NVARCHAR(255)")
    private String describe;

    @Column(name = "PriceHoursCar")
    private double priceHoursCar;

    @Column(name = "Status")
    private boolean status;

    @Column(name = "Image", columnDefinition = "VARCHAR(MAX)")
    private List<String> images = new ArrayList<>();

    @Column(name = "OwnershipDocument", columnDefinition = "VARCHAR(MAX)")
    private List<String> ownershipDocuments = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "ReviewID")
    private Review review;

    @OneToMany(mappedBy = "car")
    private List<BillDetail> billDetail;

    @ManyToOne
    @JoinColumn(name = "OwnerID")
    private CarOwner carOwner;

    @ManyToOne
    @JoinColumn(name = "CarBrandID")
    private CarBrand carBrand;

    @OneToMany(mappedBy = "car")
    @ToString.Exclude    
    private List<Booking> bookings;
    
    @OneToOne
    @JoinColumn(name="license_id")
    private Document doc;
    
    @OneToOne(mappedBy = "car", cascade = CascadeType.ALL)
    private ImageCar imageCar;

}
