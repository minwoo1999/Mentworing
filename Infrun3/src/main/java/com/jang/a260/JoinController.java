package com.jang.a260;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.User;
import com.jang.a260.service.UserService;
import com.jang.a260.utils.AES256Util;



@Controller
@RequestMapping("/member")
public class JoinController {

	@Autowired // @Resource(name="userService")
	private UserService userService;

	@RequestMapping(value = "/join", method = RequestMethod.GET) // 회원가입 영역 form 출력
	public String userJoinForm(Model model) {
		model.addAttribute("user", new User());
		return "member/joinForm";
	}

	@RequestMapping(value = "/join", method = RequestMethod.POST) // 입력폼 내용 저장
	public String onSubmit(@Valid User user, BindingResult result, Model model) throws Exception {

		MemberProfileVO memberprofile=new MemberProfileVO();
		if (result.hasErrors()) {
			System.out.println("아웃");
			model.addAllAttributes(result.getModel());
			return "member/joinForm";
		}
		//passwd 암호화 단방향 암호화
		
		BCryptPasswordEncoder passwordEncoder=new BCryptPasswordEncoder();
		String hashPass=passwordEncoder.encode(user.getPass());
		user.setPass(hashPass);
		
		//생년월일 암호화 aes256 양방향 암호화
		
		Path filePath=Paths.get("C://jj/key3.txt");
		String key=Files.readString(filePath);
		
		AES256Util aes256=new AES256Util(key);
		
		String hashBirthday=aes256.aesEncode(user.getBirthday());
		user.setBirthday(hashBirthday);
		
		String userId=user.getId();

		if (this.userService.insertUser(user) != 0) {
			System.out.println("성공");
			user.setPass("");
			User user2=userService.getUser(userId);
			memberprofile.setName(user.getName());
			memberprofile.setProfile("profile.jpg");
			memberprofile.setUserId(user.getId());
			memberprofile.setNo(user2.getNo());
			userService.insertMemberprofile(memberprofile);
			model.addAttribute("user", user);
			model.addAttribute("msgCode", "등록되었습니다. 로그인하여 주십시오.");// 등록성공
			return "redirect:/main";
		} else {
			System.out.println("실패");
			model.addAttribute("msgCode", "등록 실패하였습니다. 다시 시도하여 주십시오.");// 등록실패
			return "member/joinForm";
		}

	}

	@RequestMapping(value = "/idCheck", method = RequestMethod.GET) // ID중복체크
	@ResponseBody
	public String idCheck(HttpServletRequest request) {
		
		System.out.println("1");

		String userId = request.getParameter("userId");

		Gson gson = new Gson();
		JsonObject object = new JsonObject();

		User loginUser = this.userService.getUser(userId);

		if (loginUser != null) {
			object.addProperty("msg", "false");
			return gson.toJson(object).toString();
		} else {
			object.addProperty("msg", "true");
			return gson.toJson(object).toString();
		}
	}
	


}
