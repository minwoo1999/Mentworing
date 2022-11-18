package com.jang.a260.service;

import java.util.List;

import com.jang.a260.model.BasketVO;
import com.jang.a260.model.CouponVO;

public interface CouponService {

   int insertCoupon(CouponVO coupon); 
   
   List<CouponVO> getCoupon(String userId);
   
   CouponVO  getCoupon_tocno(int cno);
}