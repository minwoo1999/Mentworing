package com.jang.a260;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jang.a260.model.User;
import com.jang.a260.service.UserService;
import com.jang.a260.utils.AES256Util;



@RequestMapping("/member")
@Controller
public class LoginController {

	@Autowired // @Resource(name="userService")
	private UserService userService;

	@RequestMapping(value = "/login", method = RequestMethod.GET) // url만 입력해서 들어온방식
	public String toLoginView(Model model) {

		model.addAttribute("user", new User());
		return "member/login";

	}

	@RequestMapping(value = "/login", method = RequestMethod.POST) // 폼에서 입력받은 방식 post
	public String onSubmit(@Valid User user, BindingResult result, Model model,HttpSession session) {

		if (result.hasFieldErrors("id") || result.hasFieldErrors("pass")) {
			model.addAllAttributes(result.getModel());
			return "redirect:/main";
		}
		try {
				
			System.out.println("1");
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

			// 의존관계를 설정한 service객체의 getUser()메세더를 호출하여 User 정보를 읽어온다.
			User loginUser = this.userService.getUser(user.getId());
			System.out.println("2");
			if (passwordEncoder.matches(user.getPass(), loginUser.getPass())) {
				System.out.println("3");
				session.setAttribute("userId",loginUser.getId());
				session.setAttribute("userName", loginUser.getName());
				model.addAttribute("loginUser", loginUser);
				return "redirect:/main";
			} else {
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
	public String toUserEditView(Model model,HttpSession session) throws Exception {
		
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
			} 
			else {
				System.out.println("2");
				result.rejectValue("email", "error.email.user", "이메일이 일치하지않습니다.");
				model.addAllAttributes(result.getModel());
				return "member/findIdForm";
			}

		} catch (NullPointerException e ) {
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
			if(findUser.getId().equals(user.getId()) &&findUser.getEmail().equals(user.getEmail())) {
				
				model.addAttribute("findUser", findUser);
				return "member/updatePassForm";
			}
			else {
			
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
