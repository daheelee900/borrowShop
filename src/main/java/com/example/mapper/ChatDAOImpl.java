package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.ChatVO;

@Repository
public class ChatDAOImpl implements ChatDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.MypageMapper";

	@Override
	public void chat_insert(ChatVO vo) {
		session.insert(namespace+".chat_insert",vo);
	}

	@Override
	public int last_no(String chat_id) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".lastNo",chat_id);
	}

	@Override
	public List<ChatVO> chatList() {
		// TODO Auto-generated method stub
		 return session.selectList(namespace+".chatList");
	}

	@Override
	public List<ChatVO> list(String chat_room) {
		// TODO Auto-generated method stub
	return session.selectList(namespace+".list",chat_room);
	}

}
