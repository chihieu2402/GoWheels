package com.poly.Service;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;

import com.poly.dao.CustomerDao;
import com.poly.entity.Account;
import com.poly.entity.Customer;

public class CustomUserDetails extends User {
	private Account account;
	
	

	public CustomUserDetails(Account account) {
		super(account.getUserName(), account.getPassWord(), Collections.emptyList());
		this.account = account;
	}

	public Account getAccount() {
		return account;
	}
	
}
