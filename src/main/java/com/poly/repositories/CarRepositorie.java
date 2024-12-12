package com.poly.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.poly.entity.Car;

public interface CarRepositorie extends  CrudRepository <Car, Integer>{
	 @Query("SELECT COUNT(c) FROM Car c")
	    long countCar();

}
