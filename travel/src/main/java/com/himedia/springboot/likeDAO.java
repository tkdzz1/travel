package com.himedia.springboot;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface likeDAO {

	void addLike(String ta_category, String ta_name, String id, int ta_num);
	void removeLike(String ta_name, String id);
	int cntLike(String ta_name, String id);
	int totalLike(String ta_name);
	void delete(int ta_num, String id);

}
