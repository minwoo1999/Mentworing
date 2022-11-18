package com.jang.a260.model;

import lombok.Data;

@Data
public class MentorVO {

	private int mno;
	private int no;
	private String approve_date;
	private String certificate;
	private String major;
	private String introduce;
	private String profile;
	private String officetype;
	private String rcmcomment;
	private String headcomment;
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getApprove_date() {
		return approve_date;
	}
	public void setApprove_date(String approve_date) {
		this.approve_date = approve_date;
	}
	public String getCertificate() {
		return certificate;
	}
	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getOfficetype() {
		return officetype;
	}
	public void setOfficetype(String officetype) {
		this.officetype = officetype;
	}
	public String getRcmcomment() {
		return rcmcomment;
	}
	public void setRcmcomment(String rcmcomment) {
		this.rcmcomment = rcmcomment;
	}
	public String getHeadcomment() {
		return headcomment;
	}
	public void setHeadcomment(String headcomment) {
		this.headcomment = headcomment;
	}

	


}