
package com.poly.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.dao.CarBrandDao;
import com.poly.entity.CarBrand;


@Service
public class CarBrandSerivce {

	@Autowired
	private CarBrandDao brandDao;

	public List<CarBrand> findAll() {
		return brandDao.findAll();
	}

	public CarBrand findByName(String brandName) {
		return brandDao.findByBrandName(brandName);
	}
	
	public Optional<CarBrand> findById(int id) {
	    return brandDao.findById(id);
	}
}
