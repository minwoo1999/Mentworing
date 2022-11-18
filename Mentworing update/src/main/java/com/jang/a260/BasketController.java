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
import com.jang.a260.model.BoardVO;
import com.jang.a260.model.CouponVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;
import com.jang.a260.service.BasketService;
import com.jang.a260.service.BoardService;
import com.jang.a260.service.CouponService;
import com.jang.a260.service.MantorService;
import com.jang.a260.service.UserService;

@Controller
@RequestMapping("/basket")
public class BasketController {
	@Autowired
	private UserService userService;

	@Autowired
	private BasketService basketService;

	@Autowired
	private MantorService mantorSevice;

	@Autowired
	private CouponService couponservice;

	@RequestMapping(value = "/mainbasket", method = RequestMethod.GET)
	public String basketpage(Model model, HttpSession session) throws Exception {

		String userId = (String) session.getAttribute("userId");

		List<CouponVO> coupon = couponservice.getCoupon(userId);
		List<BasketVO> basket = basketService.getBasket(userId);

		User user = userService.getUser(userId);
		
		int basketcounting = basketService.basketcounting(userId);
		session.setAttribute("basketcounting", basketcounting);
		session.setAttribute("basket", basket);

		model.addAttribute("userId", userId);

		model.addAttribute("useraddress", user.getAddr1());

		model.addAttribute("useraddress2", user.getAddr2());

		model.addAttribute("userphone", user.getPhone());

		model.addAttribute("basket", basket);

		model.addAttribute("coupon", coupon);

		model.addAttribute("basket", basket);

		return "basket/mainbasket";
	}

	@RequestMapping(value = "/deletebasket", method = RequestMethod.GET) // ID중복체크
	@ResponseBody
	public String deletebasket(HttpServletRequest request) {

		int bno = Integer.parseInt(request.getParameter("bno"));

		Gson gson = new Gson();
		JsonObject object = new JsonObject();

		if (bno != 0) {
			basketService.deletebasket(bno);
			object.addProperty("msg", "true");
			return gson.toJson(object).toString();
		} else {
			object.addProperty("msg", "false");
			return gson.toJson(object).toString();
		}

	}

	@RequestMapping(value = "/coupon_discount", method = RequestMethod.GET) // ID중복체크
	@ResponseBody
	public String coupon_discount(HttpServletRequest request) {

		int cno = Integer.parseInt(request.getParameter("cno"));

		Gson gson = new Gson();
		JsonObject object = new JsonObject();

		CouponVO coupon = this.couponservice.getCoupon_tocno(cno);

		if (coupon != null) {
			object.addProperty("msg", coupon.getDiscount_rate());
			object.addProperty("coupon", coupon.getCoupon_name());
			return gson.toJson(object).toString();
		} else {
			object.addProperty("msg", "false");
			return gson.toJson(object).toString();
		}
	}

	@RequestMapping(value = "/mentee_Mypage_coupon", method = RequestMethod.GET)
	public String mentee_Mypage_coupon(Model model, HttpSession session) throws Exception {

		String userId = (String) session.getAttribute("userId");

		List<CouponVO> coupon=couponservice.getCoupon(userId);

		model.addAttribute("coupon",coupon);
		return "Mentee/mentee_Mypage_coupon";
	}
	
	@RequestMapping(value = "/checkbasket", method = RequestMethod.GET) // ID중복체크
	@ResponseBody
	public String checkbasket(HttpServletRequest request,HttpSession session) {
		
		String userId=(String) session.getAttribute("userId");
		
		String vno = request.getParameter("vno");
		String[] vnoarr=vno.split(",");
		int count=0;
		for(int i=0;i<vnoarr.length;i++) {
			System.out.println("장바구니 넣은 비디오값"+vnoarr[i]);
			String basketcheck=basketService.basketCheck(userId,Integer.parseInt(vnoarr[i]));
			System.out.println("바스킷 결과값"+basketcheck);
			if(basketcheck!=null) {
				count+=1;
			}
		}
		System.out.println("카운트값은"+count);
		Gson gson = new Gson();
		JsonObject object = new JsonObject();

		if(count>0) {
			object.addProperty("msg", "false");
			return gson.toJson(object).toString();
		}else {
			object.addProperty("msg", "true");
			return gson.toJson(object).toString();
		}

	}

}
