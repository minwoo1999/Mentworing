package com.jang.a260.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;

public interface MenteeService {

	List<paymentDetailVO> getpaymentdetailList_menteevideo();
	
	List<paymentVO> getpaymentVO(String userId);
	
	int [] getpaymentdetail(String userId);
	
	String paymentdetail_vnocheck(@Param("userId") String userId, @Param("vno") int vno);
}
