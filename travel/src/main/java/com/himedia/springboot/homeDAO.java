package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface homeDAO {
	
	ArrayList<travel_attDTO> getCartList(int st, int ps, String id);
	ArrayList<travel_attDTO> getCartFilterList(int st, int ps, String id, String filter);
	int cntCartList(String id);
	int cntCartFilterList(String id, String filter);
	travel_attDTO getChoice(int ta_num);
	travel_attDTO getMarker(int num);
	int savePlan(String writer, String title, String days, String start, String end, String people, String party, String allDay);
	ArrayList<travel_attDTO> showALL(int st, int ps);
	int cntShowALL();
	ArrayList<homeDTO> getPlanList(String id);
	int cntPlanList(String id);
	homeDTO getPlanner(String id, int num);
}
