package com.jang.a260.service;

import java.util.List;

import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;

public interface MenteeService {

	List<paymentDetailVO> getpaymentdetailList_menteevideo();
	
	List<paymentVO> getpaymentVO(String userId);
	
	int [] getpaymentdetail(String userId);
}
