package com.poly.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.entity.Account;


public interface AccountDao extends JpaRepository<Account, Integer> {
//	  @Query ("SELECT o FROM Account o WHERE o.accountID LIKE ?1")
//	  List<Account> findByIdd(Integer accountID);
	 
	 Account findByAccountID(int accountID);
	 
	 Optional<Account> findByUserName(String username);
	
	 
}
