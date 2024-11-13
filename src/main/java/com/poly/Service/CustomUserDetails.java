package com.poly.Service;

import com.poly.entity.Account;
import java.util.Collections;
import org.springframework.security.core.userdetails.User;

public class CustomUserDetails extends org.springframework.security.core.userdetails.User {
	private Account account;

	public CustomUserDetails(Account account) {
		super(account.getUserName(), account.getPassWord(), Collections.emptyList());
		this.account = account;
	}

	public Account getAccount() {
		return account;
	}
}
