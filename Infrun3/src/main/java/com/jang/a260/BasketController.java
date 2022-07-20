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
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;
import com.jang.a260.service.BasketService;
import com.jang.a260.service.BoardService;
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

	@RequestMapping(value = "/mainbasket", method = RequestMethod.GET)
	public String basketpage(Model model, HttpSession session) throws Exception {

		String userId = (String) session.getAttribute("userId");

		List<BasketVO> basket = basketService.getBasket(userId);

		model.addAttribute("userId",userId);
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



}
