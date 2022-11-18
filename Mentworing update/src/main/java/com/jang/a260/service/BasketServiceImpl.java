package com.jang.a260.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jang.a260.mapper.BasketMapper;
import com.jang.a260.mapper.MantorMapper;
import com.jang.a260.model.BasketVO;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.Video;

@Service(value="basketService")
public class BasketServiceImpl implements BasketService {
	
	@Autowired
	private BasketMapper basketmapper; //인터페이스와 의존관계 설정

	@Override
	public int insertbasket(BasketVO basket) {
		// TODO Auto-generated method stub
		return this.basketmapper.insertbasket(basket);
	}

	@Override
	public List<BasketVO> getBasket(String userId) {
		// TODO Auto-generated method stub
		return this.basketmapper.getBasket(userId);
	}

	@Override
	public int deletebasket(int bno) {
		// TODO Auto-generated method stub
		return this.basketmapper.deletebasket(bno);
	}

	@Override
	public int completeorder_deletebasket(String userId) {
		// TODO Auto-generated method stub
		return this.basketmapper.completeorder_deletebasket(userId);
	}

	@Override
	public String basketCheck(String userId, int vno) {
		// TODO Auto-generated method stub
		return this.basketmapper.basketCheck(userId, vno);
	}

	@Override
	public int basketcounting(String userId) {
		// TODO Auto-generated method stub
		return this.basketmapper.basketcounting(userId);
	}


}
