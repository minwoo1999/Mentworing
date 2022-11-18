package com.jang.a260.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jang.a260.mapper.BasketMapper;
import com.jang.a260.mapper.CouponMapper;
import com.jang.a260.mapper.MantorMapper;
import com.jang.a260.model.BasketVO;
import com.jang.a260.model.CouponVO;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.Video;

@Service(value="CouponService")
public class CouponServiceImpl implements CouponService {
   
   @Autowired
   private CouponMapper couponmapper; //인터페이스와 의존관계 설정

   @Override
   public int insertCoupon(CouponVO coupon) {
      // TODO Auto-generated method stub
      return couponmapper.insertCoupon(coupon);
   }

@Override
public List<CouponVO> getCoupon(String userId) {
	// TODO Auto-generated method stub
	return this.couponmapper.getCoupon(userId);
}

@Override
public CouponVO getCoupon_tocno(int cno) {
	// TODO Auto-generated method stub
	return this.couponmapper.getCoupon_tocno(cno);
}



   

}