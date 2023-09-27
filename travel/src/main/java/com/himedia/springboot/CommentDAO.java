package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentDAO {

	
	int addComment(String s1, String s2, int s3);
	
	ArrayList<CommentDTO> showComment(int boardSeqno);
	
	void deleteComment(int seqno, int comment_id);
	
	int editComment(int board_seqno, String content, int n);
}
