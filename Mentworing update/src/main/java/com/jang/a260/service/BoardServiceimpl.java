package com.jang.a260.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jang.a260.mapper.BoardMapper;
import com.jang.a260.model.AttFileVO;
import com.jang.a260.model.BoardLikeVO;
import com.jang.a260.model.BoardVO;
import com.jang.a260.model.BoardViewVO;
import com.jang.a260.model.ReplyLikeVO;
import com.jang.a260.model.ReplyVO;
import com.jang.a260.model.ReviewVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.utils.PageHelper;
import com.jang.a260.utils.PageHelperBoard;
import com.jang.a260.utils.PageHelperReview;



@Service(value = "boardSerivce")
public class BoardServiceimpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;

	PageHelperBoard pageHelper = new PageHelperBoard();
	
	
	PageHelperReview pageHelper2 = new PageHelperReview();

	@Override
	public int getTotalRow() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BoardVO> getBoardList(int startRow, int endRow) {
		// TODO Auto-generated method stub
		return this.boardMapper.getBoardList(startRow, endRow);
	}

	@Override
	public List<BoardVO> getBoardList(SearchVO searchVO) {
		// TODO Auto-generated method stub
		int currentPage = searchVO.getPage();
		int startRow = (currentPage - 1) * 10 + 1; // pagesize=10 가정
		int endRow = currentPage * 10; // pagesize=10

		searchVO.setStartRow(startRow);
		searchVO.setEndRow(endRow);

		return this.boardMapper.getBoardList(searchVO);

	}

	@Override
	public StringBuffer getPageUrl(SearchVO searchVO) {
		// TODO Auto-generated method stub
		int totalRow = boardMapper.getTotalRow(searchVO);
		return pageHelper.getPageUrl(searchVO, totalRow);
	}
	
	

	public int addBoardView(BoardViewVO boardView) { // userid-글번호 조회 기록 추가
		return this.boardMapper.addBoardView(boardView);
	}

	public int increaseViewCnt(int bno) { // 글번호 조회수 증가
		return this.boardMapper.increaseViewCnt(bno);
	}

	public int getBoardView(BoardViewVO boardView) { // userid-글번호 조회 기록 읽기
		return this.boardMapper.getBoardView(boardView);
	}

	public BoardVO getArticle(int bno) { // 글번호 글일기
		return this.boardMapper.getArticle(bno);
	}

	public List<ReplyVO> getReplyList(int bno) {// 글번호-답글 리스트 읽어 오기
		return this.boardMapper.getReplyList(bno);
	}

	public List<AttFileVO> getFileList(int bno) {// 글번호-첨부 파일 리스트 읽어오기
		return this.boardMapper.getFileList(bno);
	}

	@Override
	public int getTotalRow(SearchVO searchVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateArticle(BoardVO board) {
		// TODO Auto-generated method stub
		return this.boardMapper.updateArticle(board);
	}

	@Override
	public int deleteArticle(int bno) {
		// TODO Auto-generated method stub
		return this.boardMapper.deleteArticle(bno);
	}

	@Override
	public int incrementGoodCcnt(int bno) {
		// TODO Auto-generated method stub
		return this.boardMapper.incrementGoodCcnt(bno);
	}

	@Override
	public int incrementReplayCnt(int bno) {
		// TODO Auto-generated method stub
		return this.boardMapper.incrementReplayCnt(bno);
	}

	@Override
	public ReplyVO getReply(int rno) {
		// TODO Auto-generated method stub
		return this.boardMapper.getReply(rno);
	}

	@Override
	public int writeReply(ReplyVO reply) {
		// TODO Auto-generated method stub
		int bno = reply.getBno();
		this.boardMapper.incrementReplayCnt(bno);
		return this.boardMapper.writeReply(reply);
	}

	@Override
	public int writerArticle(BoardVO board) {
		// TODO Auto-generated method stub
		return this.boardMapper.writerArticle(board);
	}
	


	@Override
	public int updateReply(ReplyVO reply) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteReply(int rno) {
		// TODO Auto-generated method stub
		return this.boardMapper.deleteReply(rno);
	}

	@Override
	public int deleteReplyBybno(int bno) {
		// TODO Auto-generated method stub
		return this.boardMapper.deleteReplyBybno(bno);
	}

	@Override
	public int incReplyGoodCnt(int rno) {
		// TODO Auto-generated method stub
		return this.boardMapper.incReplyGoodCnt(rno);
	}

	@Override
	public String getFileName(int fno) {
		// TODO Auto-generated method stub
		return this.boardMapper.getFileName(fno);
	}

	@Override
	public int insertFile(AttFileVO file) {
		// TODO Auto-generated method stub
		return this.boardMapper.insertFile(file);
	}

	

	@Override
	public int deleteFileBybno(int bno) {
		// TODO Auto-generated method stub
		return this.boardMapper.deleteFileBybno(bno);
	}

	@Override
	public int addBoardLike(BoardLikeVO boardLike) {
		// TODO Auto-generated method stub
		return this.boardMapper.addBoardLike(boardLike);
	}

	@Override
	public int getBoardLike(BoardLikeVO boardLike) {
		// TODO Auto-generated method stub
		return this.boardMapper.getBoardLike(boardLike);
	}

	@Override
	public int addReplyLike(ReplyLikeVO replyLike) {
		// TODO Auto-generated method stub
		return this.boardMapper.addReplyLike(replyLike);
	}

	@Override
	public int getReplyLike(ReplyLikeVO replyLike) {
		// TODO Auto-generated method stub
		return this.boardMapper.getReplyLike(replyLike);
	}

	@Override
	public int deleteFile(int fno) {
		// TODO Auto-generated method stub
		return this.boardMapper.deleteFile(fno);
		
	}

	@Override
	public int decrementReplayCnt(int bno) {
		// TODO Auto-generated method stub
		return this.boardMapper.decrementReplayCnt(bno);
	}



	@Override
	public int getprofile(String userId) {
		// TODO Auto-generated method stub
		return this.boardMapper.getprofile(userId);
	}

	@Override
	public int deletebasket(int bno) {
		// TODO Auto-generated method stub
		return this.boardMapper.deletebasket(bno);
	}

	@Override
	public int insertMentorReview(ReviewVO review) {
		// TODO Auto-generated method stub
		return this.boardMapper.insertMentorReview(review);
	}

	@Override
	public List<ReviewVO> getMentorReview(int startRow, int endRow) {
		// TODO Auto-generated method stub
		return this.boardMapper.getMentorReview(startRow, endRow);
	}

	@Override
	public List<ReviewVO> getMentorReview(SearchVO searchVO) {
		// TODO Auto-generated method stub
		int currentPage = searchVO.getPage();
		int startRow = (currentPage - 1) * 10 + 1; // pagesize=10 가정
		int endRow = currentPage * 10; // pagesize=10

		searchVO.setStartRow(startRow);
		searchVO.setEndRow(endRow);

		return this.boardMapper.getMentorReview(searchVO);

	}

	@Override
	public StringBuffer getPageUrl2(SearchVO searchVO) {
		// TODO Auto-generated method stub
		int totalRow = boardMapper.getTotalRow2(searchVO);
		return pageHelper2.getPageUrl(searchVO, totalRow);
	}

	@Override
	public int getTotalRow2(SearchVO searchVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ReviewVO> Mentorview_getMentorReview(int mno) {
		// TODO Auto-generated method stub
		return this.boardMapper.Mentorview_getMentorReview(mno);
	}




	



	

	

	



}
