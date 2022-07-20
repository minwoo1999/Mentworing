package com.jang.a260.utils;

import java.util.HashMap;
import java.util.logging.Logger;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.jang.a260.model.ChatVO;
import com.jang.a260.model.User;
import com.jang.a260.service.ChatService;
import com.jang.a260.service.UserService;



@Controller
@Component
public class SocketHandler extends TextWebSocketHandler {

	@Autowired
	private ChatService chatService;
	
	@Autowired
	private UserService userService;

	HashMap<String, WebSocketSession> sessionMap = new HashMap<>(); // 웹소켓 세션을 담아둘 맵

	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
		// 메시지 발송
		int roomno=0;
		String msg = message.getPayload();
		JSONObject obj = jsonToObjectParser(msg);
		
		
		
		System.out.println(msg);
		System.out.println(obj);
		System.out.println(obj.get("userName"));
		System.out.println(obj.get("msg"));
		System.out.println(obj.get("yourName"));
		String [] user=userService.selectchattingname((String) obj.get("userName"));
		String [] yourName=userService.selectchattingname((String) obj.get("yourName"));
		
		for(int i=0;i<user.length;i++) {
			roomno=Integer.parseInt(user[i])+Integer.parseInt(yourName[i]);
			
			System.out.println(roomno);
			System.out.println(Integer.parseInt(user[i]));
			System.out.println(Integer.parseInt(yourName[i]));

		}
		ChatVO chatvo = new ChatVO();
		chatvo.setRoomno(roomno);
		chatvo.setName((String) obj.get("userName"));
		chatvo.setMessage((String) obj.get("msg"));

		chatService.insertChat(chatvo);
		
		for (String key : sessionMap.keySet()) {
			WebSocketSession wss = sessionMap.get(key);
			try {
				wss.sendMessage(new TextMessage(obj.toJSONString()));

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	@SuppressWarnings("unchecked")
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 소켓 연결
		super.afterConnectionEstablished(session);
		sessionMap.put(session.getId(), session);
		JSONObject obj = new JSONObject();
		obj.put("type", "getId");
		obj.put("sessionId", session.getId());
		session.sendMessage(new TextMessage(obj.toJSONString()));
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 소켓 종료
		sessionMap.remove(session.getId());
		super.afterConnectionClosed(session, status);
	}

	private static JSONObject jsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}
}
