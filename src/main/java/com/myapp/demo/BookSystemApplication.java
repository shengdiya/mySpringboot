package com.myapp.demo;

import org.mybatis.spring.annotation.MapperScan;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.myapp.demo.Dao")
public class BookSystemApplication {
	public static void main(String[] args) {
		SpringApplication.run(BookSystemApplication.class, args);
	}
}
