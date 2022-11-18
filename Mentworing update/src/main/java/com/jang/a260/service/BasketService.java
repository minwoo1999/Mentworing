package com.jang.a260.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jang.a260.model.BasketVO;

public interface BasketService {

	int insertbasket(BasketVO basket);

	List<BasketVO> getBasket(String userId);

	int deletebasket(int bno);

	int completeorder_deletebasket(String userId);
	
	String basketCheck(@Param("userId") String userId, @Param("vno") int vno);
	
	int basketcounting(String userId);

}
