package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReplyDAO {

	
	ArrayList<ReplyDTO> showreply(int parentid);
	
	int addReply(String s1, String s2, int s3);
		
	void delete(int parentid);
}
