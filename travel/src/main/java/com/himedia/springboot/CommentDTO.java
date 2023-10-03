package com.himedia.springboot;

import lombok.Data;

@Data
public class CommentDTO {

	String comment_content;
	String comment_created;
	int board_seqno;
	int comment_id;
	String commenter;
	
}
