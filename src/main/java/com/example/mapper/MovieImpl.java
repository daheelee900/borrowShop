package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
@Repository
public class MovieImpl implements MovieDAO{
	@Autowired
	SqlSession session;

	String namespace="com.example.mapper.MovieMapper";
	@Override
	public List<HashMap<String, Object>> list(Criteria cri) {
		return session.selectList(namespace+".list",cri) ;
	}
	@Override
	public int totalCount() {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".totalCount");
	}
	@Override
	public void insert(String title, String image) {
  HashMap<String,Object> map=new HashMap<>();
  map.put("title", title);
  map.put("image", image);
  session.insert(namespace+".insert",map);
	}

}
