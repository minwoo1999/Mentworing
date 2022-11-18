package com.jang.a260;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jang.a260.mapper.MantorMapper;
import com.jang.a260.model.AttFileVO;
import com.jang.a260.model.BoardLikeVO;
import com.jang.a260.model.BoardVO;
import com.jang.a260.model.BoardViewVO;
import com.jang.a260.model.ChatVO;
import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.ReplyLikeVO;
import com.jang.a260.model.ReplyVO;
import com.jang.a260.model.ReviewVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.service.BoardService;
import com.jang.a260.service.ChatService;
import com.jang.a260.service.MantorService;
import com.jang.a260.service.UserService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private UserService userService;

	@Autowired
	private MantorService mantorService;
	
	@Autowired
	private ChatService chatService;


	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listPage(@ModelAttribute("searchVO") SearchVO seachVO, Model model, HttpSession session)
			throws Exception {

		List<BoardVO> blist = boardService.getBoardList(seachVO);

		model.addAttribute("boardList", blist);

		StringBuffer pageUrl = boardService.getPageUrl(seachVO);
		model.addAttribute("pageHttp", pageUrl);
		model.addAttribute("user", new User());

		return "board/list";
	}

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String boardWrite() {
		return "/board/write";
	}

	String uploadPath = "C:\\upload\\"; // file upload path 전역변수로 파일 저장소 지정

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String boardWriteProc(@ModelAttribute("BoardVO") BoardVO boardVO, MultipartHttpServletRequest request) {
		// 새 글저장

		// String content = boardVO.getContent().replaceAll("\r\n", "<br />");// java새줄
		// 코드 HTML줄바꾸기로
		// content = content.replaceAll("<", "&lt;");
		// content = content.replaceAll(">", "&gt;");
		// content = content.replaceAll("&", "&amp;");
		// content = content.replaceAll("\"", "&quot;");

		// boardVO.setContent(content);
		System.out.println("1");
		boardService.writerArticle(boardVO);
		System.out.println("2");
		int bno = boardVO.getBno();
		// 저장시 생성한 새 글번호가 반환됨 : 어떻게? xml 파일 insert keyProperty="bno"에 의해서 설정됨
		// 첨부 파일 저장
		AttFileVO file = new AttFileVO();

		List<MultipartFile> fileList = request.getFiles("file");
		for (MultipartFile mf : fileList) {
			if (!mf.isEmpty()) {
				String originFileName = mf.getOriginalFilename(); // 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈
				file.setBno(bno);
				file.setOfilename(originFileName);
				file.setSfilename(originFileName); // 디스크에 파일 저장시 동일 파일명 발생대비:현재 처리 안함
				file.setFilesize(fileSize);
				System.out.println(bno);
				System.out.println(originFileName);
				System.out.println(originFileName);
				System.out.println(fileSize);
				boardService.insertFile(file);// 테이블에 화일 정보 저장
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
		return "redirect:list";
	}

	@RequestMapping("/view")
	public String boardView(@RequestParam(value = "bno", required = false, defaultValue = "0") int bno,
			HttpSession session, Model model) throws Exception {

		String userId = (String) session.getAttribute("userId");
		System.out.println("view에 들어온 아이디는" + userId);
		BoardViewVO boardViewVO = new BoardViewVO(); // 글조회 여백 용
		boardViewVO.setBno(bno);

		if (userId != null) { // 회원인 경우

			boardViewVO.setUserId(userId);
			boardViewVO.setMem_yn('y');// 회원

			if (boardService.getBoardView(boardViewVO) == 0) { // 해당 번호 글을 읽은 기록이없으면
				boardService.increaseViewCnt(bno); // 조회수 갱신
				boardService.addBoardView(boardViewVO); // 회원 조회등록
			}
		} else { // 비회원
			boardViewVO.setUserId(session.getId()); // 세션 id 를 회원 id 로 등록
			boardViewVO.setMem_yn('n'); // 비회원

			if (boardService.getBoardView(boardViewVO) == 0) { // 해당 번호 글을 읽은 기록이 없을 때
				boardService.increaseViewCnt(bno); // 조회수 갱신
				boardService.addBoardView(boardViewVO); // 비회원 조회등록
			}
		}

		model.addAttribute("user", new User());
		BoardVO boardVO = boardService.getArticle(bno); // get selected article model
		List<ReplyVO> reply = boardService.getReplyList(bno); // 댓글 목록 읽어 오기 – list
		List<AttFileVO> fileList = boardService.getFileList(bno); // 첨부파일 목록 읽어 오기-list
		model.addAttribute("board", boardVO);
		model.addAttribute("replyList", reply);
		model.addAttribute("fileList", fileList);
		return "board/view";

	}

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String boardModify(HttpServletRequest request, HttpSession session, Model model) {
		System.out.println("1");

		String userId = (String) session.getAttribute("userId");
		int bno = Integer.parseInt(request.getParameter("bno"));
		System.out.println(bno);
		BoardVO board = boardService.getArticle(bno);
		// <br /> tag change to new line code
		String content = board.getContent().replaceAll("<br />", "\r\n");
		board.setContent(content);
		if (!userId.equals(board.getWriterId())) {
			System.out.println(board.getWriterId() + "" + userId);
			model.addAttribute("user", new User());
			model.addAttribute("errCode", "5"); // 작성자만 글수정 가능
			model.addAttribute("bno", bno);
			return "redirect:view";
		} else {// 회원 글수정
			System.out.println(board.getWriterId() + "" + userId);
			List<AttFileVO> fileList = boardService.getFileList(bno); // 첨부파일 읽어 오기 - list
			model.addAttribute("user", new User());
			model.addAttribute("board", board);
			model.addAttribute("fileList", fileList);
			return "/board/modify";
		}
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST) // 게시판 글 수정
	public String boardModifyProc(@ModelAttribute("Board") BoardVO board, MultipartHttpServletRequest request,
			RedirectAttributes rea) {

		System.out.println("수정 post");
		String content = board.getContent().replaceAll("\r\n", "<br />"); // java 새줄 코드 HTML줄바꾸기로
		board.setContent(content);

		boardService.updateArticle(board);
		int bno = board.getBno();
		System.out.println(bno);
		// 체크된 파일을 테이블과 디스크에서 삭제한다.
		String[] fileno = request.getParameterValues("fileno");

		if (fileno != null) {
			for (String fn : fileno) {

				int fno = Integer.parseInt(fn);
				String oFileName = boardService.getFileName(fno);
				String safeFile = uploadPath + oFileName;
				File removeFile = new File(safeFile);// remove disk uploaded file
				removeFile.delete();
				boardService.deleteFile(fno); // remove table uploaded file
			}

		}

		AttFileVO file = new AttFileVO();

		// 새첨부 파일 목록 일어오기
		List<MultipartFile> fileList = request.getFiles("file");
		for (MultipartFile mf : fileList) {
			if (!mf.isEmpty()) {
				String originFileName = mf.getOriginalFilename(); // 새첨부파일 원본 파일 명
				long fileSize = mf.getSize(); // 파일 사이즈
				file.setBno(bno);
				file.setFilesize(fileSize);
				file.setOfilename(originFileName);
				file.setSfilename(originFileName);
				boardService.insertFile(file); // 테이블에 파일 저장
				String safeFile = uploadPath + originFileName;
				try {
					mf.transferTo(new File(safeFile)); // 디스크에 파일 저장
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		rea.addAttribute("bno", board.getBno());
		return "redirect:/board/view";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String boarddelete(HttpServletRequest request, HttpSession session, Model model, RedirectAttributes rea)
			throws Exception {
		System.out.println("1");

		String userId = (String) session.getAttribute("userId");
		int bno = Integer.parseInt(request.getParameter("bno"));
		System.out.println("삭제 bno=" + bno);
		BoardVO board = boardService.getArticle(bno);
		System.out.println(board.getWriterId());
		System.out.println(userId);
		String setView = "";
		if (userId.equals(board.getWriterId())) {
			// 답글 삭제
			List<ReplyVO> reply = boardService.getReplyList(bno);

			if (reply.size() > 0) {
				boardService.deleteReplyBybno(bno);
			}
			// 첨부 파일명 삭제, 실제 파일 삭제
			List<AttFileVO> files = boardService.getFileList(bno);
			if (files.size() > 0) {
				// 저장된 실제 파일 삭제
				for (AttFileVO filedel : files) {
					String f_stor_all = filedel.getOfilename();
					File f = new File(session.getServletContext().getRealPath("/") + f_stor_all);
					f.delete();
				}
				boardService.deleteFileBybno(bno); // 테이블에서 해당 번호 글 첨부 file 전체 삭제
			}
			// board 삭제
			boardService.deleteArticle(bno);
			setView = "redirect:list";

		} else {
			rea.addAttribute("errCode", "1");// it's forbidden connection
			rea.addAttribute("bno", bno);
			setView = "redirect:view";

		}
		return setView;

	}

	@RequestMapping(value = "filedown")
	@ResponseBody
	public byte[] downProcess(HttpServletResponse response, @RequestParam String fileName) throws IOException {
		File file = new File("c:/upload/" + fileName);
		byte[] bytes = FileCopyUtils.copyToByteArray(file); // SPRING 5.0 이상
		String fn = new String(file.getName().getBytes(), "iso_8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=\"" + fn + "\"");
		response.setContentLength(bytes.length);
		return bytes;
	}

	@RequestMapping("/recommend")
	public String updateRecommendCnt(HttpServletRequest request, HttpSession session, RedirectAttributes rea) {
		int bno = Integer.parseInt(request.getParameter("bno"));
		String userId = (String) session.getAttribute("userId");
		if (userId == null) {
			rea.addAttribute("bno", bno);
			rea.addAttribute("errCode", "4");
			return "redirect:/board/view";
		}
		BoardLikeVO boardLike = new BoardLikeVO();
		boardLike.setBno(bno);
		boardLike.setUserId(userId);
		BoardVO board = boardService.getArticle(bno);
		if (board.getWriterId().equals(userId)) {
			rea.addAttribute("errCode", "3"); // 본인 글은 추천 불가
		} else {

			if (boardService.getBoardLike(boardLike) == 0) { // 이미 추천한 기록이 없으면
				System.out.println(boardService.getBoardLike(boardLike));
				boardService.incrementGoodCcnt(bno);
				boardService.addBoardLike(boardLike); // 추천 기록 등록
			} else {
				rea.addAttribute("errCode", "2"); // 이미 추천했던 글이면 추천 불가
			}
		}
		rea.addAttribute("bno", bno);
		return "redirect:/board/view";
	}

	@RequestMapping("/writeReply")
	public String replyWriteProc(@ModelAttribute("reply") ReplyVO reply, RedirectAttributes rea) {
		if (reply.getContent().isEmpty()) {
			rea.addAttribute("errCode", "1");
		} else {
			String content = reply.getContent().replaceAll("<", "&lt;");
			content = reply.getContent().replaceAll(">", "&gt;");
			content = reply.getContent().replaceAll("&", "&amp;");
			content = reply.getContent().replaceAll("\"", "&quot;");
			content = reply.getContent().replaceAll("\r\n", "<br />");
			reply.setContent(content);
			boardService.writeReply(reply);
		}
		rea.addAttribute("bno", reply.getBno());
		return "redirect:view";
	}

	@RequestMapping("/deleteReply")
	public String commentDelete(HttpServletRequest request, HttpSession session, RedirectAttributes rea) {
		int rno = Integer.parseInt(request.getParameter("rno"));
		int bno = Integer.parseInt(request.getParameter("bno"));
		String userId = (String) session.getAttribute("userId");
		System.out.println("1");
		ReplyVO reply = boardService.getReply(rno);
		if (!userId.equals(reply.getWriterId())) {
			rea.addAttribute("errCode", "1");
		} else {
			boardService.deleteReply(rno);
			boardService.decrementReplayCnt(bno);
		}
		rea.addAttribute("bno", bno); // move back to the article
		return "redirect:view";
	}

	@RequestMapping("/recommandReply")
	public String RecommendRely(HttpServletRequest request, HttpSession session, RedirectAttributes rea) {
		int bno = Integer.parseInt(request.getParameter("bno"));
		int rno = Integer.parseInt(request.getParameter("rno"));
		String userId = (String) session.getAttribute("userId");
		if (userId == null) {
			rea.addAttribute("bno", bno);
			rea.addAttribute("errCode", "4");
			;
			return "redirect:/board/view";
		}
		ReplyLikeVO replyLike = new ReplyLikeVO();
		replyLike.setRno(rno);
		replyLike.setUserId(userId);
		BoardVO board = boardService.getArticle(bno);
		if (board.getWriterId().equals(userId)) {
			rea.addAttribute("errCode", "3");
		} else {
			if (boardService.getReplyLike(replyLike) == 0) {
				boardService.incReplyGoodCnt(rno);
				boardService.addReplyLike(replyLike);
			} else {
				rea.addAttribute("errCode", "2");
			}
		}
		rea.addAttribute("bno", bno);
		return "redirect:/board/view";
	}

	@RequestMapping(value = "/Mentor_Review", method = RequestMethod.GET)
	public String Mentor_Review_GET(@ModelAttribute("searchVO") SearchVO seachVO, HttpServletRequest request,
			Model model, RedirectAttributes rea) throws Exception {

		StringBuffer pageUrl = boardService.getPageUrl2(seachVO);

		List<ReviewVO> review = boardService.getMentorReview(seachVO);

		List<MentorVO> mentor = mantorService.mentorList();

		List<User> member = userService.selectAlluser();

		model.addAttribute("pageHttp", pageUrl);
		model.addAttribute("mentor", mentor);
		model.addAttribute("member", member);
		model.addAttribute("user", new User());
		model.addAttribute("review", review);
		return "./Mentor_Review";

	}

	@RequestMapping(value = "/Mentor_Review", method = RequestMethod.POST)
	public String Mentor_Review(@ModelAttribute ReviewVO review, HttpServletRequest request, Model model,
			RedirectAttributes rea) throws Exception {

		String grade = request.getParameter("star");// 별점 벨류가져오기
		int mno = Integer.parseInt(request.getParameter("mno"));
		MentorVO mentor = mantorService.selectmentorview(mno);
		review.setMentorprofile(mentor.getProfile());
		review.setGrade(Integer.parseInt(grade));
		String content=review.getContent().replace("\r\n","<br>");
		review.setContent(content);
		System.out.println(review.getContent().replace("\r\n","<br>"));
		System.out.println(review.getMno());
		System.out.println(review.getWriterid());
		System.out.println(review.getGrade());
		int result = boardService.insertMentorReview(review);

		if (result == 1) {
			rea.addAttribute("mno", mno);
			rea.addAttribute("review_check", "1");
		}

		return "redirect:../Mentor/Mentorview";

	}


}
