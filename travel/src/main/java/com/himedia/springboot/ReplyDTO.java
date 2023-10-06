package com.himedia.springboot;

import lombok.Data;

@Data
public class ReplyDTO {
	
	int reply_id;
	int parent_comment_id; // comment의 comment_id로 받아 올 예정
	String commenter; // 작성자
	String reply_content; // 답글
	String reply_created; 

}
