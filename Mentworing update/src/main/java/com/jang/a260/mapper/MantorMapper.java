package com.jang.a260.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jang.a260.model.IncomeVO;
import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.Mentee_list_VO;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.model.VideoApplyVO;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;

@Mapper
public interface MantorMapper {

	int insertMentor(MentorVO mentor);

	String selectmentor(int no);

	List<MentorVO> mentorList();
	
	MentorVO getmentorList();
	
	MentorVO selectmentorview(int mno);
	
	int insertVideo(Video video);
	
	Integer UsernoToMentormno(int no);
	
	int MentormnoToUserno(int mno);
	
	List<Video> videoList();
	
	List<Video> videoListvideotype(String videotype);//직군별 비디오 리스트
	
	Video getvideoview(int vno);
	
	List<Video> mentorvideoList(int mno);
	
	int deletevideo(int vno);
	
	int updatevideo(Video video);
	
	List<paymentDetailVO> getpaymentdetailList(@Param(value = "startRow") int startRow, @Param(value = "endRow") int endRow);

	List<paymentDetailVO> getpaymentdetailList(SearchVO searchVO);
	
	String[] getpaymentcheck(@Param(value = "userId") String userId,@Param(value = "mno") int mno); 
	
	int getTotalRow(SearchVO searchVO);// 전체글 수 조회
	
	StringBuffer getPageUrl(SearchVO searchVO);
	
	String[] getPaymentuserId();
	
	int getPaymentPno(String userId);
	
	int insertVideoApply(VideoApplyVO videoapply);
	
	List<VideoApplyVO> getVideoApply(int vno);
	
	int deleteVideoApply(int vano);
	
	int updatementorprofile(MentorVO mentorprofile);
	
	List<IncomeVO>selectChartsumprice(int mno,@Param(value = "start_date") String start_date,@Param(value = "end_date") String end_date);
	
	String [] getPaymentDetail_list();
	
	List<Mentee_list_VO> mentee_list();
	
	
	
	
	
	
	
}
