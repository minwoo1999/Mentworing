package com.jang.a260.model;

import lombok.Data;

@Data
public class MemberProfileVO {

	private int mpno;
	private String userId;
	private String name;
	private String register_date;
	private String profile;
	private int no;
	public int getMpno() {
		return mpno;
	}
	public void setMpno(int mpno) {
		this.mpno = mpno;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	
	
}
