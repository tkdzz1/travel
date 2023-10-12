package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface homeDAO {
	
	ArrayList<travel_attDTO> getCartList(int st, int ps, String id);
	ArrayList<travel_attDTO> getCartFilterList(int st, int ps, String id, String filter);
	int cntCartList(String id);
	travel_attDTO getChoice(int ta_num);
	travel_attDTO getMarker(int num);
	ArrayList<travel_attDTO> getFilterList(String id, String filter);
	
}
