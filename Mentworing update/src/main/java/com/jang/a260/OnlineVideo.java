package com.jang.a260;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jang.a260.model.MentorVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.service.MantorService;
import com.jang.a260.service.MenteeService;

@Controller
@RequestMapping("/Mentee")
public class OnlineVideo {
	
	@Autowired
	
	private MenteeService menteeService;
	
	@Autowired
	private MantorService mantorService;
	
	@RequestMapping(value = "/mentee_videolist", method = RequestMethod.GET)
	public String mentee_videolist(@ModelAttribute("searchVO") SearchVO searchVO,Model model, HttpSession session) throws Exception {

		String userId=(String) session.getAttribute("userId");
		System.out.println(userId);
		
		List<paymentDetailVO> paymentList=menteeService.getpaymentdetailList_menteevideo();
	
		model.addAttribute("userId",userId);
		model.addAttribute("paymentList",paymentList);
		model.addAttribute("user", new User());

		return "/Mentee/mentee_videolist";
	}
	
	@RequestMapping(value = "/mentee_Mypage_videolist", method = RequestMethod.GET)
	public String mentee_Mypage_videolist(@ModelAttribute("searchVO") SearchVO searchVO,Model model, HttpSession session) throws Exception {

		String userId=(String) session.getAttribute("userId");
		System.out.println(userId);
		
		List<paymentDetailVO> paymentList=menteeService.getpaymentdetailList_menteevideo();
		List<Video> video=mantorService.videoList();
		model.addAttribute("video",video);
		model.addAttribute("userId",userId);
		model.addAttribute("paymentList",paymentList);
		model.addAttribute("user", new User());

		return "/Mentee/mentee_Mypage_videolist";
	}

}
