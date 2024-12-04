package com.poly.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="Document")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Document {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "license_id")
    private int licenseID;
	
	@Column(name="gtx")
	private String gtx;
	
	@Column(name="BHX")
	private String bhx;
	
	@OneToOne(mappedBy="doc")
	private Car carID;
	
	
}
