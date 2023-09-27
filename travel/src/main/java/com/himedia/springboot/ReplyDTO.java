package com.himedia.springboot;

public class ReplyDTO {
	
	
	int reply_id;
	int parent_comment_id; // comment의 comment_id로 받아 올 예정
	String commenter; // 작성자
	String reply_content; // 답글
	String created; 
	
	
	public int getReply_id() {
		return reply_id;
	}
	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}
	public int getParent_comment_id() {
		return parent_comment_id;
	}
	public void setParent_comment_id(int parent_comment_id) {
		this.parent_comment_id = parent_comment_id;
	}
	public String getCommenter() {
		return commenter;
	}
	public void setCommenter(String commenter) {
		this.commenter = commenter;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
}
