package com.jang.a260;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jang.a260.model.MentorVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.service.MantorService;
import com.jang.a260.service.UserService;

@Controller
@RequestMapping("/Mentor")
public class VideoController {

	@Autowired
	private MantorService mantorService;

	@Autowired
	private UserService userService;

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
		String videointroduce = request.getParameter("videointroduce");
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
		Main main = new Main();
		File file = new File(uploadPath + video.getVideofile());

		String key = video.getVideofile();

		// String copyKey = "img/my-img-copy.img";
		// upload 실행하기.

		main.upload(file, key);
		mantorService.insertVideo(video);
		return "redirect:/Mentor/Mentor_list";
	}

	@RequestMapping(value = "/videoview", method = RequestMethod.GET)
	public String videoview(HttpServletRequest request, HttpSession session, Model model) throws Exception {

		int vno = Integer.parseInt(request.getParameter("vno"));

		Video video = mantorService.getvideoview(vno);
		MentorVO mentor = mantorService.selectmentorview(video.getMno()); // 해당하는 멘토의정보를 가져오김

		User user = userService.getUserformento(mentor.getNo());

		model.addAttribute("mentorprofile", mentor.getProfile());
		model.addAttribute("mno", mentor.getMno());
		model.addAttribute("userName", user.getName());
		model.addAttribute("video", video);
		model.addAttribute("user", new User());
		return "/Mentor/videoview";
	}

	@RequestMapping(value = "/Myvideo", method = RequestMethod.GET)
	public String videoEdit(HttpServletRequest request, HttpSession session, Model model) throws Exception {

		String userId = (String) session.getAttribute("userId");
		String mentorname=(String) session.getAttribute("userName");
		System.out.println(userId);

		User user = userService.getUser(userId); // 세션값을 이용하여 현재사용자의 정보를 가져옴
		int userNo = user.getNo();
		int mno = mantorService.UsernoToMentormno(userNo); // 세션값을 이용한 멘토번호 조회
		
		List<Video> video = mantorService.mentorvideoList(mno);

		model.addAttribute("mentorname",mentorname);
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

}
