package com.poly.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.dao.CustomerDao;
import com.poly.entity.Customer;


@Service
public class CustomerService {

	@Autowired
	private CustomerDao customerRepository;

	public Customer findByUsername(String username) {
		// Giả sử bạn có một cách lấy Customer từ username
		return customerRepository.findByCustomerName(username);
	}
}
