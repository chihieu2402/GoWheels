package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.poly.entity.Review;


public interface ReviewDao extends JpaRepository<Review, Integer> {


	List<Review> findByCarID(int carID);
	

}
