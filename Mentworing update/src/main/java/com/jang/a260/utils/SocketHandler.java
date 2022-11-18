package com.jang.a260.utils;

import java.io.File;
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

import com.jang.a260.Main;
import com.jang.a260.model.ChatVO;
import com.jang.a260.model.User;
import com.jang.a260.service.ChatService;
import com.jang.a260.service.UserService;

@Controller
@Component
public class SocketHandler extends TextWebSocketHandler {

	
	String uploadPath = "C:\\upload\\"; // file upload path 전역변수로 파일 저장소 지정
	
	@Autowired
	private ChatService chatService;

	@Autowired
	private UserService userService;

	HashMap<String, WebSocketSession> sessionMap = new HashMap<>(); // 웹소켓 세션을 담아둘 맵

	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {

		
		// 메시지 발송
		int roomno = 0;
		String msg = message.getPayload();
		JSONObject obj = jsonToObjectParser(msg);
		// 파일읽기

		System.out.println("소켓핸들러 발동");
		System.out.println(msg);
		System.out.println(obj);
		System.out.println(obj.get("file"));
		System.out.println(obj.get("userName"));
		System.out.println(obj.get("msg"));
		System.out.println(obj.get("yourName"));
		String[] user = userService.selectchattingname((String) obj.get("userName"));
		String[] yourName = userService.selectchattingname((String) obj.get("yourName"));

		// 파일읽기 끝
		System.out.println(obj.get("type"));
		if (obj.get("type").equals("fileUpload")) {
			System.out.println("파일업로드 영역진입");
			user = userService.selectchattingname((String) obj.get("userName"));
			yourName = userService.selectchattingname((String) obj.get("yourName"));

			for (int i = 0; i < user.length; i++) {
				roomno = Integer.parseInt(user[i]) + Integer.parseInt(yourName[i]);

				System.out.println(roomno);
				System.out.println(Integer.parseInt(user[i]));
				System.out.println(Integer.parseInt(yourName[i]));

			}
			ChatVO chatvo = new ChatVO();
			chatvo.setRoomno(roomno);
			chatvo.setName((String) obj.get("userName"));
			chatvo.setMessage((String) obj.get("file"));

			Main main = new Main();
			File file = new File(uploadPath + obj.get("file"));

			String upload = (String) obj.get("file");

			// String copyKey = "img/my-img-copy.img";
			// upload 실행하기.

			main.upload(file, upload);
			
			chatService.insertChat(chatvo);
				
			for (String key : sessionMap.keySet()) {
				WebSocketSession wss = sessionMap.get(key);
				try {
					wss.sendMessage(new TextMessage(obj.toJSONString()));

				} catch (Exception e) {
					e.printStackTrace();
				}

			}
			
		} else {
			System.out.println("일반 메세지영역진입");
			for (int i = 0; i < user.length; i++) {
				roomno = Integer.parseInt(user[i]) + Integer.parseInt(yourName[i]);

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
