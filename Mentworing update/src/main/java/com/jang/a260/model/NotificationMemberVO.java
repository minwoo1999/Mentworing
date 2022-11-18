package com.jang.a260.model;

public class NotificationMemberVO {

	private String name;
	private int notificationnumber;
	private String memberprofile;
	private int mno;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getNotificationnumber() {
		return notificationnumber;
	}

	public void setNotificationnumber(int notificationnumber) {
		this.notificationnumber = notificationnumber;
	}

	public String getMemberprofile() {
		return memberprofile;
	}

	public void setMemberprofile(String memberprofile) {
		this.memberprofile = memberprofile;
	}

	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

	@Override
	public String toString() {
		return "NotificationMemberVO [name=" + name + ", notificationnumber=" + notificationnumber + ", memberprofile="
				+ memberprofile + ", mno=" + mno + "]";
	}
	
	

}
