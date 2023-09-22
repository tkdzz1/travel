package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface foodstoreDAO {

	
	//테스트
	ArrayList<foodstoreDTO> fsTest();
	
	
	
}
