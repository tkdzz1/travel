package com.himedia.springboot;

public class CommentDTO {

	
	String comment_content;
	String comment_created;
	int board_seqno;
	int comment_id;
	String commenter;
	
	

	public int getBoard_seqno() {
		return board_seqno;
	}
	public void setBoard_seqno(int board_seqno) {
		this.board_seqno = board_seqno;
	}
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public String getCommenter() {
		return commenter;
	}
	public void setCommenter(String commenter) {
		this.commenter = commenter;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public String getComment_created() {
		return comment_created;
	}
	public void setComment_created(String comment_created) {
		this.comment_created = comment_created;
	}
	
}
