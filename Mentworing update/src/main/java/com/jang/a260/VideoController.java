package com.jang.a260;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.jang.a260.mapper.MenteeMapper;
import com.jang.a260.mapper.VideoMapper;
import com.jang.a260.model.CourseVO;
import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.model.VideoApplyVO;
import com.jang.a260.model.Video_recordVO;
import com.jang.a260.model.Videoview_videolist;
import com.jang.a260.model.best_courseVO;
import com.jang.a260.service.MantorService;
import com.jang.a260.service.MenteeService;
import com.jang.a260.service.UserService;
import com.jang.a260.service.VideoService;

@Controller
@RequestMapping("/Mentor")
public class VideoController {

	@Autowired
	private MantorService mantorService;

	@Autowired
	private MenteeService menteeService;

	@Autowired
	private UserService userService;

	@Autowired
	private VideoService videoService;

	String uploadPath = "C:\\upload\\"; // file upload path 전역변수로 파일 저장소 지정

	@RequestMapping(value = "videoupload", method = RequestMethod.GET)
	public String videoupload(HttpServletRequest request, HttpSession session, Model model) throws Exception {

		String userId = (String) session.getAttribute("userId");
		System.out.println(userId);

		User user = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴
		int userNo = user.getNo();
		int mno = mantorService.UsernoToMentormno(userNo); // 세션값을 이용한 멘토번호 조회

		model.addAttribute("mno", mno);
		model.addAttribute("Video", new Video());
		return "/Mentor/videoupload";
	}

	@RequestMapping(value = "/videoupload", method = RequestMethod.POST)
	public String videouploadpost(HttpServletRequest request, HttpSession session, Model model,
			MultipartHttpServletRequest requestt) throws Exception {

		int mno = Integer.parseInt(request.getParameter("mno"));
		String videotype = request.getParameter("videotype");
		String videoprice = request.getParameter("videoprice");
		String videoname = request.getParameter("videoname");
		String videointroduce = request.getParameter("videointroduce").replace("\r\n", "<br>");

		List<MultipartFile> fileList = requestt.getFiles("videofile");
		System.out.println(mno);
		System.out.println(videotype);
		System.out.println(videoprice);
		System.out.println(videoname);
		System.out.println(videointroduce);
		System.out.println(fileList);
		Video video = new Video();

		for (MultipartFile mf : fileList) {
			if (!mf.isEmpty()) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈

				video.setVideofile(originFileName);
				video.setMno(mno);
				video.setVideointroduce(videointroduce);
				video.setVideoname(videoname);
				video.setVideoprice(videoprice);
				video.setVideotype(videotype);
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
		System.out.println(video.getVideofile());
		/** 업로드 잠깐 주석처리 js에서 업로드 실행테스트중
		
		Main main = new Main();
		File file = new File(uploadPath + video.getVideofile());

		String key = video.getVideofile();

		// String copyKey = "img/my-img-copy.img";
		// upload 실행하기.

		main.upload(file, key);
		**/
		mantorService.insertVideo(video);
		return "redirect:/Mentor/Myvideo";
	}

	@RequestMapping(value = "/videoview", method = RequestMethod.GET)
	public String videoview(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		String paycheckvno = null;
		Video_recordVO video_record = new Video_recordVO();
		User user2 = new User();
		String starttime = null;
		String userId = (String) session.getAttribute("userId");
		List<CourseVO> video_recommend = videoService.course_list();
		model.addAttribute("video_recommend",video_recommend);
		if (userId != null) {
			user2 = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴
			starttime = request.getParameter("starttime");
			
		}

		int vno = Integer.parseInt(request.getParameter("vno"));
		
		if (starttime != null) {
			video_record.setNo(user2.getNo());
			video_record.setVideo_record(Integer.parseInt(starttime));
			video_record.setVno(vno);
			videoService.update_video_record(video_record);
		}

		String applycheck = request.getParameter("applycheck");

		if (userId != null) {
			paycheckvno = menteeService.paymentdetail_vnocheck(userId, vno);
			List<Videoview_videolist> videoview_videolist=videoService.videoview_get_videolist(userId);
			List<best_courseVO> videoview_payment_count=videoService.vidoeview_get_payment_count();
			model.addAttribute("videoview_videolist",videoview_videolist);
			model.addAttribute("videoview_payment_count",videoview_payment_count);
		}
		if (userId == null || paycheckvno == null) {
			model.addAttribute("paycheckvno", "0");
		} else {
			model.addAttribute("paycheckvno", "1");
		}

		Video video = mantorService.getvideoview(vno);
		MentorVO mentor = mantorService.selectmentorview(video.getMno()); // 해당하는 멘토의정보를 가져오김
		List<VideoApplyVO> apply = mantorService.getVideoApply(vno);
		User user = userService.getUserformento(mentor.getNo());
		if (userId != null) {
			
			
			User loginUser = this.userService.getUser(userId);
			if(mantorService.UsernoToMentormno(loginUser.getNo())!=null) {
				MentorVO mentorprofile = mantorService.selectmentorview(mantorService.UsernoToMentormno(loginUser.getNo()));
				model.addAttribute("profile", mentorprofile.getProfile());
				
			}
			else {
				MemberProfileVO profile = userService.getUserProfile(userId);

				model.addAttribute("profile", profile.getProfile());
			}
			
			

			Video_recordVO record = videoService.get_video_record_DTO(vno, user2.getNo());
			if(record!=null) {
				model.addAttribute("record", record.getVideo_record());
			}
			

		}

		// 비디오를 어느만큼 시청했는지 가져오기

		System.out.println(apply);
		System.out.println(applycheck);

		model.addAttribute("applycheck", applycheck);
		model.addAttribute("apply", apply);
		model.addAttribute("mentorprofile", mentor.getProfile());
		model.addAttribute("mno", mentor.getMno());
		model.addAttribute("userName", user.getName());
		model.addAttribute("userId", userId);
		model.addAttribute("video", video);
		model.addAttribute("user", new User());
		return "/Mentor/videoview";
	}

	@RequestMapping(value = "/videoview", method = RequestMethod.POST)
	public String videoviewpost(@ModelAttribute VideoApplyVO videoapply, Model model, RedirectAttributes rea)
			throws Exception {
		List<VideoApplyVO> apply = null;
		System.out.println(videoapply.getContent());
		System.out.println(videoapply.getProfile());
		System.out.println(videoapply.getUserId());
		System.out.println(videoapply.getVno());
		if (videoapply.getContent() != null) {
			mantorService.insertVideoApply(videoapply);
			apply = mantorService.getVideoApply(videoapply.getVno());
			rea.addAttribute("vno", videoapply.getVno());
			rea.addAttribute("applycheck", "true");
		}

		return "redirect:/Mentor/videoview";
	}

	@RequestMapping(value = "/delete_video_apply", method = RequestMethod.GET)
	public String delete_vidoe_apply(HttpServletRequest request, HttpSession session, Model model,
			RedirectAttributes rea) throws Exception {

		int vno = Integer.parseInt(request.getParameter("vno"));
		int vano = Integer.parseInt(request.getParameter("vano"));

		if (vano != 0) {
			mantorService.deleteVideoApply(vano);
			rea.addAttribute("vno", vno);
			rea.addAttribute("applycheck", "true");
			return "redirect:/Mentor/videoview";
		} else {
			rea.addAttribute("applycheck", "false");
			return "redirect:/Mentor/videoview";
		}

	}

	@RequestMapping(value = "/Myvideo", method = RequestMethod.GET)
	public String videoEdit(HttpServletRequest request, HttpSession session, Model model) throws Exception {

		String userId = (String) session.getAttribute("userId");
		String mentorname = (String) session.getAttribute("userName");
		System.out.println(userId);

		User user = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴
		int userNo = user.getNo();
		int mno = mantorService.UsernoToMentormno(userNo); // 세션값을 이용한 멘토번호 조회

		List<Video> video = mantorService.mentorvideoList(mno);

		model.addAttribute("mentorname", mentorname);
		model.addAttribute("video", video);
		return "/Mentor/MyVideo";
	}

	@RequestMapping(value = "/videodelete", method = RequestMethod.GET)
	public String videodelete(HttpServletRequest request, HttpSession session, Model model) throws Exception {

		int vno = Integer.parseInt(request.getParameter("vno"));

		if (vno != 0) {
			Video video = mantorService.getvideoview(vno);
			System.out.println(video.getVideofile());
			Main main = new Main();
			File file = new File(uploadPath + video.getVideofile());

			String key = video.getVideofile();
			// String copyKey = "img/my-img-copy.img";

			// upload 실행하기.

			// AWS에 있는 파일 삭제하기
			main.delete(key);
			mantorService.deletevideo(vno);
		}

		return "redirect:/Mentor/Myvideo";
	}

	@RequestMapping(value = "/videoedit", method = RequestMethod.GET)
	public String videoedit(HttpServletRequest request, HttpSession session, Model model) throws Exception {

		int vno = Integer.parseInt(request.getParameter("vno"));

		Video video = mantorService.getvideoview(vno);

		model.addAttribute("Video", new Video());
		model.addAttribute("videofile", video.getVideofile());
		model.addAttribute("videointroduce", video.getVideointroduce());
		model.addAttribute("videoname", video.getVideoname());
		model.addAttribute("videoprice", video.getVideoprice());
		model.addAttribute("mno", video.getMno());
		model.addAttribute("vno", video.getVno());
		return "/Mentor/videoEdit";
	}

	@RequestMapping(value = "/videoedit", method = RequestMethod.POST)
	public String videoeditpost(HttpServletRequest request, HttpSession session, Model model,
			MultipartHttpServletRequest requestt) throws Exception {

		Video video = new Video();
		int vno = Integer.parseInt(request.getParameter("vno"));
		int mno = Integer.parseInt(request.getParameter("mno"));
		String videoname = request.getParameter("videoname");
		String videoprice = request.getParameter("videoprice");
		String videotype = request.getParameter("videotype");
		String videointroduce = request.getParameter("videointroduce");
		List<MultipartFile> fileList = requestt.getFiles("videofile");
		String videofile = requestt.getParameter("videofile");

		Video getvideo = mantorService.getvideoview(vno);
		System.out.println(uploadPath + getvideo.getVideofile());
		Main main = new Main();
		File file = new File(uploadPath + getvideo.getVideofile());

		String key = getvideo.getVideofile();
		// String copyKey = "img/my-img-copy.img";

		// upload 실행하기.

		// AWS에 있는 파일 삭제하기
		main.delete(key);

		for (MultipartFile mf : fileList) {
			if (!mf.isEmpty()) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈

				video.setMno(mno);
				video.setVideofile(originFileName);
				video.setVideointroduce(videointroduce);
				video.setVideoname(videoname);
				video.setVideoprice(videoprice);
				video.setVideotype(videotype);
				video.setVno(vno);

				Main main2 = new Main();
				File file2 = new File(uploadPath + video.getVideofile());

				String key2 = video.getVideofile();
				// String copyKey = "img/my-img-copy.img";

				// upload 실행하기.

				// AWS에 있는 파일 업로드
				main2.upload(file2, key2);

				mantorService.updatevideo(video);
				String safeFile = uploadPath + originFileName; // 디스크에 파일 저장
				try {
					mf.transferTo(new File(safeFile)); // 디스크에 파일 저장
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				video.setMno(mno);
				video.setVideofile("null");
				video.setVideointroduce(videointroduce);
				video.setVideoname(videoname);
				video.setVideoprice(videoprice);
				video.setVideotype(videotype);
				video.setVno(vno);

				mantorService.updatevideo(video);
			}
		}
		return "redirect:/Mentor/Myvideo";
	}

	@RequestMapping(value = "/courseList", method = RequestMethod.GET)
	public String courseList(HttpServletRequest request, HttpSession session, Model model) throws Exception {

		String userId = (String) session.getAttribute("userId");
		List<Video> video = mantorService.videoList();
		List<CourseVO> video2 = videoService.course_list();
		model.addAttribute("video", video);
		model.addAttribute("video2", video2);
		model.addAttribute("user", new User());
		return "/course";
	}

	@RequestMapping(value = "/course_class", method = RequestMethod.GET)
	public String main_class(HttpServletRequest request, HttpSession session, Model model) {

		String videotype = (String) request.getParameter("videotype");
		System.out.println(videotype);
		List<Video> video = mantorService.videoListvideotype(videotype);
		model.addAttribute("video", video);
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
			return "/course_class";
		}

		model.addAttribute("user", new User());
		return "/course_class";
	}

	@RequestMapping(value = "/video_record_go", method = RequestMethod.GET) // ID중복체크
	@ResponseBody
	public String video_record_go(HttpSession session, HttpServletRequest request) {

		Video_recordVO record = new Video_recordVO();

		String sign = "false";

		String userId = (String) session.getAttribute("userId");
		User user = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴

		int result = 0;// 결과를 담는곳
		int userNo = user.getNo(); // 사용자의 유저번호

		int video_record = Integer.parseInt(request.getParameter("video_record"));// 비디오 기록시간
		int vno = Integer.parseInt(request.getParameter("vno"));
		int duration = Integer.parseInt(request.getParameter("duration"));

		System.out.println("총 영상길이" + duration);
		System.out.println("시청시간" + video_record);
		System.out.println("유저번호" + userNo);
		System.out.println("비디오 번호" + vno);

		record.setNo(userNo);
		record.setVideo_record(video_record);
		record.setVno(vno);
		record.setVideo_end(duration);
		if (videoService.get_video_record(vno, userNo) != null) { // 동영상을 봤던 기록이 있는 사람은update를 시켜준다

			videoService.update_video_record(record);
			sign = "true";

		} else { // 동영상을 본 기록이 없는사람은 insert를 시켜준다.
			result = videoService.video_record_go(record);
			sign = "true";
		}

		//
		Gson gson = new Gson();
		JsonObject object = new JsonObject();

		if (sign == "true") {
			object.addProperty("msg", "true");
			return gson.toJson(object).toString();
		} else {
			object.addProperty("msg", "false");
			return gson.toJson(object).toString();
		}
	}

}
