package com.jang.a260.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jang.a260.model.BasketVO;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.Video;

@Mapper
public interface BasketMapper {

	int insertbasket(BasketVO basket);
	
	List<BasketVO> getBasket(String userId);
	
	int deletebasket(int bno);
}
