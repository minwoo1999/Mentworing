package com.jang.a260.dto;

import lombok.Data;

@Data
public class ChatVO {

	private int cno;
	private int no;
	private int mno;
	private String message;
	private String name;
	private String chat_date;
	private int roomno;
	private String messagecheck;
	private String messagecheck2;;

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getChat_date() {
		return chat_date;
	}

	public void setChat_date(String chat_date) {
		this.chat_date = chat_date;
	}

	public int getRoomno() {
		return roomno;
	}

	public void setRoomno(int roomno) {
		this.roomno = roomno;
	}

	public String getMessagecheck() {
		return messagecheck;
	}

	public void setMessagecheck(String messagecheck) {
		this.messagecheck = messagecheck;
	}

	public String getMessagecheck2() {
		return messagecheck2;
	}

	public void setMessagecheck2(String messagecheck2) {
		this.messagecheck2 = messagecheck2;
	}
	

	

}
