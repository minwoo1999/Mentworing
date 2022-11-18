package com.jang.a260;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jang.a260.model.BasketVO;
import com.jang.a260.model.BoardVO;
import com.jang.a260.model.ChatVO;
import com.jang.a260.model.IncomeVO;
import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.Mentee_list_VO;
import com.jang.a260.model.MentorApprove;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.NotificationMemberVO;
import com.jang.a260.model.ReviewVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.model.Video_recordVO;
import com.jang.a260.model.menteelist_notification;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;
import com.jang.a260.service.BasketService;
import com.jang.a260.service.BoardService;
import com.jang.a260.service.ChatService;
import com.jang.a260.service.MantorService;
import com.jang.a260.service.MenteeService;
import com.jang.a260.service.UserService;
import com.jang.a260.service.VideoService;
import com.jang.a260.utils.WebSocketConfig;

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
	private BoardService boardService;
	
	@Autowired
	private VideoService videoService;



	@Autowired
	private ChatService chatService;

	String uploadPath = "C:\\upload\\"; // file upload path 전역변수로 파일 저장소 지정

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
		int roomno=0;
		User user = new User();
		MentorVO mentor = new MentorVO();
		String paymentIdsuccess = null; // 결제 됐는지 확인
		String review_check = null;
		String name = (String) session.getAttribute("userName");
		String userId = (String) session.getAttribute("userId");

		mno = Integer.parseInt(request.getParameter("mno"));
		User u=userService.getUser(userId);
		
		
		review_check = request.getParameter("review_check");
		mentor = mantorService.selectmentorview(mno);

		if (userId != null) {
			MemberProfileVO memberprofile = userService.getUserProfile(userId); // 멘토의 사진이 있는지 없는지 검증함

			if (memberprofile != null) {
				model.addAttribute("memberprofile", memberprofile);
			} else {
				model.addAttribute("memberprofile", "");
			}

			int no = mentor.getNo();
			System.out.println(no+"zzz"+u.getNo()+"총합 방번호"+roomno);
			roomno=no+u.getNo();
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

				}

				model.addAttribute("paymentId", paymentIdsuccess);
				model.addAttribute("chatVO", chatvo);// 채팅리스트
			}
		}
		
		MentorVO mentorinfo=mantorService.selectmentorview(mno);
		User mentorinformation=userService.getUserformento(mentorinfo.getNo());

		System.out.println(count);
		System.out.println(paymentIdsuccess);
		model.addAttribute("videolist", videolist);// 비디오 리스트
		model.addAttribute("mno", mno); // 해당하는 멘토만 나오게하기
		model.addAttribute("name", name);// 유저이름
		model.addAttribute("userId", userId);// 유저아이디
		model.addAttribute("review_check", review_check);
		model.addAttribute("mentorname", mentorinformation.getName()); // 멘토이름
		model.addAttribute("mentor", mentor);// 멘토리스트
		model.addAttribute("mentorprofile", "");
		model.addAttribute("roomno",roomno);
		session.setAttribute("roomno",roomno);
		model.addAttribute("user", new User());
		System.out.println("멘토의 이름:" + user.getName());
		System.out.println("멘티의 이름:" + name);
		System.out.println(review_check);
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

		
		//테스트
		
		
		//비디오 기록 리스트 가져오기
		
		List<Video_recordVO> video_record=videoService.select_all_vieow_record();
		
		
		model.addAttribute("video_record",video_record);
		
		List<Mentee_list_VO> mentee_list=mantorService.mentee_list();
		
		model.addAttribute("mentee_list",mentee_list);
		
		//
		int sumMessage=0; //총 메세지 갯수
		
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
		List<MemberProfileVO> memberProfile = userService.UserProfileList();
		MentorVO mentor = mantorService.selectmentorview(mno);
		List<Video> video = mantorService.videoList();

		int no = mentor.getNo();

		// 결제가 되었는지 확인하는과정
		int mentormno = mentor.getMno();

		chatvo = chatService.getChatList();
		model.addAttribute("chatVO", chatvo);// 채팅리스트

		model.addAttribute("video", video);
		model.addAttribute("memberProfile", memberProfile);// 유저 프로파일
		model.addAttribute("mentorname", user.getName()); // 멘토이름
		// 채팅 end
		model.addAttribute("userlist", userlist);
		model.addAttribute("mno", mno);
		model.addAttribute("mentor", mentor);
		model.addAttribute("mentorprofile", mentor.getProfile());
		model.addAttribute("paymentlist", paymentList);
		model.addAttribute("user", new User());
		model.addAttribute("name", name);

		// 멘티별 채팅 갯수 가져오기

		String[] paymentuserId = mantorService.getPaymentDetail_list();

		ArrayList<menteelist_notification> list = new ArrayList<menteelist_notification>();
		for (int i = 0; i < paymentuserId.length; i++) {
			User paymentuser = userService.getUser(paymentuserId[i]);
			int roomno = paymentuser.getNo() + userNo;
			int notificationnumber = chatService.Chatmessage2Notification(roomno, paymentuser.getName(), "X");
			System.out.println(paymentuser.getName() + "님의 메세지갯수는" + notificationnumber);
			sumMessage+=notificationnumber;
			list.add(new menteelist_notification(paymentuser.getName(), notificationnumber, roomno));

		}
		
		session.setAttribute("sumMessage", sumMessage);
		
		model.addAttribute("sumMessage",sumMessage); //총 메세지 갯수
		model.addAttribute("list", list);

		return "/Mentor/mente_list";
	}

	@ResponseBody
	@RequestMapping(value = "/mente_list_getchatname", method = RequestMethod.GET)
	public List<ChatVO> mente_list_getchatname(HttpServletRequest request, Model model, HttpSession session)
			throws Exception {

		// 채팅방 헤더를 위한 소스
		int notificationnumber = 0; // 읽지 않은메세지 목록
		int notificationsum = 0;
		int menteelist_roomno = 0;
		List<NotificationMemberVO> notificationmember = new ArrayList<NotificationMemberVO>();

		String userId = (String) session.getAttribute("userId");

		// json을 위한 소스

		Gson gson = new Gson();
		JsonObject object = new JsonObject();
		int roomno = 0;
		List<ChatVO> chatvo = null;

		String mysession = (String) session.getAttribute("userName"); // 내가 로그인한 아이디값
		String name = request.getParameter("name");// 멘토가 멘티별 채팅을 할때 넘기는 멘티명단
		if (name != null) {
			menteelist_roomno = Integer.parseInt(request.getParameter("roomno"));
		}

		String mentorviewmentor = request.getParameter("mentorname");// 멘티가 멘토와 채팅을 하기위해 넘기는 멘토의 네임
		System.out.println("방번호:" + menteelist_roomno);
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
			chatService.updateChatmessage2(menteelist_roomno, "O", name);
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

				System.out.println(mentoruser.getName() + "" + roomno + "X");
				notificationnumber = chatService.ChatmessageNotification(roomno2, mentoruser.getName(), "X");
				System.out.println("읽지않은 메세지:" + notificationnumber);
				System.out.println(roomno);
				System.out.println(roomno2);
				if (roomno == roomno2) {
					member.setName(mentoruser.getName());
					member.setNotificationnumber(0);
					member.setMemberprofile(mentor.getProfile());
					member.setMno(mentor.getMno());
					notificationmember.add(member);
				} else {
					member.setName(mentoruser.getName());
					member.setNotificationnumber(notificationnumber);
					member.setMemberprofile(mentor.getProfile());
					member.setMno(mentor.getMno());
					notificationmember.add(member);
				}

				notificationsum = notificationsum + notificationnumber;
				System.out.println("메세지 총" + notificationsum);

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

	@RequestMapping(value = "/Mentor_Mypage", method = RequestMethod.GET)
	public String Mentor_Mypage(@ModelAttribute("searchVO") SearchVO searchVO, Model model, HttpSession session)
			throws Exception {

		String userId = (String) session.getAttribute("userId");
		User loginUser = this.userService.getUser(userId);
		int mno = mantorService.UsernoToMentormno(loginUser.getNo());
		MentorVO mentorprofile = mantorService.selectmentorview(mno);
		System.out.println(mentorprofile.getProfile());
		if (userService == null) {
			model.addAttribute("userId", "");
			model.addAttribute("msgCode", "등록되지않은 아이디입니다"); // 등록되지않은 아이디

			model.addAttribute("user", new User());
			return "/Mentor/Mentor_Mypage";
		} else {
			model.addAttribute("user", loginUser);
			model.addAttribute("memberprofile", mentorprofile.getProfile());
			return "/Mentor/Mentor_Mypage";
		}

	}

	@RequestMapping(value = "/mentee_Mypage", method = RequestMethod.POST)
	public String Mentor_Mypage_Post(@ModelAttribute User user, Model model, HttpSession session,
			MultipartHttpServletRequest requestt, HttpServletRequest request) throws Exception {

		String userId = (String) session.getAttribute("userId");
		String name = (String) session.getAttribute("userName");
		User loginUser = this.userService.getUser(userId);
		int mno = mantorService.UsernoToMentormno(loginUser.getNo());
		MentorVO mentorprofile = mantorService.selectmentorview(mno);

		if (userId != null) { // 멘토프로필이 있으니 수정을해줘야하는 구간

			Main main = new Main();
			File file = new File(uploadPath + mentorprofile.getProfile());

			String key = mentorprofile.getProfile();
			// String copyKey = "img/my-img-copy.img";

			// upload 실행하기.

			// AWS에 있는 파일 삭제하기
			main.delete(key);

			List<MultipartFile> fileList = requestt.getFiles("profile");
			for (MultipartFile mf : fileList) {
				if (!mf.isEmpty()) {
					String originFileName = mf.getOriginalFilename(); // 원본 파일 명
					long fileSize = mf.getSize(); // 파일 사이즈
					mentorprofile.setProfile(originFileName);
			
					String safeFile = uploadPath + originFileName; // 디스크에 파일 저장
					try {
						mf.transferTo(new File(safeFile)); // 디스크에 파일 저장
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			File file2 = new File(uploadPath + mentorprofile.getProfile());

			String key2 = mentorprofile.getProfile();
			// String copyKey = "img/my-img-copy.img";

			// upload 실행하기.
			main.upload(file2, key2);
			mantorService.updatementorprofile(mentorprofile);

		}

		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashPass = passwordEncoder.encode(user.getPass());
		user.setPass(hashPass);

		user.setBirthday(loginUser.getBirthday());

		if (this.userService.updateUser(user) != 0) {
			user.setPass("");
			model.addAttribute("msgCode", "사용자 정보수정가 수정되었습니다");
			System.out.println("회원정보수정완료");
			model.addAttribute("user", user);
			return "/Mentor/Mentor_Mypage";
		} else {
			model.addAttribute("msgCode", "사용자 정보수정에 실패하였습니다");
			System.out.println("회원정보수정실패");
			return "/Mentor/Mentor_Mypage";
		}
	}

	@RequestMapping(value = "/Mentor_Mypage_Chart", method = RequestMethod.GET)
	public String Mentor_Mypage_chart(@ModelAttribute("searchVO") SearchVO searchVO, Model model, HttpSession session)
			throws Exception {
		String userId = (String) session.getAttribute("userId");
		String name = (String) session.getAttribute("userName");
		System.out.println(userId);
		User loginUser = this.userService.getUser(userId);
		int mno = mantorService.UsernoToMentormno(loginUser.getNo());

		return "/Mentor/Mentor_Mypage_chart";

	}

	@RequestMapping(value = "incomeList", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")

	public @ResponseBody String incomeList(HttpSession session, Model model) {

		String userId = (String) session.getAttribute("userId");
		String name = (String) session.getAttribute("userName");
		User loginUser = this.userService.getUser(userId);
		int mno = mantorService.UsernoToMentormno(loginUser.getNo());

		Gson gson = new Gson();

		List<IncomeVO> list = mantorService.selectChartsumprice(mno, "2022-01-01", "2022-12-31");

		System.out.println(list);

		return gson.toJson(list);

	}

	@RequestMapping(value = "chartsearch", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")

	public @ResponseBody String chartsearch(HttpSession session, Model model, HttpServletRequest request) {

		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");

		System.out.println(start_date);
		System.out.println(end_date);

		String userId = (String) session.getAttribute("userId");
		String name = (String) session.getAttribute("userName");
		User loginUser = this.userService.getUser(userId);
		int mno = mantorService.UsernoToMentormno(loginUser.getNo());

		Gson gson = new Gson();

		List<IncomeVO> list = mantorService.selectChartsumprice(mno, start_date, end_date);

		System.out.println(list);

		return gson.toJson(list);

	}

	@RequestMapping(value = "/chat_multipartUpload", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String chat_multipartUpload(MultipartHttpServletRequest request) throws Exception {

		Gson gson = new Gson();
		JsonObject object = new JsonObject();

		List<MultipartFile> fileList = request.getFiles("file");

		File fileDir = new File(uploadPath);
		System.out.println("ajax chat_multipartupload");
		if (!fileDir.exists()) {
			fileDir.mkdirs();
		}
		System.out.println("ajax chat_multipartupload2");
		long time = System.currentTimeMillis();

		for (MultipartFile mf : fileList) {

			String originFileName = mf.getOriginalFilename(); // 원본 파일 명
			System.out.println(originFileName);
			String safeFile = uploadPath + originFileName; // 디스크에 파일 저장
			System.out.println(safeFile);

			try {
				// 파일생성
				System.out.println("파일생성");
				mf.transferTo(new File(uploadPath, originFileName));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (fileList != null) {
			object.addProperty("msg", "false");
			return gson.toJson(object).toString();
		} else {
			object.addProperty("msg", "true");
			return gson.toJson(object).toString();
		}

	}

	@RequestMapping(value = "/Mentorview_Review", method = RequestMethod.GET)
	public String Mentorview_Review(@ModelAttribute("searchVO") SearchVO seachVO, HttpServletRequest request,
			Model model, RedirectAttributes ream, HttpSession session) throws Exception {

		
		List<ChatVO> chatvo = null;
		int count = 0;
		int mno = 0;
		User user = new User();
		MentorVO mentor = new MentorVO();
		String paymentIdsuccess = null; // 결제 됐는지 확인
		String review_check = null;
		String name = (String) session.getAttribute("userName");
		String userId = (String) session.getAttribute("userId");

		mno = Integer.parseInt(request.getParameter("mno"));
		review_check = request.getParameter("review_check");
		mentor = mantorService.selectmentorview(mno);
		
		List<ReviewVO> mentorreview=boardService.Mentorview_getMentorReview(mno);

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

				}

				model.addAttribute("paymentId", paymentIdsuccess);
				model.addAttribute("chatVO", chatvo);// 채팅리스트
			}
		}

		System.out.println(count);
		System.out.println(paymentIdsuccess);
		model.addAttribute("mentorreview",mentorreview);
		model.addAttribute("mno", mno); // 해당하는 멘토만 나오게하기
		model.addAttribute("name", name);// 유저이름
		model.addAttribute("userId", userId);// 유저아이디
		model.addAttribute("review_check", review_check);
		model.addAttribute("mentorname", user.getName()); // 멘토이름
		model.addAttribute("mentor", mentor);// 멘토리스트
		model.addAttribute("mentorprofile", "");
		model.addAttribute("user", new User());
		model.addAttribute("mentorreview",mentorreview);
		System.out.println("멘토의 이름:" + user.getName());
		System.out.println("멘티의 이름:" + name);
		System.out.println(review_check);

		return "../views/Mentor/Mentorview_Review";

	}

}
