package com.jang.a260.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jang.a260.model.BasketVO;
import com.jang.a260.model.ChatVO;
import com.jang.a260.model.CouponVO;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.Video;

@Mapper
public interface CouponMapper {

   int insertCoupon(CouponVO coupon); 
   
   List<CouponVO> getCoupon(String userId);
   
   CouponVO  getCoupon_tocno(int cno);

}