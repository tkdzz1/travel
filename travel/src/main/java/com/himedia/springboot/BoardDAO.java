package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {

	ArrayList<BoardDTO> getList(int start, int psize);
	int getTotal();
	
	void insert(String p1, String p2, String p3, String p4, int p5);
	
	BoardDTO view(int seqno);
	void hitup(int seqno);
	
	void deletePost(int seqno);
	
	
	void editPost(int seqno, String title, String content, String Category);
	
	ArrayList<BoardDTO> popular();
	
	void answerCount(int seqno,int s);
	
	ArrayList<BoardDTO> getboardlist(); // 임시 7개만 출력
	
}
