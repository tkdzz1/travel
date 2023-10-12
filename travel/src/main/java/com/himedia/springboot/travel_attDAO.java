package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface travel_attDAO {

	ArrayList<travel_attDTO> getList(int start, int psize, String string);
	ArrayList<travel_attDTO> getmaker();
	void addTravelList(String name, String local, String savedMainName, String address, String category, double latitude, double longitude);
	int cntTravelList(String string);
	travel_attDTO getDetail(String ta_name);
	void addImgInfo(String name, String savedImageName, String taContent);
	void deleteList(String ta_name);
	travel_attDTO getDetailImg(String ta_name);
	void deleteTravel_attraction(String ta_name);
	ArrayList<travel_attDTO> locationName();
	ArrayList<travel_attDTO> foodStore();
	ArrayList<travel_attDTO> shopping();
	ArrayList<travel_attDTO> hotel();
	void updateTravelAttraction(String name, String string, String taContent);
	void updateList1(String name, String local, String address, String category, String savedListImageName, String ta_name);
	void updateList2(String name, String local, String address, String category, String ta_name);
	void updateDetailInfo(String name, String ta_name);
	void updateContent(String ta_name, String updatedContent);
	void hitup(String ta_name);
	void insertReview(String ta_name, String id, int rating, String reviewContents);
	void delete(String ta_name);
}
