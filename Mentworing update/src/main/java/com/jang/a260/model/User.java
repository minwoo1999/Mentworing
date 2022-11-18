package com.jang.a260.model;

import javax.validation.constraints.NotEmpty;

public class User {

	private int no;
	@NotEmpty(message = "id가 입력되지 않았습니다.!")
	private String id;
	@NotEmpty(message = "패스워드가 입력되지 않았습니다.!")
	private String pass;
	private String pass2;
	@NotEmpty(message="이름이 입력되지 않았습니다")
	private String name;
	@NotEmpty(message="우편번호가 입력되지 않았습니다")
	private String zip;
	@NotEmpty(message="주소가가 입력되지 않았습니다")
	private String addr1;
	@NotEmpty(message="상세주소가 입력되지 않았습니다")
	private String addr2;
	@NotEmpty(message="전화번호가 입력되지 않았습니다")
	private String phone;
	@NotEmpty(message="email 입력되지 않았습니다")
	private String email;
	
	private String birthday;
	
	

	public String getPass2() {
		return pass2;
	}

	public void setPass2(String pass2) {
		this.pass2 = pass2;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

}
