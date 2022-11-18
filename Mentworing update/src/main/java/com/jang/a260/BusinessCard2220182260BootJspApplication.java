package com.jang.a260;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude=SecurityAutoConfiguration.class)
public class BusinessCard2220182260BootJspApplication {

	public static void main(String[] args) {
		SpringApplication.run(BusinessCard2220182260BootJspApplication.class, args);
	}

}
