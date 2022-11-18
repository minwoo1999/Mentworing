package com.jang.a260.service;

import java.util.HashMap;
import java.util.Random;

import org.springframework.stereotype.Service;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class Second_certificate {

	
	//휴대폰번호 인증문자 보내기
	public String PhoneNumberCheck(String to,String numStr) throws CoolsmsException{
		String api_key = "NCS4KWJROJI79EPK";
		String api_secret = "YWBLLAVNA1HNEC52FVNHLKXMW7PEO0HM";
		Message coolsms = new Message(api_key, api_secret);
			

		  
		System.out.println(to);
		HashMap<String, String> params = new HashMap<String, String>();
		
	    params.put("to", to);    // 수신전화번호 (ajax로 view 화면에서 받아온 값으로 넘김)
	    params.put("from", "01040944747");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "sms"); 
	    params.put("text", "멘토링 2차인증번호: [" + numStr + "] 입니다.");
	 
	    coolsms.send(params); // 메시지 전송
			  
			  
		return numStr;
		 
	}
}
