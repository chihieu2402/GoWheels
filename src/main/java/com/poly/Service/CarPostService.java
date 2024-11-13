package com.poly.Service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.poly.dao.CarDao;
import com.poly.dao.ImageCarDao;
import com.poly.dao.ImagePendingDao;
import com.poly.dao.PendingCarPostDao;
import com.poly.entity.Car;
import com.poly.entity.ImageCar;
import com.poly.entity.ImagePending;
import com.poly.entity.PendingCarPost;

@Service
public class CarPostService {

    @Autowired
    private PendingCarPostDao pendingCarPostDao;

    @Autowired
    private CarDao carDao;

    @Autowired
    private ImagePendingDao imagePendingDao;

    @Autowired
    private ImageCarDao imageCarDao;

    // Lưu bài đăng chờ duyệt
    public void addPost(PendingCarPost pendingCarPost) {
        pendingCarPostDao.save(pendingCarPost);
    }

    // Lấy tất cả bài đăng chờ duyệt
    public List<PendingCarPost> getAllPendingPosts() {
        return pendingCarPostDao.findAll();
    }

    // Duyệt bài đăng và chuyển sang Car
    public void approvePost(int postID) {
        PendingCarPost pendingPost = pendingCarPostDao.findById(postID).orElse(null);
        if (pendingPost != null) {
            Car car = new Car();
            car.setCarName(pendingPost.getCarName());
            car.setCarType(pendingPost.getCarType());
            car.setColor(pendingPost.getColor());
            car.setType_gear(pendingPost.getType_gear());
            car.setCar_number(pendingPost.getCar_number());
            car.setType_fuel(pendingPost.getType_fuel());
            car.setYear_of_manufacture(pendingPost.getYear_of_manufacture());
            car.setMuctieuthu(pendingPost.getMuctieuthu());
            car.setLimit(pendingPost.getLimit());
            car.setFee_limit(pendingPost.getFee_limit());
            car.setAddress(pendingPost.getAddress());
            car.setDescribe(pendingPost.getDescribe());
            car.setPriceHoursCar(pendingPost.getPriceHoursCar());
            car.setCarBrand(pendingPost.getCarBrand());
            car.setStatus(true); // Đặt trạng thái là đã duyệt
            
            // Lưu Car mới vào cơ sở dữ liệu
            carDao.save(car);

            // Lấy thông tin hình ảnh từ ImagePending
            ImagePending imagePending = imagePendingDao.findById(pendingPost.getPostID()).orElse(null);
            if (imagePending != null) {
                ImageCar imageCar = new ImageCar();
                imageCar.setVehicleId(car.getCarID()); // Sử dụng ID của Car cho ImageCar
                imageCar.setImage1(imagePending.getImage1());
                imageCar.setImage2(imagePending.getImage2());
                imageCar.setImage3(imagePending.getImage3());
                imageCar.setImage4(imagePending.getImage4());
                imageCar.setImgOwnershipCertificate1(imagePending.getImgOwnershipCertificate1());
                imageCar.setImgOwnershipCertificate2(imagePending.getImgOwnershipCertificate2());
                imageCar.setCar(car); // Thiết lập quan hệ với Car
                
                // Lưu ImageCar mới vào cơ sở dữ liệu
                imageCarDao.save( imageCar);
                
                // Xóa ImagePending sau khi đã chuyển sang ImageCar
                imagePendingDao.delete(imagePending);
            }

            // Xóa bài đăng chờ duyệt sau khi chuyển thành Car
            pendingCarPostDao.delete(pendingPost);
        }
    }

    // Từ chối bài đăng
    public void rejectPost(int postID) {
        PendingCarPost pendingPost = pendingCarPostDao.findById(postID).orElse(null);
        if (pendingPost != null) {
            // Xóa hình ảnh liên quan nếu có
            ImagePending imagePending = imagePendingDao.findById(postID).orElse(null);
            if (imagePending != null) {
                imagePendingDao.delete(imagePending);
            }
            pendingCarPostDao.delete(pendingPost);
        }
    }

    // Lấy tất cả các bài đăng đã duyệt (trạng thái true)
    public List<Car> getAllApprovedCars() {
        return carDao.findByStatus(true); // Tìm tất cả Car đã được duyệt
    }
}
