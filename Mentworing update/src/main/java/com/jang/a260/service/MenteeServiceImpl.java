package com.jang.a260.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jang.a260.mapper.MenteeMapper;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;



@Service(value="menteeService")
public class MenteeServiceImpl implements MenteeService {
	
	@Autowired
	private MenteeMapper menteemapper;//인터페이스와 의존관계 설정

	@Override
	public List<paymentDetailVO> getpaymentdetailList_menteevideo() {
		// TODO Auto-generated method stub
		return this.menteemapper.getpaymentdetailList_menteevideo();
	}

	@Override
	public List<paymentVO> getpaymentVO(String userId) {
		// TODO Auto-generated method stub
		return this.menteemapper.getpaymentVO(userId);
	}

	@Override
	public int[] getpaymentdetail(String userId) {
		// TODO Auto-generated method stub
		return this.menteemapper.getpaymentdetail(userId);
	}

	@Override
	public String paymentdetail_vnocheck(String userId, int vno) {
		// TODO Auto-generated method stub
		return this.menteemapper.paymentdetail_vnocheck(userId, vno);
	}

	


}
