package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface foodstoreDAO {

	ArrayList<foodstoreDTO> get_fs();
	int cntFoodList();
	ArrayList<foodstoreDTO> getList(int a, int b);
	
}
