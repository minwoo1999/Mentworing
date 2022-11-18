package com.jang.a260.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jang.a260.mapper.ChatMapper;
import com.jang.a260.model.ChatVO;



@Service(value = "chatSerivce")
public class ChatServiceImpl implements ChatService {

	
	@Autowired
	private ChatMapper chatMapper;

	@Override
	public int insertChat(ChatVO chatvo) {
		// TODO Auto-generated method stub
		return chatMapper.insertChat(chatvo);
	}

	@Override
	public List<ChatVO> getChatList() {
		// TODO Auto-generated method stub
		return chatMapper.getChatList();
	}

	@Override
	public List<ChatVO> getChatListforuserId(int roomno) {
		// TODO Auto-generated method stub
		return chatMapper.getChatListforuserId(roomno);
	}

	@Override
	public int updateChatmessage(int roomno,String check,String name) {
		// TODO Auto-generated method stub
		return chatMapper.updateChatmessage(roomno,check,name);
	}

	@Override
	public int ChatmessageNotification(int roomno, String name,String check) {
		// TODO Auto-generated method stub
		return chatMapper.ChatmessageNotification(roomno,name,check);
	}

	@Override
	public int Chatmessage2Notification(int roomno, String name, String check) {
		// TODO Auto-generated method stub
		return chatMapper.Chatmessage2Notification(roomno, name, check);
	}

	@Override
	public int updateChatmessage2(int roomno, String check, String name) {
		// TODO Auto-generated method stub
		return chatMapper.updateChatmessage2(roomno, check, name);
	};

	












}
