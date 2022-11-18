package com.jang.a260.model;

import lombok.Data;
@Data
public class MentorApprove {
	
	private int mano;
	private int no;
	private String certificate;
	private String major;
	private String mainintroduce;
	private String profile;
	private String withhold;
	private String officetype;
	private String rcmcomment;
	private String headcomment;
	public int getMano() {
		return mano;
	}
	public void setMano(int mano) {
		this.mano = mano;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
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
	public String getMainintroduce() {
		return mainintroduce;
	}
	public void setMainintroduce(String mainintroduce) {
		this.mainintroduce = mainintroduce;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getWithhold() {
		return withhold;
	}
	public void setWithhold(String withhold) {
		this.withhold = withhold;
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
