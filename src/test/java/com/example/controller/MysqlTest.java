package com.example.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.example.domain.Criteria;
import com.example.mapper.MovieDAO;

@RunWith(SpringJUnit4ClassRunner.class) //???? SpringJUnit4ClassRunner.class import?Ѵ?. 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MysqlTest {
	@Autowired
	private MovieDAO dao;
	
	@Test
	public void getTime() { 
		Criteria cri=new Criteria();
		dao.list(cri);
	}
}
