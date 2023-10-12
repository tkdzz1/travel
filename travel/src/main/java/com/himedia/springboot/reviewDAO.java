package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface reviewDAO {
	ArrayList<reviewDTO> getReviewList(String ta_name, int start, int psize);
	reviewDTO getReview(String ta_name);
	void deleteReview(int reviewNum);
	void deletelist(String ta_name);
	int cntReviewList(String ta_name);
	void updateContent(int reviewNum, String updateContent, int rating);
	void delete(String ta_name);
}
