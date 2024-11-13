package com.poly.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Entity
@Table(name = "Image_Car")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImageCar {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "vehicle_id")
    private int vehicleId;

    @Column(name = "image1")
    private String image1;

    @Column(name = "image2")
    private String image2;

    @Column(name = "image3")
    private String image3;

    @Column(name = "image4")
    private String image4;

    @Column(name = "Img_OwnershipCertificate1")
    private String imgOwnershipCertificate1;

    @Column(name = "Img_OwnershipCertificate2")
    private String imgOwnershipCertificate2;


    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "car_id")  // Đổi từ "vehicle_id" sang "car_id" hoặc tên khác để tránh xung đột
    private Car car;

}
