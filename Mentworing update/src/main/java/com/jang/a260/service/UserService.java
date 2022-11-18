package com.jang.a260.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jang.a260.model.MemberProfileVO;
import com.jang.a260.model.MentorApprove;
import com.jang.a260.model.MentorVO;
import com.jang.a260.model.SearchVO;
import com.jang.a260.model.User;
import com.jang.a260.model.paymentDetailVO;
import com.jang.a260.model.paymentVO;


public interface UserService {
	User getUser(String userId);

	int updateUser(User user);

	int insertUser(User user);

	User findId(String name, String email);

	User findPass(String id, String email);

	int updatePass(User user);

	int mentorregister(MentorApprove ma);

	List<MentorApprove> selectmentorregister(String w);

	String mentorregistercheck(int no,String w);;

	List<User> selectAlluser();

	int deleteMentorApprove(int mano);
	
	int updateMentorApprove(MentorApprove mentor);
	
	MentorApprove getMentorApprove(int mno);
	
	int getTotalRow(); // 전체글 수 조회

	List<User> getUserList(@Param(value = "startRow") int startRow, @Param(value = "endRow") int endRow);

	List<User> getUserList(SearchVO searchVO);
	
	int getTotalRow(SearchVO searchVO);// 전체글 수 조회
	
	StringBuffer getPageUrl(SearchVO searchVO);
	
	User getUserformento(int no);
	
	int insertPayment(paymentVO payment);
	
	int insertPaymentDetail(paymentDetailVO paymentdetail);
	
	String[] selectchattingname(String name);
	
	int insertMemberprofile(MemberProfileVO memberprofile);

	MemberProfileVO getUserProfile(String userId);
	
	int updateMemberprofile(MemberProfileVO memberprofile);
	
	List<MemberProfileVO> UserProfileList();
	
	int updateMemberprofile2(String userId, String profile);
	
	int insert_second_authentication(String userId, String WHETHER_ON_OFF);
	
	Integer select_authenticationId(String userId);
	
	int update_authentication(String userId, String WHETHER_ON_OFF);
	
	String check_authenticationId(String userId);
	


}
