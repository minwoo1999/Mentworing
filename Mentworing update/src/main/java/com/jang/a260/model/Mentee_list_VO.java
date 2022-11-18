package com.jang.a260.model;

import lombok.Data;

@Data
public class Mentee_list_VO {

	
	private String videofile;
	private String videoname;
	private String profile;
	private String name;
	private String payment_date;
	private int vno;
	private int video_record;
	private int video_end;
	private String watch_date;
	private int no;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getVideo_record() {
		return video_record;
	}
	public void setVideo_record(int video_record) {
		this.video_record = video_record;
	}
	public int getVideo_end() {
		return video_end;
	}
	public void setVideo_end(int video_end) {
		this.video_end = video_end;
	}
	public String getWatch_date() {
		return watch_date;
	}
	public void setWatch_date(String watch_date) {
		this.watch_date = watch_date;
	}
	public int getVno() {
		return vno;
	}
	public void setVno(int vno) {
		this.vno = vno;
	}
	public String getVideofile() {
		return videofile;
	}
	public void setVideofile(String videofile) {
		this.videofile = videofile;
	}
	public String getVideoname() {
		return videoname;
	}
	public void setVideoname(String videoname) {
		this.videoname = videoname;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	
	
	
	
	
	
}
