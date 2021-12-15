package com.example.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.NoticeMapper";
	@Override
	public List<NoticeVO> noticeList() {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".noticeList");
	}

}
