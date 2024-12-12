package com.poly.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.poly.entity.Account;
import com.poly.entity.Bill;
@Repository

public interface ThongkeRepositorie extends CrudRepository<Bill, Integer> {
    
    @Query("SELECT SUM(b.totalPrice) FROM Bill b")
    Double getTotalRevenue();
    
}


