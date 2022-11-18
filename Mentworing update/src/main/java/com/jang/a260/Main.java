package com.jang.a260;

import java.io.File;


public class Main {

	   public AWSService awsS3 = AWSService.getInstance();

	   public static void main(String[] args) {

	      Main main = new Main();
	      File file = new File("C:\\upload\\um.jpg");

	      String key = "um3.jpg";
	      //String copyKey = "img/my-img-copy.img";

	      //upload 실행하기.
	      main.upload(file,key);

	   }

	   //업로드
	   public void upload(File file, String key) {
	      awsS3.upload(file, key);
	   }

	   //복사 메서드
	   public void copy(String orgkey, String copyKey) {
	      awsS3.copy(orgkey, copyKey);
	   }

	   //삭제 메서드
	   public void delete(String key) {
	      awsS3.delete(key);
	   }

	}

