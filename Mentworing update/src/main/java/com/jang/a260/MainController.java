package com.jang.a260;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jang.a260.model.BasketVO;
import com.jang.a260.model.ChatVO;
import com.jang.a260.model.CouponVO;
import com.jang.a260.model.CourseVO;
import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.MentorApprove;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.NotificationMemberVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.model.Video_recordVO;
import com.jang.a260.model.best_courseVO;
import com.jang.a260.model.menteelist_notification;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;
import com.jang.a260.service.BasketService;
import com.jang.a260.service.ChatService;
import com.jang.a260.service.MantorService;
import com.jang.a260.service.MenteeService;
import com.jang.a260.service.UserService;
import com.jang.a260.service.VideoService;
import com.jang.a260.utils.AES256Util;

@Controller(value = "mainController")
public class MainController {

	@Autowired // @Resource(name="userService")
	private UserService userService;

	@Autowired // @Resource(name="userService")
	private MantorService mantorService;

	@Autowired // @Resource(name="userService")
	private MenteeService menteeService;

	@Autowired // @Resource(name="userService")
	private ChatService chatService;

	@Autowired
	private BasketService basketService;

	@Autowired
	private VideoService videoService;

	String uploadPath = "C:\\upload\\"; // file upload path 전역변수로 파일 저장소 지정

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model, HttpSession session, HttpServletRequest request) {
		int notificationnumber = 0; // 읽지 않은메세지 목록
		int notificationsum = 0;
		int sumMessage=0;
		List<Video_recordVO> video_record = null;
		List<Video> video = mantorService.videoList();// 강의정보만 출력
		List<CourseVO> video2 = videoService.course_list(); // 멘토의 모든정보+ 강의정보
		model.addAttribute("video2", video2);
		List<best_courseVO> best_video = videoService.order_best_course();
		model.addAttribute("best_video", best_video); // 제일 잘팔린 비디오 3개출력
		System.out.println(best_video);
		List<NotificationMemberVO> notificationmember = new ArrayList<NotificationMemberVO>();

		String joinformdata = request.getParameter("successCode");
		if (joinformdata != null) {
			model.addAttribute("joinformdata", joinformdata);
		}

		model.addAttribute("video", video);
		String userId = (String) session.getAttribute("userId");
		if (userId != null) {
			User user = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴
			int userNo = 0;
			if (user != null) {
				userNo = user.getNo();
				video_record = videoService.List_video_record(userNo); // 해당하는 회원에게 어디까지 동영상을 시청했는지 알려주는 로직
			}

			String ma = userService.mentorregistercheck(userNo, "n");
			String mentoryn = mantorService.selectmentor(userNo);
			if (mentoryn == null) {

			} else {
				
				String[] paymentuserId = mantorService.getPaymentDetail_list();

				ArrayList<menteelist_notification> list = new ArrayList<menteelist_notification>();
				for (int i = 0; i < paymentuserId.length; i++) {
					User paymentuser = userService.getUser(paymentuserId[i]);
					int roomno = paymentuser.getNo() + userNo;
					int notificationnumber_Mentor = chatService.Chatmessage2Notification(roomno, paymentuser.getName(), "X");
					System.out.println(paymentuser.getName() + "님의 메세지갯수는" + notificationnumber);
					sumMessage+=notificationnumber_Mentor;
					list.add(new menteelist_notification(paymentuser.getName(), notificationnumber, roomno));

				}
				
				session.setAttribute("sumMessage", sumMessage);
				session.setAttribute("mentoryn", mentoryn);

			}

			// 메세지 개수를 알려주는 코드 헤더에 포함되는 메서드
			int[] mentornumber = menteeService.getpaymentdetail(userId);
			for (int i = 0; i < mentornumber.length; i++) {
				NotificationMemberVO member = new NotificationMemberVO();
				int no = mantorService.MentormnoToUserno(mentornumber[i]);
				System.out.println("멘토의 회원번호:" + no);
				User mentoruser = userService.getUserformento(no);
				int roomno = (userNo + no);
				System.out.println(roomno);
				System.out.println(mentoruser.getName());
				int mno = mantorService.UsernoToMentormno(no);
				MentorVO mentor = mantorService.selectmentorview(mno);
				notificationnumber = chatService.ChatmessageNotification(roomno, mentoruser.getName(), "X");
				System.out.println("읽지않은 메세지:" + notificationnumber);
				notificationsum = notificationsum + notificationnumber;
				member.setName(mentoruser.getName());
				member.setNotificationnumber(notificationnumber);
				member.setMemberprofile(mentor.getProfile());
				member.setMno(mentor.getMno());
				notificationmember.add(member);

			}

			List<BasketVO> basket = basketService.getBasket(userId);
			int basketcounting = basketService.basketcounting(userId);
			session.setAttribute("notificationmember", notificationmember);
			session.setAttribute("checkMessage", notificationsum);

			model.addAttribute("basketcounting", basketcounting);
			session.setAttribute("basketcounting", basketcounting);
			session.setAttribute("basket", basket);
			model.addAttribute("video_record", video_record);
			model.addAttribute("basket", basket);
			model.addAttribute("notificationmember", notificationmember);
			model.addAttribute("checkMessage", notificationsum);
			model.addAttribute("ma", ma);
			model.addAttribute("user", new User());
			return "main";
		}

		model.addAttribute("user", new User());
		return "main";
	}

	@RequestMapping(value = "/mento", method = RequestMethod.GET)
	public String mentopage(Model model) {

		model.addAttribute("user", new User());
		return "mento";
	}

	@RequestMapping(value = "/mentor_register", method = RequestMethod.GET)
	public String mentor_register(Model model, HttpSession session) {

		String userId = (String) session.getAttribute("userId");

		User user = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴

		int userNo = user.getNo();

		model.addAttribute("userNo", user.getNo());
		model.addAttribute("Mentor", new MentorApprove());
		return "mentor_register";
	}

	@RequestMapping(value = "/mentor_register", method = RequestMethod.POST)
	public String mentor_rigister_post(HttpSession session, HttpServletRequest request,
			MultipartHttpServletRequest requestt) {

		MentorApprove ma = new MentorApprove();
		int no = Integer.parseInt(request.getParameter("no"));
		;
		System.out.println(no);
		String certificate = request.getParameter("certificate");
		System.out.println(certificate);
		String major = request.getParameter("major");
		System.out.println(major);
		String mainintroduce = request.getParameter("mainintroduce").replace("\r\n", "<br>");
		System.out.println(mainintroduce);
		String officetype = request.getParameter("officetype");
		System.out.println(officetype);
		String headcomment = request.getParameter("headcomment").replace("\r\n", "<br>");
		System.out.println(headcomment);
		String rcmcomment = request.getParameter("rcmcomment").replace("\r\n", "<br>");
		System.out.println(rcmcomment);
		ma.setHeadcomment(headcomment);
		ma.setOfficetype(officetype);
		ma.setRcmcomment(rcmcomment);
		ma.setCertificate(certificate);
		ma.setMajor(major);
		ma.setMainintroduce(mainintroduce);
		ma.setNo(no);

		List<MultipartFile> fileList = requestt.getFiles("profile");

		for (MultipartFile mf : fileList) {
			if (!mf.isEmpty()) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈

				ma.setProfile(originFileName);
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

		// AWS 파일업로드
		System.out.println(ma.getProfile());
		Main main = new Main();
		File file = new File(uploadPath + ma.getProfile());

		String key = ma.getProfile();
		// String copyKey = "img/my-img-copy.img";

		// upload 실행하기.
		main.upload(file, key);
		userService.mentorregister(ma);
		return "redirect:/main";
	}

	@RequestMapping(value = "/mentor_register_list", method = RequestMethod.GET)
	public String mentor_register_list(Model model, HttpSession session) {

		String userId = (String) session.getAttribute("userId");
		User user = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴
		int userNo = user.getNo();

		List<MentorApprove> mentorlist = userService.selectmentorregister("w");
		model.addAttribute("Mentor", new MentorApprove());
		model.addAttribute("mentorlist", mentorlist);
		return "mentor_register_list";
	}

	@RequestMapping(value = "/userlist", method = RequestMethod.GET)
	public String userlist(@ModelAttribute("searchVO") SearchVO searchVO, Model model) {

		StringBuffer pageUrl = userService.getPageUrl(searchVO);
		model.addAttribute("pageHttp", pageUrl);
		model.addAttribute("user", new User());

		List<User> blist = userService.getUserList(searchVO);
		model.addAttribute("userList", blist);
		return "userlist";
	}

	@RequestMapping(value = "/mentor_register_ok", method = RequestMethod.GET)
	public String mentor_register_ok(HttpServletRequest request, Model model, HttpSession session) {

		int mano = Integer.parseInt(request.getParameter("mano"));
		int no = Integer.parseInt(request.getParameter("no"));
		if (mano != 0) {

			MentorApprove mentorlist = userService.getMentorApprove(mano);
			MentorApprove mentorApprove = new MentorApprove();
			// 멘토 승인여부 설정
			mentorApprove.setWithhold("Y");
			mentorApprove.setMano(mano);
			// 멘토테이블 멘토승인목록을 테이터를 집어넣음
			MentorVO mentor = new MentorVO();
			mentor.setMno(mentorlist.getMano());
			mentor.setNo(mentorlist.getNo());
			mentor.setCertificate(mentorlist.getCertificate());
			mentor.setIntroduce(mentorlist.getMainintroduce());
			mentor.setProfile(mentorlist.getProfile());
			mentor.setMajor(mentorlist.getMajor());
			mentor.setHeadcomment(mentorlist.getHeadcomment());
			mentor.setOfficetype(mentorlist.getOfficetype());
			mentor.setRcmcomment(mentorlist.getRcmcomment());
			userService.updateMentorApprove(mentorApprove);

			mantorService.insertMentor(mentor);

		}
		model.addAttribute("user", new User());
		return "redirect:/mentor_register_list";
	}

	@RequestMapping(value = "/mentor_register_list_delete", method = RequestMethod.GET)
	public String mentor_register_list_delete(HttpServletRequest request, Model model) {
		int mano = Integer.parseInt(request.getParameter("mano"));

		if (mano != 0) {
			MentorApprove mentorApprove = new MentorApprove();
			mentorApprove.setWithhold("N");
			mentorApprove.setMano(mano);
			userService.updateMentorApprove(mentorApprove);
		}
		model.addAttribute("user", new User());
		return "redirect:/mentor_register_list";
	}

	@RequestMapping(value = "/mentee_Mypage", method = RequestMethod.GET)
	public String mentee_Mypage(HttpServletRequest request, Model model, HttpSession session) throws Exception {

		String userId = (String) session.getAttribute("userId");
		User loginUser = this.userService.getUser(userId);
		MemberProfileVO memberprofile = userService.getUserProfile(userId);
		if (userService == null) {
			model.addAttribute("userId", "");
			model.addAttribute("msgCode", "등록되지않은 아이디입니다"); // 등록되지않은 아이디

			model.addAttribute("user", new User());
			return "/Mentee/mentee_Mypage";
		} else {
			model.addAttribute("user", loginUser);
			model.addAttribute("memberprofile", memberprofile);
			return "/Mentee/mentee_Mypage";
		}

	}

	@RequestMapping(value = "/mentee_Mypage", method = RequestMethod.POST)
	public String mentee_Mypage_post(@ModelAttribute User user, Model model, HttpSession session,
			MultipartHttpServletRequest requestt, HttpServletRequest request) throws Exception {

		String userId = (String) session.getAttribute("userId");
		String name = (String) session.getAttribute("userName");
		User loginUser = this.userService.getUser(userId);
		int no = loginUser.getNo();
		MemberProfileVO profilecheck = userService.getUserProfile(userId); // 멘토의 사진이 있는지 없는지 검증함

		MemberProfileVO memberprofile = new MemberProfileVO();

		if (profilecheck != null) { // 멘토프로필이 있으니 수정을해줘야하는 구간

			Main main = new Main();
			File file = new File(uploadPath + profilecheck.getProfile());

			String key = profilecheck.getProfile();
			// String copyKey = "img/my-img-copy.img";

			// upload 실행하기.

			// AWS에 있는 파일 삭제하기
			main.delete(key);

			List<MultipartFile> fileList = requestt.getFiles("profile");
			for (MultipartFile mf : fileList) {
				if (!mf.isEmpty()) {
					String originFileName = mf.getOriginalFilename(); // 원본 파일 명
					long fileSize = mf.getSize(); // 파일 사이즈

					memberprofile.setName(name);
					memberprofile.setNo(no);
					memberprofile.setUserId(userId);
					memberprofile.setProfile(originFileName);
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
			File file2 = new File(uploadPath + memberprofile.getProfile());

			String key2 = memberprofile.getProfile();
			// String copyKey = "img/my-img-copy.img";

			// upload 실행하기.
			main.upload(file2, key2);
			userService.updateMemberprofile(memberprofile);

		} else { // 멘토프로필이 없으니 새롭게 삽입을 해줘야하는구간
			List<MultipartFile> fileList = requestt.getFiles("profile");

			for (MultipartFile mf : fileList) {
				if (!mf.isEmpty()) {
					String originFileName = mf.getOriginalFilename(); // 원본 파일 명
					long fileSize = mf.getSize(); // 파일 사이즈

					memberprofile.setName(name);
					memberprofile.setNo(no);
					memberprofile.setUserId(userId);
					memberprofile.setProfile(originFileName);
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

			userService.insertMemberprofile(memberprofile);
			// AWS 파일업로드
			System.out.println(memberprofile.getProfile());
			Main main = new Main();
			File file = new File(uploadPath + memberprofile.getProfile());

			String key = memberprofile.getProfile();
			// String copyKey = "img/my-img-copy.img";

			// upload 실행하기.
			main.upload(file, key);
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
			return "/Mentee/mentee_Mypage";
		} else {
			model.addAttribute("msgCode", "사용자 정보수정에 실패하였습니다");
			System.out.println("회원정보수정실패");
			return "/Mentee/mentee_Mypage";
		}
	}

	@RequestMapping(value = "/mentee_Mypage_paymentlist", method = RequestMethod.GET)
	public String mentee_Mypage_paymentlist(HttpSession session, Model model) {

		String userId = (String) session.getAttribute("userId");
		List<paymentVO> paymentlist = menteeService.getpaymentVO(userId);
		List<paymentDetailVO> paymentdetaillist = menteeService.getpaymentdetailList_menteevideo();

		model.addAttribute("userId", userId);
		model.addAttribute("paymentdetaillist", paymentdetaillist);
		model.addAttribute("paymentlist", paymentlist);
		model.addAttribute("user", new User());
		return "/Mentee/mentee_Mypage_paymentlist";
	}

	@RequestMapping(value = "/main_class", method = RequestMethod.GET)
	public String main_class(HttpServletRequest request, HttpSession session, Model model) {

		String videotype = (String) request.getParameter("videotype");
		System.out.println(videotype);
		List<Video> video = mantorService.videoListvideotype(videotype);
		model.addAttribute("video", video); // 모든 비디오 출력
		String userId = (String) session.getAttribute("userId");
		if (userId != null) {
			User user = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴
			int userNo = user.getNo();
			String ma = userService.mentorregistercheck(userNo, "n");
			String mentoryn = mantorService.selectmentor(userNo);
			if (mentoryn == null) {

			} else {
				session.setAttribute("mentoryn", mentoryn);

			}

			model.addAttribute("ma", ma);
			model.addAttribute("user", new User());
			return "main";
		}

		model.addAttribute("user", new User());
		return "/main_class";
	}

	@RequestMapping(value = "/mentee_MyPage_certificate", method = RequestMethod.GET)
	public String mentee_MyPage_certificate(HttpSession session, Model model) {

		String userId = (String) session.getAttribute("userId");
		String authenticationId_check=userService.check_authenticationId(userId);
		System.out.println("인증"+authenticationId_check);
		
		
		if(authenticationId_check==null) {
			model.addAttribute("authenticationId_check","checkout");
		}
		
		if (authenticationId_check!=null && authenticationId_check.equals("ON")) {
			model.addAttribute("authenticationId_check","checkin");
		}
		
		model.addAttribute("userId", userId);
		return "/Mentee/mentee_MyPage_certificate";
	}

}
