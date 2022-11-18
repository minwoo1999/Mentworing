package com.jang.a260.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jang.a260.AWSService;
import com.jang.a260.dto.best_courseVO;
import com.jang.a260.mapper.UserMapper;
import com.jang.a260.mapper.VideoMapper;
import com.jang.a260.model.CourseVO;
import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.MentorApprove;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.Video_recordVO;
import com.jang.a260.model.Videoview_videolist;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;
import com.jang.a260.utils.PageHelper;

@Service(value = "VideoService")
public class VideioServiceImpl implements VideoService {

	@Autowired
	private VideoMapper videoMapper; // 인터페이스와 의존관계 설정

	@Override
	public List<CourseVO> course_list() {
		// TODO Auto-generated method stub
		return this.videoMapper.course_list();
	}

	@Override
	public List<com.jang.a260.model.best_courseVO> order_best_course() {
		// TODO Auto-generated method stub
		return this.videoMapper.order_best_course();
	}

	@Override
	public int video_record_go(Video_recordVO video_record) {
		// TODO Auto-generated method stub
		return this.videoMapper.video_record_go(video_record);
	}

	

	@Override
	public int update_video_record(Video_recordVO video_record) {
		// TODO Auto-generated method stub
		return this.videoMapper.update_video_record(video_record);
	}

	@Override
	public String get_video_record(int vno, int no) {
		// TODO Auto-generated method stub
		return this.videoMapper.get_video_record(vno, no);
	}

	@Override
	public List<Video_recordVO> List_video_record(int no) {
		// TODO Auto-generated method stub
		return this.videoMapper.List_video_record(no);
	}

	@Override
	public Video_recordVO get_video_record_DTO(int vno, int no) {
		// TODO Auto-generated method stub
		return this.videoMapper.get_video_record_DTO(vno, no);
	}

	@Override
	public List<Videoview_videolist> videoview_get_videolist(String userId) {
		// TODO Auto-generated method stub
		return this.videoMapper.videoview_get_videolist(userId);
	}

	@Override
	public List<com.jang.a260.model.best_courseVO> vidoeview_get_payment_count() {
		// TODO Auto-generated method stub
		return this.videoMapper.vidoeview_get_payment_count();
	}

	@Override
	public List<Video_recordVO> select_all_vieow_record() {
		// TODO Auto-generated method stub
		return this.videoMapper.select_all_vieow_record();
	}

	

	



	

	









	



	

}
