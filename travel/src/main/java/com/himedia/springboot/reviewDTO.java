package com.himedia.springboot;

import lombok.Data;

@Data
public class reviewDTO {
	private int review_num;
	private String review_location;
	private String review_id;
	private int review_rating;
	private String review_content;
	private String review_created;
}
