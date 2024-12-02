package com.poly.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.poly.entity.Customer;


@Repository
public interface CustomerDao extends JpaRepository<Customer, Integer> {
	Customer findByCustomerID(Integer customerID);
	
	 
    Customer findByCustomerName(String username);  // Đảm bảo rằng bạn tìm kiếm bằng tên khách hàng hoặc theo cách bạn muốn
}
