package com.jang.a260;

import java.sql.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jang.a260.model.BasketVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;
import com.jang.a260.service.BasketService;

import com.jang.a260.service.MantorService;
import com.jang.a260.service.UserService;

@Controller
@RequestMapping("/basket")
public class PaymentController {
	@Autowired
	private UserService userService;

	@Autowired
	private BasketService basketService;
	
	@Autowired
	private MantorService mantorSevice;

	

	@RequestMapping(value = "/order", method = RequestMethod.GET)
	public String orderpage(Model model, HttpSession session) throws Exception {
		String userId = (String) session.getAttribute("userId");

		User user = userService.getUser(userId);

		
		List<BasketVO> basket = basketService.getBasket(userId);// 장바구니 갖고오기
		

		

		model.addAttribute("userId",userId);
		model.addAttribute("useraddress", user.getAddr1());
		model.addAttribute("useraddress2", user.getAddr2());
		model.addAttribute("userphone", user.getPhone());
		model.addAttribute("basket", basket);

		return "order/order";
	}

	@ResponseBody
	@RequestMapping(value = "/order", method = RequestMethod.POST, consumes = "application/json;") // ID중복체크
	public String orderpagepost(@RequestBody HashMap<String, Object> params,HttpSession session) {

		

		Gson gson = new Gson();
		JsonObject object = new JsonObject();
		
		String userId=(String) session.getAttribute("userId");
		String userName=(String) session.getAttribute("userName");
		System.out.println(params.get("vno")); //  {22, 24, 23, userId=asdf}
		System.out.println(params.get("userId")); //  {vno=[22, 24, 23], userId=asdf}
		
		
		String[] arr=params.get("vno").toString().split(",");
		
		System.out.println(arr);
		
			paymentVO payment=new paymentVO();
			payment.setUserId(params.get("userId").toString());
			payment.setAmount("100");
			
			userService.insertPayment(payment); //결제테이블에 저장후
			
			int pno=mantorSevice.getPaymentPno(params.get("userId").toString()); //해당하는 결제테이블 번호를 가져온다
			for(int i=0;i<arr.length;i++) {
				System.out.println(arr[i]);
				Video video=mantorSevice.getvideoview(Integer.parseInt(arr[i]));		
				paymentDetailVO paymentdetail=new paymentDetailVO();
				paymentdetail.setMno(video.getMno());
				paymentdetail.setUserId(params.get("userId").toString());
				paymentdetail.setVno(Integer.parseInt(arr[i]));
				paymentdetail.setVfilename(video.getVideofile());
				paymentdetail.setPno(pno);
				paymentdetail.setPrice(Integer.parseInt(video.getVideoprice()));
				basketService.completeorder_deletebasket(userId);
				userService.insertPaymentDetail(paymentdetail);
			}
		
		
		
		if (params != null) {
			object.addProperty("msg", "true");
			System.out.println(gson.toJson(object).toString());
			return gson.toJson(object).toString();
		} else {
			object.addProperty("msg", "false");
			System.out.println(gson.toJson(object).toString());
			return gson.toJson(object).toString();
		}
		


	}
	

}
