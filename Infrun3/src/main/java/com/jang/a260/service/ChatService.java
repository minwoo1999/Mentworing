package com.jang.a260.service;

import java.util.List;

import com.jang.a260.model.ChatVO;

public interface ChatService {

	int insertChat(ChatVO chatvo); // 채팅내용 넣기

	List<ChatVO> getChatList();

	List<ChatVO> getChatListforuserId(int roomno);

	int updateChatmessage(int roomno,String check,String name);
	
	int ChatmessageNotification(int roomno,String name,String check);

}
