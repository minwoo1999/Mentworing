package com.jang.a260.service;

import java.util.List;

import com.jang.a260.model.BasketVO;

public interface BasketService {

	int insertbasket(BasketVO basket);
	
	List<BasketVO> getBasket(String userId);
	
	int deletebasket(int bno);
}
