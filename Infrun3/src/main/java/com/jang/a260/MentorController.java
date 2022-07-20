package com.jang.a260;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jang.a260.model.BasketVO;
import com.jang.a260.model.BoardVO;
import com.jang.a260.model.ChatVO;
import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.MentorApprove;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.NotificationMemberVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;
import com.jang.a260.service.BasketService;
import com.jang.a260.service.BoardService;
import com.jang.a260.service.ChatService;
import com.jang.a260.service.MantorService;
import com.jang.a260.service.MenteeService;
import com.jang.a260.service.UserService;

@Controller
@RequestMapping("/Mentor")
public class MentorController {

   @Autowired
   private MantorService mantorService;

   @Autowired
   private UserService userService;

   @Autowired // @Resource(name="userService")
   private MenteeService menteeService;

   @Autowired
   private BasketService basketService;

   @Autowired
   private ChatService chatService;

   @RequestMapping(value = "/Mentor_list", method = RequestMethod.GET)
   public String Mentor_list(@ModelAttribute("searchVO") SearchVO searchVO, Model model, HttpSession session)
         throws Exception {
      List<NotificationMemberVO> notificationmember = new ArrayList<NotificationMemberVO>();
      List<MentorVO> mentorlist = mantorService.mentorList();

      List<User> userlist = userService.selectAlluser();
      String userId = (String) session.getAttribute("userId");

      model.addAttribute("mentorlist", mentorlist);
      model.addAttribute("userlist", userlist);
      model.addAttribute("user", new User());

      return "/Mentor/Mentor_list";
   }

   @RequestMapping(value = "/Mentorview", method = RequestMethod.GET)
   public String Mentorview(HttpServletRequest request, Model model, HttpSession session) throws Exception {
      List<Video> videolist = mantorService.videoList();// 비디오가져오기
      List<ChatVO> chatvo = null;
      int count = 0;
      int mno = 0;
      User user = new User();
      MentorVO mentor = new MentorVO();
      String paymentIdsuccess = null; // 결제 됐는지 확인
      String name = (String) session.getAttribute("userName");
      String userId = (String) session.getAttribute("userId");

      mno = Integer.parseInt(request.getParameter("mno"));
      mentor = mantorService.selectmentorview(mno);

      if (userId != null) {
         MemberProfileVO memberprofile = userService.getUserProfile(userId); // 멘토의 사진이 있는지 없는지 검증함

         if (memberprofile != null) {
            model.addAttribute("memberprofile", memberprofile);
         } else {
            model.addAttribute("memberprofile", "");
         }

         int no = mentor.getNo();
         user = userService.getUserformento(no);

         // 결제가 되었는지 확인하는과정

         int mentormno = mentor.getMno();

         if (userId != null) {
            String[] paymentId = mantorService.getpaymentcheck(userId, mentormno);

            chatvo = chatService.getChatList();

            for (int i = 0; i < paymentId.length; i++) {
               if (paymentId[i].equals(userId)) {// 세션으로 들어온 아이뒤와 해당하는 멘토와 결제를 한 아아디가 일치를 한경우
                  count += 1;
                  paymentIdsuccess = paymentId[i];
               }
               else {
            	   
               }

            }

            model.addAttribute("paymentId", paymentIdsuccess);
            model.addAttribute("chatVO", chatvo);// 채팅리스트
         }
      }

      System.out.println(count);
      System.out.println(paymentIdsuccess);
      model.addAttribute("videolist", videolist);// 비디오 리스트
      model.addAttribute("mno", mno); // 해당하는 멘토만 나오게하기
      model.addAttribute("name", name);// 유저이름
      model.addAttribute("mentorname", user.getName()); // 멘토이름
      model.addAttribute("mentor", mentor);// 멘토리스트
      model.addAttribute("mentorprofile", "");
      model.addAttribute("user", new User());
      System.out.println("멘토의 이름:" + user.getName());
      System.out.println("멘티의 이름:" + name);
      return "/Mentor/Mentorview";
   }

   @RequestMapping(value = "/Mentorview", method = RequestMethod.POST)
   public String MentorviewTobasket(HttpServletRequest request, Model model, HttpSession session) throws Exception {

      String userId = (String) session.getAttribute("userId");

      String[] value = request.getParameterValues("vno");
      int[] intvalue = new int[value.length];

      for (int i = 0; i < value.length; i++) {
         intvalue[i] = Integer.parseInt(value[i]);
         BasketVO basket = new BasketVO();
         Video video = mantorService.getvideoview(intvalue[i]);
         basket.setPrice(video.getVideoprice());
         basket.setTitle(video.getVideoname());
         basket.setUserId(userId);
         basket.setVno(intvalue[i]);
         basket.setBfilename(video.getVideofile());

         basketService.insertbasket(basket);
         System.out.println(intvalue[i] + "등록성공");
      }
      return "redirect:/basket/mainbasket";
   }

   @RequestMapping(value = "/mente_list", method = RequestMethod.GET)
   public String mente_list(@ModelAttribute("searchVO") SearchVO searchVO, HttpSession session,
         HttpServletRequest request, Model model) {

      List<ChatVO> chatvo = null;
      List<User> userlist = userService.selectAlluser();
      String userId = (String) session.getAttribute("userId");
      String name = (String) session.getAttribute("userName");

      User user = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴
      int userNo = user.getNo();
      int mno = mantorService.UsernoToMentormno(userNo); // 세션값을 이용한 멘토번호 조회

      StringBuffer pageUrl = mantorService.getPageUrl(searchVO);
      model.addAttribute("pageHttp", pageUrl);
      List<paymentDetailVO> paymentList = mantorService.getpaymentdetailList(searchVO);

      // 채팅내역가져오는곳

      MentorVO mentor = mantorService.selectmentorview(mno);

      int no = mentor.getNo();

      // 결제가 되었는지 확인하는과정
      int mentormno = mentor.getMno();

      chatvo = chatService.getChatList();
      model.addAttribute("chatVO", chatvo);// 채팅리스트

      model.addAttribute("mentorname", user.getName()); // 멘토이름
      // 채팅 end
      model.addAttribute("userlist", userlist);
      model.addAttribute("mno", mno);
      model.addAttribute("mentor", mentor);
      model.addAttribute("mentorprofile", mentor.getProfile());
      model.addAttribute("paymentlist", paymentList);
      model.addAttribute("user", new User());
      model.addAttribute("name", name);

      return "/Mentor/mente_list";
   }

   @ResponseBody
   @RequestMapping(value = "/mente_list_getchatname", method = RequestMethod.GET)
   public List<ChatVO> mente_list_getchatname(HttpServletRequest request, Model model, HttpSession session)
         throws Exception {

      // 채팅방 헤더를 위한 소스
      int notificationnumber = 0; // 읽지 않은메세지 목록
      int notificationsum = 0;
      List<NotificationMemberVO> notificationmember = new ArrayList<NotificationMemberVO>();

      String userId = (String) session.getAttribute("userId");

      // json을 위한 소스

      Gson gson = new Gson();
      JsonObject object = new JsonObject();
      int roomno = 0;
      List<ChatVO> chatvo = null;

      String mysession = (String) session.getAttribute("userName"); // 내가 로그인한 아이디값
      String name = request.getParameter("name");// 멘토가 멘티별 채팅을 할때 넘기는 멘티명단
      String mentorviewmentor = request.getParameter("mentorname");// 멘티가 멘토와 채팅을 하기위해 넘기는 멘토의 네임

      // 멘토가 여러명의 멘티를 확인하는과정 멘토가 멘티와 채팅할때
      if (mentorviewmentor == null) {
         System.out.println("멘토이름" + mysession.toString());
         System.out.println("상대이름" + name.toString());
         String[] user = userService.selectchattingname(mysession.toString());
         String[] yourName = userService.selectchattingname(name.toString());
         for (int i = 0; i < user.length; i++) {
            roomno = Integer.parseInt(user[i]) + Integer.parseInt(yourName[i]);

         }
         chatService.updateChatmessage(roomno, "O", name.toString());
         chatvo = chatService.getChatListforuserId(roomno);
      } else {// 멘토뷰에서 들어왔을 경우
         System.out.println("멘티이름" + mysession.toString());
         System.out.println("멘토이름" + mentorviewmentor.toString());
         String[] user = userService.selectchattingname(mysession.toString());
         String[] yourName = userService.selectchattingname(mentorviewmentor.toString());
         for (int i = 0; i < user.length; i++) {
            roomno = Integer.parseInt(user[i]) + Integer.parseInt(yourName[i]);

         }
         chatService.updateChatmessage(roomno, "O", mentorviewmentor.toString());
         chatvo = chatService.getChatListforuserId(roomno);
      }

      // 채팅방 읽지않은 메세지를 체크하는 과정

      if (userId != null) {
         User user2 = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴
         int userNo = user2.getNo();

         // 메세지 개수를 알려주는 코드 헤더에 포함되는 메서드
         int[] mentornumber = menteeService.getpaymentdetail(userId);
         for (int i = 0; i < mentornumber.length; i++) {
            NotificationMemberVO member = new NotificationMemberVO();
            int no = mantorService.MentormnoToUserno(mentornumber[i]);
            User mentoruser = userService.getUserformento(no);
            
            int roomno2 = (userNo + no);
            int mno = mantorService.UsernoToMentormno(no);
            MentorVO mentor = mantorService.selectmentorview(mno);
            
            System.out.println(mentoruser.getName()+""+roomno+"X");
            notificationnumber = chatService.ChatmessageNotification(roomno2, mentoruser.getName(), "X");
            System.out.println("읽지않은 메세지:" + notificationnumber);
            System.out.println(roomno);
            System.out.println(roomno2);
            if(roomno==roomno2) {
               member.setName(mentoruser.getName());
               member.setNotificationnumber(0);
               member.setMemberprofile(mentor.getProfile());
               member.setMno(mentor.getMno());
               notificationmember.add(member);
            }
            else {
               member.setName(mentoruser.getName());
               member.setNotificationnumber(notificationnumber);
               member.setMemberprofile(mentor.getProfile());
               member.setMno(mentor.getMno());
               notificationmember.add(member);
            }
            
            notificationsum = notificationsum + notificationnumber;
            System.out.println("메세지 총"+notificationsum);
            

         }
         // 채팅 초기화
         session.setAttribute("checkMessage", notificationsum);
         session.setAttribute("notificationmember", notificationmember);

      }

      //

      if (name != null || mentorviewmentor != null) {
         object.addProperty("msg", "true");
         System.out.println(gson.toJson(object).toString());
         return chatvo;
      } else {
         object.addProperty("msg", "false");
         System.out.println(gson.toJson(object).toString());
         return chatvo;
      }

   }

}
