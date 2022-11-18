package com.jang.a260;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.websocket.Session;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jang.a260.model.CouponVO;
import com.jang.a260.model.User;
import com.jang.a260.service.KaKaoAPI;
import com.jang.a260.service.Second_certificate;
import com.jang.a260.service.UserService;
import com.jang.a260.utils.AES256Util;

@RequestMapping("/member")
@Controller
public class LoginController {

	@Autowired // @Resource(name="userService")
	private UserService userService;

	@Autowired
	private KaKaoAPI kakao;

	@Autowired
	private Second_certificate certificate;

	@RequestMapping(value = "/second_certificate", method = RequestMethod.GET) // url만 입력해서 들어온방식
	public String second_certificate(@RequestParam("userId") String userId, Model model, HttpSession session, HttpServletRequest request) throws Exception {

		Path filePath = Paths.get("C:/jj/key3.txt");
		String key = Files.readString(filePath);
		AES256Util aes256 = new AES256Util(key);
		
		
		String userphonenumber = request.getParameter("userphonenumber");

		String decphone = aes256.aesDecode(userphonenumber);
		//랜덤문자 생성
		Random rand = new Random(); 
		String numStr = "";
		for(int i=0; i<4; i++) {
			String ran = Integer.toString(rand.nextInt(10)); 
			numStr += ran;
		}
		System.out.println(decphone);
		System.out.println(numStr);
		
		session.setAttribute("random_Str", numStr);
		session.setAttribute("Spare_user", userId);
		model.addAttribute("user", new User());
		//certificate.PhoneNumberCheck(decphone,numStr);
		return "second_certificate";
	}
	
	@RequestMapping(value = "/second_certificate", method = RequestMethod.POST) // url만 입력해서 들어온방식
	public String second_certificate_POST(@RequestParam("certificate_number") String certificate_number, Model model, HttpSession session, HttpServletRequest request) throws Exception {
			
		String random_Str=(String)session.getAttribute("random_Str");
		System.out.println("발급된 랜덤 숫자"+random_Str);
		System.out.println("사용자가 입력한 랜덤숫자"+certificate_number);
		if(random_Str.equals(certificate_number)) {
			String userId=(String)session.getAttribute("Spare_user");
			session.setAttribute("userId", userId);
			User loginUser = this.userService.getUser(userId);
			session.setAttribute("userName", loginUser.getName());
			System.out.println("잘들어옴"+loginUser.getName());
			return "redirect:/main";
		}else {
			
			model.addAttribute("user", new User());
			return "redirect:/main";
		}
		
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/second_certificate_onoff", method = RequestMethod.GET) // url만 입력해서 들어온방식
	public String second_certificate_onoff(@RequestParam("userId")String userId,@RequestParam("onoff")String onoff,  Model model, HttpSession session, HttpServletRequest request) throws Exception {
		
		Gson gson = new Gson();
		JsonObject object = new JsonObject();
		int result=0;
		//보안테이블에 기존에 있던 유저라면 ? 업데이트를 시켜 기존의 값을 변경시키고 없다면 새롭게추가
		System.out.println("1");
		if(userService.select_authenticationId(userId)!=null) {
			result=userService.update_authentication(userId,onoff);
			System.out.println("2");
		}
		else {
			result=userService.insert_second_authentication(userId, onoff);
			System.out.println("3");
		}
		
		
		if (result != 0) {
			object.addProperty("msg", "true");
			return gson.toJson(object).toString();
		} else {
			object.addProperty("msg", "false");
			return gson.toJson(object).toString();
		}
		
	}
	

	@RequestMapping(value = "/kakao_login", method = RequestMethod.GET) // url만 입력해서 들어온방식
	public String kakao_login(Model model, @RequestParam("code") String code, HttpSession session) {

		String access_Token = kakao.getAccessToken(code);
		System.out.println(access_Token);
		HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
		System.out.println("login Controller : " + userInfo);
//	    클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
		if (userInfo.get("email") != null) {
			session.setAttribute("userId", userInfo.get("email"));
			session.setAttribute("access_Token", access_Token);
		}
		System.out.println("controller access_token : " + access_Token);
		model.addAttribute("user", new User());
		return "redirect:../main";

	}

	@RequestMapping(value = "/login", method = RequestMethod.GET) // url만 입력해서 들어온방식
	public String toLoginView(Model model) {

		model.addAttribute("user", new User());
		return "member/login";

	}

	@RequestMapping(value = "/login", method = RequestMethod.POST) // 폼에서 입력받은 방식 post
	public String onSubmit(@Valid User user, BindingResult result, Model model, HttpSession session,
			RedirectAttributes rea) throws Exception {

		if (result.hasFieldErrors("id") || result.hasFieldErrors("pass")) {
			model.addAllAttributes(result.getModel());
			return "redirect:/main";
		}
		try {

			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

			// 의존관계를 설정한 service객체의 getUser()메세더를 호출하여 User 정보를 읽어온다.
			User loginUser = this.userService.getUser(user.getId());
			if (passwordEncoder.matches(user.getPass(), loginUser.getPass()) && userService.check_authenticationId(loginUser.getId())!=null &&userService.check_authenticationId(loginUser.getId()).equals("ON")) {
				// System.out.println("3");
				// session.setAttribute("userId", loginUser.getId());
				//session.setAttribute("userName", loginUser.getName());
				model.addAttribute("loginUser", loginUser);

				Path filePath = Paths.get("C://jj/key3.txt");
				String key = Files.readString(filePath);

				AES256Util aes256 = new AES256Util(key);

				String hashPhone = aes256.aesEncode(loginUser.getPhone());
				rea.addAttribute("userphonenumber", hashPhone);
				rea.addAttribute("userId",loginUser.getId());
				// return "redirect:/main";
				return "redirect:/member/second_certificate";

			} 
			else if(passwordEncoder.matches(user.getPass(), loginUser.getPass()) &&  userService.check_authenticationId(loginUser.getId())==null || !userService.check_authenticationId(loginUser.getId()).equals("ON") ) {
				session.setAttribute("userId", loginUser.getId());
				session.setAttribute("userName", loginUser.getName());
				model.addAttribute("loginUser", loginUser);
				return "redirect:/main";
			}
			
			else {
				System.out.println("4");
				result.rejectValue("pass", "error.password.user", "패스워드가 일치하지않습니다. 학번...");
				model.addAllAttributes(result.getModel());
				return "redirect:/main";
			}

		} catch (EmptyResultDataAccessException e) {
			System.out.println("5");
			result.rejectValue("id", "error.id.user", "아이디가 존재하지않습니다. 학번 ...");
			model.addAllAttributes(result.getModel());
			return "redirect:/main";
		}
	}

	@RequestMapping(value = "/editUser", method = RequestMethod.GET)
	public String toUserEditView(Model model, HttpSession session) throws Exception {

		String userId = (String) session.getAttribute("userId");
		User loginUser = this.userService.getUser(userId);

		if (userService == null) {
			model.addAttribute("userId", "");
			model.addAttribute("msgCode", "등록되지않은 아이디입니다"); // 등록되지않은 아이디

			return "member/login";
		} else {

			// 암호화된 password 삭제

			// 생년월일 복호화 aes256

			Path filePath = Paths.get("C:/jj/key3.txt");
			String key = Files.readString(filePath);
			AES256Util aes256 = new AES256Util(key);

			String hashBirthday = loginUser.getBirthday();
			String decBrithday = aes256.aesDecode(hashBirthday);

			loginUser.setBirthday(decBrithday);

			model.addAttribute("user", loginUser);
			return "member/editForm";
		}
	}

	@RequestMapping(value = "/editUser", method = RequestMethod.POST)
	public String onEditSave(@ModelAttribute User user, Model model) throws Exception {

		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashPass = passwordEncoder.encode(user.getPass());
		user.setPass(hashPass);

		// 생년월일 암호화

		Path filePath = Paths.get("C:/jj/key3.txt");
		String key = Files.readString(filePath);

		AES256Util aes256 = new AES256Util(key);

		String hashBrithday = aes256.aesEncode(user.getBirthday());
		user.setBirthday(hashBrithday);

		if (this.userService.updateUser(user) != 0) {
			user.setPass("");
			model.addAttribute("msgCode", "사용자 정보수정가 수정되었습니다");
			model.addAttribute("user", user);
			return "member/login";
		} else {
			model.addAttribute("msgCode", "사용자 정보수정에 실패하였습니다");
			return "member/editForm";
		}
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET) // 아무런값없이 들어왔을때

	public String logout(HttpSession session) {
		kakao.kakaoLogout((String) session.getAttribute("access_Token"));
		session.removeAttribute("access_Token");
		session.removeAttribute("kakao_userId");
		session.invalidate();
		return "redirect:/main";

	}

	@RequestMapping(value = "/findId", method = RequestMethod.GET) // 아무런값없이 들어왔을때

	public String toFIndIdForm(Model model) {
		System.out.println("get방식");
		model.addAttribute("user", new User());
		return "member/findIdForm";

	}

	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	public String findIdSubmit(@Valid User user, BindingResult result, Model model) {

		if (result.hasFieldErrors("name") || result.hasFieldErrors("email")) {
			model.addAllAttributes(result.getModel());
			return "member/findIdForm";
		}

		try {

			User findUser = this.userService.findId(user.getName(), user.getEmail());
			System.out.println(findUser);
			System.out.println("3");
			if (findUser.getName().equals(user.getName()) && findUser.getEmail().equals(user.getEmail())) {

				System.out.println("1");
				model.addAttribute("findUser", findUser);
				return "member/findIdSuccess";
			} else {
				System.out.println("2");
				result.rejectValue("email", "error.email.user", "이메일이 일치하지않습니다.");
				model.addAllAttributes(result.getModel());
				return "member/findIdForm";
			}

		} catch (NullPointerException e) {
			System.out.println("4");
			result.rejectValue("name", "error.name.user", "이름 및 이메일이 존재하지않습니다.");
			model.addAllAttributes(result.getModel());
			return "member/findIdForm";
		}

	}

	@RequestMapping(value = "/findPass", method = RequestMethod.GET) // 아무런값없이 들어왔을때

	public String toFIndPassForm(Model model) {
		System.out.println("get방식");
		model.addAttribute("user", new User());
		return "member/findPassForm";

	}

	@RequestMapping(value = "/findPass", method = RequestMethod.POST)

	public String findPassSubmit(@Valid User user, BindingResult result, Model model, RedirectAttributes redirect) {

		System.out.println("post방식");
		if (result.hasFieldErrors("id") || result.hasFieldErrors("email")) {

			model.addAllAttributes(result.getModel());
			return "member/findPassForm";
		}
		try {

			User findUser = this.userService.findPass(user.getId(), user.getEmail());
			if (findUser.getId().equals(user.getId()) && findUser.getEmail().equals(user.getEmail())) {

				model.addAttribute("findUser", findUser);
				return "member/updatePassForm";
			} else {

				result.rejectValue("email", "error.email.user", "아이디 및 이메일 정보가일치하지않습니다.");
				model.addAllAttributes(result.getModel());
				return "member/findPassForm";
			}

		} catch (NullPointerException e) {

			result.rejectValue("id", "error.id.user", "아이디 및 이메일 정보가일치하지않습니다.");
			return "member/findPassForm";
		}
	}

	@RequestMapping(value = "/updatePass", method = RequestMethod.GET) // 아무런값없이 들어왔을때

	public String toFIndupdateForm(User user, Model model) {
		System.out.println("get방식");
		model.addAttribute("userId", user.getId());

		model.addAttribute("user", new User());
		return "member/updatePassForm";

	}

	@RequestMapping(value = "/updatePass", method = RequestMethod.POST)
	public String updatePass(@Valid User user, BindingResult result, Model model) throws Exception {

		if (result.hasFieldErrors("id") || result.hasFieldErrors("pass")) {
			model.addAllAttributes(result.getModel());
			return "member/updatePassForm";
		}
		// passwd 암호화 단방향 암호화

		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashPass = passwordEncoder.encode(user.getPass());
		user.setPass(hashPass);

		if (this.userService.updatePass(user) == 1) {
			model.addAttribute("userId", user.getId());
			return "member/updatePassSuccess";
		} else {
			result.rejectValue("id", "error.password.user", "패스워드 변경에 실패하였습니다. 다시시도해주셈...");
			return "member/updatePassForm";
		}
	}

	@RequestMapping(value = "/test", method = RequestMethod.GET) // 아무런값없이 들어왔을때

	public String test() {

		return "test";

	}

}
