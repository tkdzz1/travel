package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface homeDAO {
	
	ArrayList<travel_attDTO> getCartList(int st, int ps, String id);
	int cntCartList(String id);
	travel_attDTO getChoice(int ta_num);
	ArrayList<travel_attDTO> getMarker(int num);
	
}
