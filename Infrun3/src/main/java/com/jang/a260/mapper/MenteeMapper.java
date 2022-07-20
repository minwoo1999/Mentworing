package com.jang.a260.mapper;



import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;


@Mapper
public interface MenteeMapper {

	
	List<paymentDetailVO> getpaymentdetailList_menteevideo();
	
	List<paymentVO> getpaymentVO(String userId);
	
	int [] getpaymentdetail(String userId);
	

}
