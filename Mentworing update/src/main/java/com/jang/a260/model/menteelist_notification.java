package com.jang.a260.model;

import javax.validation.constraints.NotEmpty;

public class menteelist_notification {

	private String name;
	private int notificationnumber;
	private int roomno;
	
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
	public int getRoomno() {
		return roomno;
	}
	public void setRoomno(int roomno) {
		this.roomno = roomno;
	}
	
	
	public menteelist_notification(String name,int notificationnumber,int roomno){
        this.name =  name;
        this.notificationnumber = notificationnumber;
        this.roomno=roomno;

    }
	
	

}
