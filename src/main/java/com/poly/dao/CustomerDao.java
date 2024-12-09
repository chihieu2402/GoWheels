package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.poly.entity.Customer;
import java.util.List;



@Repository
public interface CustomerDao extends JpaRepository<Customer, Integer> {
	Customer findByCustomerID(Integer customerID);
	
	 
    Customer findByCustomerName(String username);  
    
    Customer findByEmail(String email);
}
