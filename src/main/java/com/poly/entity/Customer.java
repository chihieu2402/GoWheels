package com.poly.entity;

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

import java.util.List;

import org.springframework.web.multipart.MultipartFile;


@Entity
@Table(name="Customer")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="CustomerID")
    private int customerID;
    
    @Column(name = "Email", columnDefinition = "VARCHAR(255)", nullable = true)
    private String email;

    @Column(name="CustomerName", columnDefinition = "NVARCHAR(255)")
    private String customerName;

    @Column(name="PhoneNumber")
    private String phoneNumber;

    @Column(name="Address", columnDefinition = "NVARCHAR(255)")
    private String address;

    @Column(name="IDCard")
    private String idCard;

    @Column(name="Gender", columnDefinition = "NVARCHAR(255)")
    private String gender;
    
    @Column(name="AccountID")
    private int accountID;
    

    @Column(name="license")
    private String license;
    
    @Column(name="cccd1")
    private String image1;
    @Column(name="cccd2")
    private String image2;
    @Column(name="gplx")
    private String image3;
    
    // đổi thành dạng khác thử
//    @Column(name="cccd1")
//    private MultipartFile image1;
//    @Column(name="cccd2")
//    private MultipartFile image2;
//    @Column(name="gplx")
//    private MultipartFile image3;


    @OneToMany(mappedBy = "customer")
    private List<Review> review;
    
    @OneToOne(mappedBy = "customer")
    private CarOwner carowner;
    
    @OneToOne
    @JoinColumn(name = "AccountID", insertable = false, updatable = false)
    private Account account;
    
    @OneToMany(mappedBy = "customer")
    private List<Bill> bill;

    @OneToMany(mappedBy = "customer")
    private List<PendingCarPost> pendingCarPosts;
}
