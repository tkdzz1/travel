package com.himedia.springboot;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface cartDAO {

	void addCart(String ta_name, String ta_category, int ta_num, String id);
	int cntCart(String ta_name, String id);
	void removeCart(String ta_name, String id);
	int totalCart(String ta_name);
	void delete(int ta_num, String id);

}
