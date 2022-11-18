package com.jang.a260;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jang.a260.model.CouponVO;
import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.User;
import com.jang.a260.service.CouponService;
import com.jang.a260.service.UserService;
import com.jang.a260.utils.AES256Util;

@Controller
@RequestMapping("/member")
public class JoinController {

   @Autowired // @Resource(name="userService")
   private UserService userService;

   @Autowired // @Resource(name="userService")
   private CouponService couponService;

   @RequestMapping(value = "/join", method = RequestMethod.GET) // 회원가입 영역 form 출력
   public String userJoinForm(Model model) {

      model.addAttribute("user", new User());
      return "member/joinForm";
   }

   @RequestMapping(value = "/join", method = RequestMethod.POST) // 입력폼 내용 저장
   public String onSubmit(@Valid User user, BindingResult result, Model model, HttpServletResponse response,RedirectAttributes rea)
         throws Exception {

      MemberProfileVO memberprofile = new MemberProfileVO();
      if (result.hasErrors()) {
         System.out.println("아웃");
         model.addAllAttributes(result.getModel());
         return "member/joinForm";
      }
      // passwd 암호화 단방향 암호화

      BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
      String hashPass = passwordEncoder.encode(user.getPass());
      user.setPass(hashPass);

      // 생년월일 암호화 aes256 양방향 암호화

      Path filePath = Paths.get("C://jj/key3.txt");
      String key = Files.readString(filePath);

      AES256Util aes256 = new AES256Util(key);

      String hashBirthday = aes256.aesEncode(user.getBirthday());
      user.setBirthday(hashBirthday);

      String userId = user.getId();

      if (this.userService.insertUser(user) != 0) {
         System.out.println("성공");
         user.setPass("");
         User user2 = userService.getUser(userId);
         memberprofile.setName(user.getName());
         memberprofile.setProfile("다운로드.jpg");
         memberprofile.setUserId(user.getId());
         memberprofile.setNo(user2.getNo());
         userService.insertMemberprofile(memberprofile);

         // email 보내기테스트
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = null;
         SimpleEmail email1 = new SimpleEmail();
         email1.setHostName("smtp.naver.com");
         email1.setSmtpPort(465);
         email1.setAuthentication("kbsserver", "alsdn1991@");//니들 이메일 아이디 비밀번호 입력해서 써라
         

         // 보안연결 SSL, TLS 사용 설정
         email1.setSSLOnConnect(true);
         email1.setStartTLSEnabled(true);
         String response1 = "fail";
         try {
            // 보내는 사람 설정 (SMTP 서비스 로그인 계정 아이디와 동일하게 해야함에 주의!)
            email1.setFrom("kbsserver@naver.com", "멘투링관리자", "utf-8");
            // 받는 사람 설정
            email1.addTo(user.getEmail(), user.getEmail(), "utf-8");
            // 제목 설정
            email1.setSubject("ManTworing에서 쿠폰이 도착했습니다!");
            email1.setMsg("회원가입을 축하드립니다! 5%할인쿠폰이 발급되었습니다(유효기간:가입일로부터 3달)");
            // 메일 전송하기
            try {
               out = response.getWriter();
               response1 = email1.send();
               System.out.println("이메일 전송완료!");
            } catch (IOException e) {
               e.printStackTrace();
            }
         } catch (EmailException e) {
            e.printStackTrace();
         }
         //

         CouponVO coupon = new CouponVO();
         coupon.setDiscount_rate(5);
         coupon.setUserId(userId);
         coupon.setCoupon_name("회원가입축하쿠폰");
         couponService.insertCoupon(coupon);

         model.addAttribute("user", user);
         model.addAttribute("msgCode", "등록되었습니다. 로그인하여 주십시오.");// 등록성공
         
         rea.addAttribute("successCode","1");
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