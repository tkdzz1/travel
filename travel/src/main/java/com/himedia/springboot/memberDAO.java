package com.himedia.springboot;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface memberDAO {
	int memberCheck(String email);
	void signup(String email, String password);
	int login(String email, String password);
	String socialCheck(String email);
}
