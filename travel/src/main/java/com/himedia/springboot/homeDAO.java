package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface homeDAO {
	ArrayList<travel_attDTO> getLikeList(String id);
}
