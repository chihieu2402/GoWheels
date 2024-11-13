package com.poly.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "PendingCarPost")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PendingCarPost {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "PostID")
	private int postID;

	@Column(name = "Status")
	private boolean status;

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
	
	@ManyToOne
	@JoinColumn(name = "CustomerID")  // Đảm bảo ánh xạ đúng với CustomerID
	private Customer customer;

	@ManyToOne
	@JoinColumn(name = "CarBrandID")
	@ToString.Exclude
	private CarBrand carBrand;
	
	@OneToOne(mappedBy = "pendingCarPost", cascade = CascadeType.ALL)
	private ImagePending imagePending;


}
