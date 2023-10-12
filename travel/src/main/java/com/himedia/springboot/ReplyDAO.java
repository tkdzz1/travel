package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReplyDAO {

	
	ArrayList<ReplyDTO> showreply(int parentid);
	
	int addReply(String s1, String s2, int s3, int s4); 
		
	int delete(int reply_id);
	
	int edtreply(int reply_id, String reply_content);
	
	void deleteByComment(int comment_parent_id);
}
