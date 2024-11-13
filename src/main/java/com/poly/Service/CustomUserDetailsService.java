package com.poly.Service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.poly.dao.AccountDao;
import com.poly.entity.Account;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
	private AccountDao accountDao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Optional<Account> accountOptional = accountDao.findByUserName(username);
		Account account = accountOptional.orElseThrow(() -> new UsernameNotFoundException("User not found"));
		return new CustomUserDetails(account);
	}
}
