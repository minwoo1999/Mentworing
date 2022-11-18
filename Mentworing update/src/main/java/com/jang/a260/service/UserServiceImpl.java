package com.jang.a260.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jang.a260.AWSService;
import com.jang.a260.mapper.UserMapper;
import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.MentorApprove;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;
import com.jang.a260.utils.PageHelper;

@Service(value = "userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper; // 인터페이스와 의존관계 설정

	

	PageHelper pageHelper = new PageHelper();



	private int roomno;

	@Override
	public User getUser(String userId) {
		// TODO Auto-generated method stub
		return userMapper.getUser(userId);
	}

	@Override
	public int updateUser(User user) {
		// TODO Auto-generated method stub
		return userMapper.updateUser(user);
	}

	@Override
	public int insertUser(User user) {
		// TODO Auto-generated method stub
		return userMapper.insertUser(user);
	}

	public User findId(String name, String email) {
		// TODO Auto-generated method stub
		return userMapper.findId(name, email);
	}

	@Override
	public User findPass(String id, String email) {
		// TODO Auto-generated method stub
		return userMapper.findPass(id, email);
	}

	@Override
	public int updatePass(User user) {
		// TODO Auto-generated method stub
		return userMapper.updatePass(user);
	}

	@Override
	public int mentorregister(MentorApprove ma) {
		// TODO Auto-generated method stub
		return userMapper.mentorregister(ma);
	}

	@Override
	public List<User> selectAlluser() {
		// TODO Auto-generated method stub
		return userMapper.selectAlluser();
	}

	@Override
	public int deleteMentorApprove(int mano) {
		// TODO Auto-generated method stub
		return userMapper.deleteMentorApprove(mano);
	}

	@Override
	public int updateMentorApprove(MentorApprove mentor) {
		// TODO Auto-generated method stub
		return userMapper.updateMentorApprove(mentor);
	}

	@Override
	public List<MentorApprove> selectmentorregister(String w) {
		// TODO Auto-generated method stub
		return userMapper.selectmentorregister(w);
	}

	@Override
	public String mentorregistercheck(int no, String w) {
		// TODO Auto-generated method stub
		return userMapper.mentorregistercheck(no, w);
	}

	@Override
	public MentorApprove getMentorApprove(int mno) {
		// TODO Auto-generated method stub
		return userMapper.getMentorApprove(mno);
	}

	@Override
	public int getTotalRow() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<User> getUserList(int startRow, int endRow) {
		// TODO Auto-generated method stub
		return this.userMapper.getUserList(startRow, endRow);
	}

	@Override
	public List<User> getUserList(SearchVO searchVO) {
		// TODO Auto-generated method stub
		int currentPage = searchVO.getPage();
		int startRow = (currentPage - 1) * 10 + 1; // pagesize=10 가정
		int endRow = currentPage * 10; // pagesize=10

		searchVO.setStartRow(startRow);
		searchVO.setEndRow(endRow);

		return this.userMapper.getUserList(searchVO);
	}

	@Override
	public int getTotalRow(SearchVO searchVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public StringBuffer getPageUrl(SearchVO searchVO) {
		// TODO Auto-generated method stub
		int totalRow = userMapper.getTotalRow(searchVO);
		return pageHelper.getPageUrl(searchVO, totalRow);
	}

	@Override
	public User getUserformento(int no) {
		// TODO Auto-generated method stub
		return userMapper.getUserformento(no);
	}

	@Override
	public int insertPayment(paymentVO payment) {
		// TODO Auto-generated method stub
		return this.userMapper.insertPayment(payment);
	}

	@Override
	public int insertPaymentDetail(paymentDetailVO paymentdetail) {
		// TODO Auto-generated method stub
		return this.userMapper.insertPaymentDetail(paymentdetail);
	}

	@Override
	public String[] selectchattingname(String name) {
		// TODO Auto-generated method stub
		return this.userMapper.selectchattingname(name);
	}

	@Override
	public int insertMemberprofile(MemberProfileVO memberprofile) {
		// TODO Auto-generated method stub
		return this.userMapper.insertMemberprofile(memberprofile);
	}

	@Override
	public MemberProfileVO getUserProfile(String userId) {
		// TODO Auto-generated method stub
		return this.userMapper.getUserProfile(userId);
	}

	@Override
	public int updateMemberprofile(MemberProfileVO memberprofile) {
		// TODO Auto-generated method stub
		return this.userMapper.updateMemberprofile(memberprofile);
	}

	@Override
	public List<MemberProfileVO> UserProfileList() {
		// TODO Auto-generated method stub
		return this.userMapper.UserProfileList();
	}

	@Override
	public int updateMemberprofile2(String userId, String profile) {
		// TODO Auto-generated method stub
		return this.userMapper.updateMemberprofile2(userId, profile);
	}

	@Override
	public int insert_second_authentication(String userId, String WHETHER_ON_OFF) {
		// TODO Auto-generated method stub
		return this.userMapper.insert_second_authentication(userId, WHETHER_ON_OFF);
	}

	@Override
	public Integer select_authenticationId(String userId) {
		// TODO Auto-generated method stub
		return this.userMapper.select_authenticationId(userId);
	}

	@Override
	public int update_authentication(String userId, String WHETHER_ON_OFF) {
		// TODO Auto-generated method stub
		return this.userMapper.update_authentication(userId, WHETHER_ON_OFF);
	}

	@Override
	public String check_authenticationId(String userId) {
		// TODO Auto-generated method stub
		return this.userMapper.check_authenticationId(userId);
	}

	








	





}
