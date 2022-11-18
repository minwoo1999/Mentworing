package com.jang.a260.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jang.a260.model.ChatVO;

public interface ChatService {

	int insertChat(ChatVO chatvo); // 채팅내용 넣기

	List<ChatVO> getChatList();

	List<ChatVO> getChatListforuserId(int roomno);

	int updateChatmessage(int roomno,String check,String name);
	
	int updateChatmessage2(int roomno,String check,String name);
	
	int ChatmessageNotification(int roomno,String name,String check);
	
	int Chatmessage2Notification(@Param("roomno") int roomno, @Param("name") String name, @Param("check") String check);

}
