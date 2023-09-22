package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {

	ArrayList<BoardDTO> getList(int start, int psize);
	int getTotal();
	
	
	BoardDTO view(int seqno);
	void hitup(int seqno);
	
}
