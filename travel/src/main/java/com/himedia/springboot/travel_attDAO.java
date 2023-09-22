package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface travel_attDAO {

	ArrayList<travel_attDTO> getList(int start, int psize);
	ArrayList<travel_attDTO> getmaker();
	void addlist(String name, String local, String savedMainName, String address, String category, double latitude, double longitude);
	int cntlist();
	travel_attDTO getdetail(String ta_name);
	void addimginfo(String name, String savedImageName, String taContent);
	void deletelist(String ta_name);
	travel_attDTO getdetailimg(String ta_name);
	void deletedetail(String ta_name);
	ArrayList<travel_attDTO> locationName();
	void updateTravelAttraction(String name, String string, String taContent);
	void updatelist1(String name, String local, String address, String category, String savedListImageName, String ta_name);
	void updatelist2(String name, String local, String address, String category, String ta_name);
	void updatedetailinfo(String name, String ta_name);
}
