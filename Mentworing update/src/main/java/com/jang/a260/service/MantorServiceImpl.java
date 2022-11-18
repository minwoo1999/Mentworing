package com.jang.a260.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jang.a260.mapper.MantorMapper;
import com.jang.a260.model.IncomeVO;
import com.jang.a260.model.Mentee_list_VO;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video;
import com.jang.a260.model.VideoApplyVO;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;
import com.jang.a260.utils.PageHelper;
import com.jang.a260.utils.PageHelperBoard;
import com.jang.a260.utils.PageHelpermente_list;

@Service(value="mantorService")
public class MantorServiceImpl implements MantorService {
	
	
	PageHelpermente_list pageHelper = new PageHelpermente_list();
	
	@Autowired
	private MantorMapper mantorMapper; //인터페이스와 의존관계 설정

	@Override
	public int insertMentor(MentorVO mentor) {
		// TODO Auto-generated method stub
		return this.mantorMapper.insertMentor(mentor);
	}

	@Override
	public String selectmentor(int no) {
		// TODO Auto-generated method stub
		return this.mantorMapper.selectmentor(no);
	}

	@Override
	public List<MentorVO> mentorList() {
		// TODO Auto-generated method stub
		return this.mantorMapper.mentorList();
	}

	@Override
	public MentorVO selectmentorview(int mno) {
		// TODO Auto-generated method stub
		return this.mantorMapper.selectmentorview(mno);
	}

	@Override
	public int insertVideo(Video video) {
		// TODO Auto-generated method stub
		return this.mantorMapper.insertVideo(video);
	}

	@Override
	public Integer UsernoToMentormno(int no) {
		// TODO Auto-generated method stub
		return this.mantorMapper.UsernoToMentormno(no);
	}

	@Override
	public List<Video> videoList() {
		// TODO Auto-generated method stub
		return this.mantorMapper.videoList();
	}

	@Override
	public Video getvideoview(int vno) {
		// TODO Auto-generated method stub
		return this.mantorMapper.getvideoview(vno);
	}

	@Override
	public List<Video> mentorvideoList(int mno) {
		// TODO Auto-generated method stub
		return this.mantorMapper.mentorvideoList(mno);
	}

	@Override
	public int deletevideo(int vno) {
		// TODO Auto-generated method stub
		return this.mantorMapper.deletevideo(vno);
	}



	@Override
	public int updatevideo(Video video) {
		// TODO Auto-generated method stub
		return this.mantorMapper.updatevideo(video);
	}

	@Override
	public List<paymentDetailVO> getpaymentdetailList(int startRow, int endRow) {
		// TODO Auto-generated method stub
		return this.mantorMapper.getpaymentdetailList(startRow, endRow);
	}

	@Override
	public List<paymentDetailVO> getpaymentdetailList(SearchVO searchVO) {
		// TODO Auto-generated method stub
		int currentPage = searchVO.getPage();
		int startRow = (currentPage - 1) * 20 + 1; // pagesize=10 가정
		int endRow = currentPage * 20; // pagesize=10

		searchVO.setStartRow(startRow);
		searchVO.setEndRow(endRow);

		return this.mantorMapper.getpaymentdetailList(searchVO);
	}

	@Override
	public int getTotalRow(SearchVO searchVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public StringBuffer getPageUrl(SearchVO searchVO) {
		// TODO Auto-generated method stub
		int totalRow = mantorMapper.getTotalRow(searchVO);
		return pageHelper.getPageUrl(searchVO, totalRow);
	}

	@Override
	public String[] getpaymentcheck(String userId, int mno) {
		// TODO Auto-generated method stub
		return mantorMapper.getpaymentcheck(userId, mno);
	}

	@Override
	public MentorVO getmentorList() {
		// TODO Auto-generated method stub
		return mantorMapper.getmentorList();
	}

	@Override
	public String[] getPaymentuserId() {
		// TODO Auto-generated method stub
		return mantorMapper.getPaymentuserId();
	}

	@Override
	public int getPaymentPno(String userId) {
		// TODO Auto-generated method stub
		return mantorMapper.getPaymentPno(userId);
	}

	@Override
	public List<Video> videoListvideotype(String videotype) {
		// TODO Auto-generated method stub
		return mantorMapper.videoListvideotype(videotype);
	}

	@Override
	public int MentormnoToUserno(int mno) {
		// TODO Auto-generated method stub
		return this.mantorMapper.MentormnoToUserno(mno);
	}

	@Override
	public int insertVideoApply(VideoApplyVO videoapply) {
		// TODO Auto-generated method stub
		return this.mantorMapper.insertVideoApply(videoapply);
	}

	@Override
	public List<VideoApplyVO> getVideoApply(int vno) {
		// TODO Auto-generated method stub
		return this.mantorMapper.getVideoApply(vno);
	}

	@Override
	public int updatementorprofile(MentorVO mentorprofile) {
		// TODO Auto-generated method stub
		return this.mantorMapper.updatementorprofile(mentorprofile);
	}

	@Override
	public int deleteVideoApply(int vano) {
		// TODO Auto-generated method stub
		return this.mantorMapper.deleteVideoApply(vano);
	}

	@Override
	public List<IncomeVO> selectChartsumprice(int mno, String start_date, String end_date) {
		// TODO Auto-generated method stub
		return this.mantorMapper.selectChartsumprice(mno, start_date, end_date);
	}

	@Override
	public String[] getPaymentDetail_list() {
		// TODO Auto-generated method stub
		return this.mantorMapper.getPaymentDetail_list();
	}

	@Override
	public List<Mentee_list_VO> mentee_list() {
		// TODO Auto-generated method stub
		return this.mantorMapper.mentee_list();
	}




	


	






	

	
	


	

	






}
