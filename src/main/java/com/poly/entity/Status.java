//package com.poly.entity;
//
//import java.util.List;
//
//import com.fasterxml.jackson.annotation.JsonIgnore;
//
//import jakarta.persistence.Column;
//import jakarta.persistence.Entity;
//import jakarta.persistence.Id;
//import jakarta.persistence.OneToMany;
//import jakarta.persistence.Table;
//import lombok.AllArgsConstructor;
//import lombok.Data;
//import lombok.NoArgsConstructor;
//import lombok.ToString;
//
//@Entity
//@Table(name = "Status")
//@Data
//@AllArgsConstructor
//@NoArgsConstructor
//public class Status {
//
//	@Id
//	@Column(name = "Status_id")
//	private int id;
//	
//	@Column(name = "Type")
//	private String type;
//	
//	@Column(name = "Name")
//	private String name;
//	
//	@OneToMany(mappedBy = "status")
//	@ToString.Exclude
//	@JsonIgnore
//	private List<Car> cars;
//}
