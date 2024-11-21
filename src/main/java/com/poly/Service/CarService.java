package com.poly.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.poly.dao.CarDao;
import com.poly.entity.Car;
import com.poly.entity.CarOwner;

import java.util.List;

@Service
public class CarService {

    @Autowired
    private CarDao carDao;



    public List<Car> findCars(String carName, String address, Double minPrice, Double maxPrice) {
        return carDao.findCars(carName, address, minPrice, maxPrice);
    }
    
//    public List<Car> getAllCars() {
//        return carDao.findAllWithImages();
//    }
    
    
}


