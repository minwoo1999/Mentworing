package com.jang.a260.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jang.a260.model.AttFileVO;
import com.jang.a260.model.BoardLikeVO;
import com.jang.a260.model.BoardVO;
import com.jang.a260.model.BoardViewVO;
import com.jang.a260.model.ReplyLikeVO;
import com.jang.a260.model.ReplyVO;
import com.jang.a260.model.ReviewVO;
import com.jang.a260.model.SearchVO;



@Mapper
public interface BoardMapper {

	int getTotalRow(); // 전체글 수 조회

	List<BoardVO> getBoardList(@Param(value = "startRow") int startRow, @Param(value = "endRow") int endRow);

	List<BoardVO> getBoardList(SearchVO searchVO);

	int writerArticle(BoardVO board); // 글저장


	int getTotalRow(SearchVO searchVO);// 전체글 수 조회

	BoardVO getArticle(int bno); // 글조회

	int updateArticle(BoardVO board); // 글 수정

	int deleteArticle(int bno); // 글삭제

	int increaseViewCnt(int bno); // 조회수 증가

	int incrementGoodCcnt(int bno); // 좋아요 증가

	int incrementReplayCnt(int bno);// 댓글수 증가

	List<ReplyVO> getReplyList(int bno); // 댓글 목록 조회

	ReplyVO getReply(int rno); // 댓글조회

	int writeReply(ReplyVO reply); // 댓글저장

	int updateReply(ReplyVO reply); // 댓글 수정

	int deleteReply(int rno); // 댓글삭제

	int deleteReplyBybno(int bno); // 원글에 소속된 댓글 전체 삭제

	int incReplyGoodCnt(int rno); // 댓글 좋아요 증가

	List<AttFileVO> getFileList(int bno); // 첨부파일 목록 조회

	String getFileName(int fno); // 첨부파일 이름조회

	int insertFile(AttFileVO file); // 첨부파일 저장

	int deleteFile(int fno); // 첨부파일 삭제

	int deleteFileBybno(int bno); // 원글에 소속된 첨부파일 전체 삭제

	int addBoardLike(BoardLikeVO boardLike); // id -특정글 좋아요 기록 저장

	int getBoardLike(BoardLikeVO boardLike); // id -특정글 좋아요 기록 조회

	int addReplyLike(ReplyLikeVO replyLike); // id -특정댓글 좋아요 기록 저장

	int getReplyLike(ReplyLikeVO replyLike); // id -특정댓글 좋아요 기록 조회

	int addBoardView(BoardViewVO boardView);// id -특정글 조회이력 기록

	int getBoardView(BoardViewVO boardView);// id -특정글 조회이력 읽기
	
	int decrementReplayCnt(int bno); // 댓글수 감소
	
	StringBuffer getPageUrl(SearchVO searchVO);

	
	int getprofile(String userId); // 글조회
	

	
	int deletebasket(int bno); //장바구니 삭제
	
	int insertMentorReview(ReviewVO review); // 리뷰등록
	
	List<ReviewVO> getMentorReview(@Param(value = "startRow") int startRow, @Param(value = "endRow") int endRow);
	
	List<ReviewVO> getMentorReview(SearchVO searchVO);
	
	StringBuffer getPageUrl2(SearchVO searchVO);
	
	int getTotalRow2(SearchVO searchVO);// 전체글 수 조회
	
	List<ReviewVO> Mentorview_getMentorReview(int mno);
	
	
}
