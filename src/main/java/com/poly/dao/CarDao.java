package com.poly.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.poly.entity.Car;


public interface CarDao extends JpaRepository<Car, Integer> {
    Car findBycarID(Integer carID);

    @Query("SELECT c FROM Car c WHERE c.carName LIKE %:carName% AND c.address LIKE %:address% AND (:minPrice IS NULL OR c.priceHoursCar >= :minPrice) AND (:maxPrice IS NULL OR c.priceHoursCar <= :maxPrice)")
    List<Car> findCars(@Param("carName") String carName, @Param("address") String address, @Param("minPrice") Double minPrice, @Param("maxPrice") Double maxPrice);

	Optional<Car> findBycarID(Car car);
	
	List<Car> findByStatus(boolean status);
}