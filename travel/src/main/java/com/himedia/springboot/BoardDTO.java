package com.himedia.springboot;

import lombok.Data;

@Data
public class BoardDTO {
	
	int seqno;
	String writer;
	String title;
	String content;
	int hit;
	String created;
	String updated;
	String category;
	int answer_count;

}
