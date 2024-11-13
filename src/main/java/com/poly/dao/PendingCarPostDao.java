package com.poly.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poly.entity.PendingCarPost;

public interface PendingCarPostDao extends JpaRepository<PendingCarPost, Integer> {
	
	List<PendingCarPost> findByStatus(boolean status);
	
}
