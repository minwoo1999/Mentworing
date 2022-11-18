package com.jang.a260;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.jang.a260.model.ChatVO;
import com.jang.a260.model.User;
import com.jang.a260.service.ChatService;
import com.jang.a260.service.UserService;


@Controller
public class ChatController {
	
	
	@Autowired
	private ChatService chatService;
	@RequestMapping("/chat")
	public ModelAndView chat(Model model,HttpServletRequest request) {
		

		HttpSession session=request.getSession();
    	String name=(String)session.getAttribute("userName");
		ModelAndView mv = new ModelAndView();
		
		System.out.println(name);
		List<ChatVO> chatvo=chatService.getChatList();
		
		mv.setViewName("../views/Mentor/Mentor_chat");
		mv.addObject("chatVO",chatvo);
		mv.addObject("name",name);
		return mv;
	}
	

}


