package com.poly.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.poly.entity.Customer;

public interface accountRepositorie extends CrudRepository<Customer, Integer> {
	 @Query("SELECT COUNT(c) FROM Customer c")
	    long countCustomers();
}
