package com.himedia.springboot;

import lombok.Data;

@Data
public class travel_attDTO {
	
	private int ta_num;
	private String ta_name;
	private String ta_content;
	private	String ta_local;
	private	String ta_img;
	private	String ta_address;
	private	String ta_category;
	private	double ta_latitude;
	private double ta_longitude;
	private String ta_imginfo;
	private int ta_hit;

}
