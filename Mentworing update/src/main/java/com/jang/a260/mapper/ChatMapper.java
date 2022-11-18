package com.jang.a260.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jang.a260.model.ChatVO;

@Mapper
public interface ChatMapper {

	int insertChat(ChatVO chatvo); // 채팅내용 넣기

	List<ChatVO> getChatList();
	
	List<ChatVO> getChatListforuserId(int roomno);
	
	int updateChatmessage(@Param("roomno") int roomno, @Param("check") String check, @Param("name") String name);
	
	int updateChatmessage2(@Param("roomno") int roomno, @Param("check") String check, @Param("name") String name);
	
	int ChatmessageNotification(@Param("roomno") int roomno, @Param("name") String name, @Param("check") String check);
	
	int Chatmessage2Notification(@Param("roomno") int roomno, @Param("name") String name, @Param("check") String check);
	


}
